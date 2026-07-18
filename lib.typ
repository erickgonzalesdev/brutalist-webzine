// brutalist-webzine — a typst template for raw, structural, print+web zines
// ----------------------------------------------------------------------------
// Design language:
//   - Exposed structure: borders, rules, grids are visible
//   - Raw typography: monospace + grotesque mix, no decoration
//   - High contrast: black/white base with optional accent
//   - Anti-polish: misaligned elements are features, not bugs

// ─── PALETTE ─────────────────────────────────────────────────────────────────

#let colors = (
  ink:    black,
  paper:  white,
  accent: rgb("#ff2d00"),
  mid:    rgb("#888888"),
)

// ─── TYPOGRAPHY ──────────────────────────────────────────────────────────────

#let fonts = (
  body:    ("Noto Sans", "Liberation Sans", "FreeSans"),
  display: ("Noto Sans", "Liberation Sans", "FreeSans"),
  alt:     ("Liberation Mono", "FreeMono"),
)

// ─── PAGE PRESETS ────────────────────────────────────────────────────────────

#let page-presets = (
  letter:  (width: 8.5in,  height: 11in),
  a4:      (width: 210mm,  height: 297mm),
  tabloid: (width: 11in,   height: 17in),
  half:    (width: 5.5in,  height: 8.5in),
)

// ─── INTERNAL: SHARED STYLES ─────────────────────────────────────────────────

#let _apply-styles(accent, ink, paper, body) = {
  set text(
    font:      fonts.body,
    size:      9.5pt,
    fill:      ink,
    hyphenate: false,
  )

  set par(
    justify:   true,
    leading:   0.65em,
    spacing:   1.1em,
  )

  set heading(numbering: none)

  show heading.where(level: 1): it => block(
    width: 100%,
    above: 2em,
    below: 0.5em,
  )[
    #text(
      font:    fonts.display,
      size:    22pt,
      weight:  "bold",
      fill:    ink,
      it.body,
    )
    #v(0.2em)
    #line(length: 100%, stroke: 0.5pt + ink)
  ]

  show heading.where(level: 2): it => block(
    above: 1.4em,
    below: 0.3em,
  )[
    #text(
      font:   fonts.display,
      size:   13pt,
      weight: "bold",
      fill:   accent,
      it.body,
    )
  ]

  show heading.where(level: 3): it => block(
    above: 1em,
    below: 0.2em,
  )[
    #text(
      font:    fonts.display,
      size:    9.5pt,
      weight:  "bold",
      fill:    ink,
      upper(it.body),
    )
  ]

  show strong: it => text(weight: "bold", fill: ink, it.body)

  show emph: it => text(style: "italic", it.body)

  set page(fill: paper)

  show raw: it => box(
    fill:   if paper == black { rgb("#1a1a1a") } else { rgb("#f4f4f4") },
    stroke: 0.5pt + colors.mid,
    inset:  (x: 4pt, y: 3pt),
    radius: 0pt,
  )[
    #text(font: fonts.alt, size: 8.5pt, it)
  ]

  show raw.where(block: true): it => block(
    width:  100%,
    fill:   if paper == black { rgb("#0d0d0d") } else { rgb("#f4f4f4") },
    stroke: (left: 2pt + accent),
    inset:  (left: 12pt, right: 8pt, y: 8pt),
    radius: 0pt,
    above:  1em,
    below:  1em,
  )[
    #text(font: fonts.alt, size: 8.5pt, it)
  ]

  show link: it => underline(stroke: 0.75pt + accent, offset: 2pt, it)

  show figure: it => block(
    above: 1.5em,
    below: 1.5em,
    width: 100%,
  )[
    #box(
      stroke: 0.5pt + colors.mid,
      inset:  0pt,
      width:  100%,
    )[#it.body]
    #if it.caption != none {
      block(
        inset: (x: 0pt, y: 4pt),
        width: 100%,
      )[
        #text(font: fonts.alt, size: 7.5pt, fill: colors.mid)[
          Fig. #it.counter.display() — #it.caption.body
        ]
      ]
    }
  ]

  body
}

// ─── INTERNAL: MASTHEAD BLOCK ────────────────────────────────────────────────

#let _masthead(title, issue, date, accent, ink) = {
  block(width: 100%, below: 0pt)[
    #grid(
      columns: (1fr, auto),
      align:   (left + bottom, right + bottom),
      gutter:  0pt,
    )[
      #text(
        font:     fonts.display,
        size:     36pt,
        weight:   "bold",
        fill:     ink,
        tracking: -0.5pt,
        title,
      )
    ][
      #align(right)[
        #text(font: fonts.alt, size: 7.5pt, fill: colors.mid)[
          #upper("Issue " + issue + "  " + date)
        ]
      ]
    ]
  ]
  block(above: 4pt, below: 0pt)[
    #line(length: 100%, stroke: 1.5pt + ink)
  ]
  v(1.2em)
}

// ─── INTERNAL: FOOTER BLOCK ──────────────────────────────────────────────────

#let _footer(title, issue, date, margins, ink) = {
  place(
    bottom + left,
    dy: margins - 0.25in,
    block(width: 100% + 2 * margins, inset: (x: margins, y: 3pt))[
      #line(length: 100%, stroke: 0.5pt + ink)
      #v(2pt)
      #grid(
        columns: (1fr, 1fr, 1fr),
        align:   (left, center, right),
      )[
        #text(font: fonts.alt, size: 7pt, fill: colors.mid)[
          #upper(title + " — " + issue)
        ]
      ][
        #text(font: fonts.alt, size: 7pt, fill: colors.mid)[#date]
      ][
        #context text(font: fonts.alt, size: 7pt, fill: colors.mid)[
          #counter(page).display("1 / 1", both: true)
        ]
      ]
    ],
  )
}

// ─── PRINT TEMPLATE ──────────────────────────────────────────────────────────

/// Full print template — sets page size, runs masthead/footer, applies styles.
/// Use `#show: webzine.with(...)` at the top of your document.
///
/// Parameters:
///   title    [str]    - publication title
///   issue    [str]    - issue number/label
///   date     [str]    - date string
///   cols     [int]    - body column count (1–4)
///   accent   [color]  - accent color
///   format   [str]    - "letter" | "a4" | "tabloid" | "half"
///   margins  [length] - page margins
///   dark     [bool]   - dark mode
#let webzine(
  title:   "ZINE",
  issue:   "#1",
  date:    "2024",
  cols:    2,
  accent:  rgb("#ff2d00"),
  format:  "letter",
  margins: 0.75in,
  dark:    false,
  body,
) = {
  let preset = page-presets.at(format)
  let ink   = if dark { white } else { colors.ink }
  let paper = if dark { black } else { colors.paper }

  set page(
    width:  preset.width,
    height: preset.height,
    margin: margins,
    fill:   paper,
  )

  show: _apply-styles.with(accent, ink, paper)

  _masthead(title, issue, date, accent, ink)

  if cols <= 1 {
    body
  } else {
    columns(cols, gutter: 1.5em, body)
  }

  _footer(title, issue, date, margins, ink)
}

// ─── HTML / WEB TEMPLATE ─────────────────────────────────────────────────────

/// Web/HTML template — applies styles and masthead only (no page config).
/// Use `#show: webzine-html.with(...)` for `typst compile --features html --format html`.
/// The footer is omitted since HTML is continuous scroll.
///
/// Parameters: same as `webzine`, minus `format` and `margins`.
#let webzine-html(
  title:  "ZINE",
  issue:  "#1",
  date:   "2024",
  accent: rgb("#ff2d00"),
  dark:   false,
  body,
) = {
  let ink   = if dark { white } else { colors.ink }
  let paper = if dark { black } else { colors.paper }

  show: _apply-styles.with(accent, ink, paper)

  _masthead(title, issue, date, accent, ink)

  body
}

// ─── COMPONENT LIBRARY ───────────────────────────────────────────────────────

/// Full-width section divider with label
#let section(label) = context {
  let ink   = text.fill
  let paper = page.fill
  block(
    width: 100%,
    above: 2em,
    below: 1em,
  )[
    #grid(
      columns: (auto, 1fr),
      gutter:  0.75em,
      align:   center + horizon,
    )[
      #text(font: fonts.display, size: 8pt, fill: ink, weight: "bold", upper(label))
    ][
      #line(length: 100%, stroke: 0.5pt + ink)
    ]
  ]
}

/// Pull quote
#let pull-quote(attribution: none, body) = context {
  let ink = text.fill
  block(
    width:  100%,
    above:  1.8em,
    below:  1.8em,
    stroke: (left: 2pt + ink),
    inset:  (left: 14pt, y: 4pt),
  )[
    #text(font: fonts.display, size: 16pt, weight: "bold", fill: ink)[#body]
    #if attribution != none {
      v(0.4em)
      text(font: fonts.alt, size: 7.5pt, fill: colors.mid, "— " + attribution)
    }
  ]
}

/// Sidebar/callout box
#let callout(title: none, accent: colors.accent, body) = context {
  let ink   = text.fill
  let paper = page.fill
  block(
    width:  100%,
    above:  1em,
    below:  1em,
    stroke: (left: 2pt + accent),
    inset:  (left: 10pt, right: 0pt, y: 6pt),
  )[
    #if title != none {
      block(below: 4pt)[
        #text(font: fonts.display, size: 8pt, fill: accent, weight: "bold", upper(title))
      ]
    }
    #body
  ]
}

/// Manifesto/declaration block — centered, caps, inverted
#let manifesto(body) = context {
  let ink   = text.fill
  let paper = page.fill
  block(
    width: 100%,
    above: 2em,
    below: 2em,
    fill:  ink,
    inset: (x: 20pt, y: 14pt),
  )[
    #align(left)[
      #text(
        font:     fonts.display,
        size:     13pt,
        weight:   "bold",
        fill:     paper,
        tracking: 0.5pt,
        body,
      )
    ]
  ]
}

/// Hero image frame with stark border
#let hero(caption: none, body) = context {
  let ink   = text.fill
  let paper = page.fill
  block(
    width:  100%,
    above:  1em,
    below:  1em,
    stroke: 0.5pt + colors.mid,
    inset:  0pt,
  )[
    #body
    #if caption != none {
      block(
        inset: (x: 6pt, y: 4pt),
        width: 100%,
      )[
        #text(font: fonts.alt, size: 7.5pt, fill: colors.mid, upper(caption))
      ]
    }
  ]
}

/// Two-column comparison grid
#let compare(left-label: "A", right-label: "B", left, right) = context {
  let ink   = text.fill
  let paper = page.fill
  block(
    width: 100%,
    above: 1em,
    below: 1em,
  )[
    #grid(
      columns: (1fr, 1fr),
      gutter:  1.5em,
    )[
      #block(below: 4pt)[
        #text(font: fonts.display, size: 8pt, fill: colors.mid, weight: "bold", upper(left-label))
      ]
      #line(length: 100%, stroke: 0.5pt + ink)
      #v(0.4em)
      #left
    ][
      #block(below: 4pt)[
        #text(font: fonts.display, size: 8pt, fill: accent, weight: "bold", upper(right-label))
      ]
      #line(length: 100%, stroke: 0.5pt + ink)
      #v(0.4em)
      #right
    ]
  ]
}

/// Inline tag/label chip
#let tag(body) = context {
  let ink   = text.fill
  let paper = page.fill
  box(
    stroke: 0.5pt + ink,
    inset:  (x: 5pt, y: 2pt),
    radius: 0pt,
  )[
    #text(font: fonts.display, size: 7pt, fill: ink, weight: "bold", upper(body))
  ]
}

/// Horizontal rule, optionally labeled
#let zrule(label: none) = context {
  let ink = text.fill
  block(width: 100%, above: 1em, below: 1em)[
    #if label == none {
      line(length: 100%, stroke: 0.5pt + ink)
    } else {
      grid(
        columns: (1fr, auto, 1fr),
        gutter:  0.75em,
        align:   center + horizon,
      )[
        #line(length: 100%, stroke: 0.5pt + ink)
      ][
        #text(font: fonts.alt, size: 7pt, fill: colors.mid, upper(label))
      ][
        #line(length: 100%, stroke: 0.5pt + ink)
      ]
    }
  ]
}

/// TOC entry row
#let toc-entry(title, page-num, blurb: none) = context {
  let ink   = text.fill
  let paper = page.fill
  block(
    above: 0.4em,
    below: 0.4em,
  )[
    #grid(
      columns: (1fr, auto),
      gutter:  1em,
      align:   (left + top, right + top),
    )[
      #text(font: fonts.display, size: 9.5pt, weight: "bold", fill: ink, title)
      #if blurb != none {
        parbreak()
        text(font: fonts.body, size: 8pt, fill: colors.mid, blurb)
      }
    ][
      #text(font: fonts.alt, size: 9pt, fill: colors.mid, str(page-num))
    ]
    #v(0.3em)
    #line(length: 100%, stroke: 0.5pt + colors.mid)
  ]
}

/// Rotated sticker/badge element
#let sticker(angle: -8deg, fill: colors.accent, body) = rotate(
  angle,
  box(
    fill:   fill,
    stroke: 1pt + colors.ink,
    inset:  (x: 8pt, y: 6pt),
  )[
    #text(font: fonts.display, size: 11pt, fill: colors.paper, weight: "bold", upper(body))
  ],
)

/// Byline
#let byline(name, role: none, date: none) = block(above: 0.2em, below: 0.8em)[
  #text(font: fonts.alt, size: 7.5pt, fill: colors.mid)[
    #if role != none [#upper(role): ]
    #name
    #if date != none [ — #date]
  ]
]

// ─── CONVENIENCE RE-EXPORTS ──────────────────────────────────────────────────

#let accent      = colors.accent
#let zine-fonts  = fonts
#let zine-colors = colors
