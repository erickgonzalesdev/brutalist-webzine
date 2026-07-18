#import "@preview/meander:0.4.3"

// brutalist-webzine — a typst template for raw, structural, print+web zines
// ----------------------------------------------------------------------------
// Design language:
//   - New Wave / Weingart / Emigre: broken grid, type collision, oblique energy
//   - Mixed weights and sizes as texture, not hierarchy
//   - Rules that don't align, spacing that is deliberate but not regular
//   - Monospace and grotesque in tension, not resolution

// ─── PALETTE ─────────────────────────────────────────────────────────────────

#let colors = (
  ink:    black,
  paper:  white,
  accent: rgb("#ff2d00"),
  mid:    rgb("#777777"),
)

// ─── TYPOGRAPHY ──────────────────────────────────────────────────────────────

#let fonts = (
  body:    ("Liberation Mono", "FreeMono"),
  display: ("Space Grotesk", "Aporetic Sans", "Noto Sans", "Liberation Sans"),
  alt:     ("Space Grotesk", "Aporetic Sans", "Noto Sans", "Liberation Sans"),
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
    size:      9pt,
    fill:      ink,
    hyphenate: false,
  )

  set par(
    justify: true,
    leading: 0.7em,
    spacing: 1.2em,
  )

  set heading(numbering: none)

  show heading.where(level: 1): it => block(
    width: 100%,
    above: 3em,
    below: 1em,
  )[
    #v(-0.4em)
    #text(
      font:     fonts.body,
      size:     8pt,
      fill:     colors.accent,
      tracking: 3pt,
      upper("——  article"),
    )
    #v(2pt)
    #block(spacing: 0pt)[
      #set par(leading: 0.78em)
      #text(
        font:   fonts.display,
        size:   32pt,
        weight: 300,
        fill:   ink,
        it.body,
      )
    ]
    #v(6pt)
    #grid(
      columns: (2fr, 1fr),
      gutter:  0pt,
    )[
      #line(length: 100%, stroke: 2pt + ink)
    ][
      #line(length: 100%, stroke: 0.5pt + accent)
    ]
  ]

  show heading.where(level: 2): it => block(
    above: 1.6em,
    below: 0.3em,
  )[
    #text(
      font:   fonts.display,
      size:   13pt,
      weight: 300,
      fill:   ink,
      it.body,
    )
    #h(0.4em)
    #text(
      font:  fonts.body,
      size:  8pt,
      fill:  accent,
      "///",
    )
  ]

  show heading.where(level: 3): it => block(
    above: 1em,
    below: 0.2em,
  )[
    #text(
      font:     fonts.body,
      size:     8pt,
      fill:     colors.mid,
      tracking: 1pt,
      upper(it.body),
    )
  ]

  show strong: it => text(font: fonts.display, weight: "bold", fill: ink, it.body)

  show emph: it => text(
    font:     fonts.display,
    style:    "italic",
    fill:     ink,
    it.body,
  )

  set page(fill: paper)

  show raw: it => box(
    fill:   if paper == black { rgb("#111111") } else { rgb("#eeeeee") },
    stroke: (bottom: 1.5pt + accent),
    inset:  (x: 4pt, y: 3pt),
  )[
    #text(font: fonts.body, size: 8.5pt, it)
  ]

  show raw.where(block: true): it => block(
    width:  100%,
    fill:   if paper == black { rgb("#0a0a0a") } else { rgb("#eeeeee") },
    stroke: (left: 4pt + accent, bottom: 1pt + ink),
    inset:  (left: 14pt, right: 8pt, y: 10pt),
    above:  1.2em,
    below:  1.2em,
  )[
    #text(font: fonts.body, size: 8.5pt, it)
  ]

  show link: it => underline(stroke: 1pt + accent, offset: 3pt, it)

  show figure: it => block(
    above: 1.5em,
    below: 1.5em,
    width: 100%,
  )[
    #box(stroke: (top: 3pt + ink, bottom: 0.5pt + accent), inset: 0pt, width: 100%)[
      #it.body
    ]
    #if it.caption != none {
      block(inset: (x: 0pt, y: 5pt), width: 100%)[
        #text(font: fonts.body, size: 7.5pt, fill: colors.mid)[
          #text(fill: colors.accent)["/ "]fig. #it.counter.display() — #it.caption.body
        ]
      ]
    }
  ]

  body
}

// ─── INTERNAL: MASTHEAD BLOCK ────────────────────────────────────────────────

#let _masthead(title, issue, date, accent, ink, paper) = {
  block(width: 100%, below: 0pt)[
    #text(
      font:     fonts.body,
      size:     7.5pt,
      fill:     colors.accent,
      tracking: 2pt,
      upper("No. " + issue + "  ·  " + date),
    )
    #v(4pt)
    #block(spacing: 0pt)[
      #set par(leading: 0.72em)
      #text(
        font:     fonts.display,
        size:     52pt,
        weight:   300,
        fill:     ink,
        tracking: -2pt,
        upper(title),
      )
    ]
    #v(2pt)
    #grid(
      columns: (1fr, 28pt, 1fr),
      gutter:  0pt,
      align:   horizon,
    )[
      #line(length: 100%, stroke: 4pt + ink)
    ][
      #block(
        width:  28pt,
        height: 4pt,
        fill:   accent,
      )[]
    ][
      #line(length: 100%, stroke: 0.5pt + ink)
    ]
  ]
  v(1.6em)
}

// ─── INTERNAL: FOOTER BLOCK ──────────────────────────────────────────────────

#let _footer(title, issue, date, margins, ink, accent) = {
  place(
    bottom + left,
    dy: margins - 0.25in,
    block(width: 100% + 2 * margins, inset: (x: margins, y: 4pt))[
      #grid(
        columns: (auto, 1fr, auto),
        gutter:  8pt,
        align:   horizon,
      )[
        #block(width: 6pt, height: 6pt, fill: colors.accent)[]
      ][
        #line(length: 100%, stroke: 0.5pt + ink)
      ][
        #text(font: fonts.body, size: 7pt, fill: colors.mid)[
          #upper(title) · #issue · #date ·
          #context counter(page).display("1")
        ]
      ]
    ],
  )
}

// ─── PRINT TEMPLATE ──────────────────────────────────────────────────────────

/// Full print template.
/// Use `#show: webzine.with(...)` at the top of your document.
#let webzine(
  title:          "ZINE",
  issue:          "#1",
  date:           "2024",
  cols:           2,
  accent:         rgb("#ff2d00"),
  format:         "letter",
  margins:        0.75in,
  dark:           false,
  show-masthead:  true,
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

  if show-masthead {
    _masthead(title, issue, date, accent, ink, paper)
  }

  if cols <= 1 {
    body
  } else {
    columns(cols, gutter: 1.5em, body)
  }

  _footer(title, issue, date, margins, ink, accent)
}

// ─── HTML / WEB TEMPLATE ─────────────────────────────────────────────────────

/// Web/HTML template.
/// Use `#show: webzine-html.with(...)` for HTML export.
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

  _masthead(title, issue, date, accent, ink, paper)

  body
}

// ─── COMPONENT LIBRARY ───────────────────────────────────────────────────────

/// Section divider — rotated label, asymmetric rules
#let section(label) = context {
  let ink   = text.fill
  let paper = page.fill
  block(
    width: 100%,
    above: 3em,
    below: 1.5em,
  )[
    #grid(
      columns: (auto, 1fr),
      gutter:  10pt,
      align:   horizon,
    )[
      #rotate(-90deg, reflow: true)[
        #text(
          font:     fonts.body,
          size:     6.5pt,
          fill:     colors.accent,
          tracking: 2pt,
          upper(label),
        )
      ]
    ][
      #line(length: 100%, stroke: 1.5pt + ink)
      #v(3pt)
      #line(length: 70%, stroke: 0.5pt + colors.mid)
    ]
  ]
}

/// Pull quote — type collision, weight contrast
#let pull-quote(attribution: none, body) = context {
  let ink   = text.fill
  let paper = page.fill
  block(
    width: 100%,
    above: 2.5em,
    below: 2.5em,
  )[
    #text(
      font:     fonts.body,
      size:     7pt,
      fill:     colors.accent,
      tracking: 2pt,
      upper("  quote  "),
    )
    #v(-2pt)
    #block(
      stroke: (left: 5pt + ink, top: 0.5pt + colors.accent),
      inset:  (left: 14pt, top: 10pt, right: 0pt, bottom: 4pt),
    )[
      #block(spacing: 0pt)[
        #set par(leading: 0.8em)
        #text(font: fonts.display, size: 21pt, weight: 300, fill: ink)[#body]
      ]
      #if attribution != none {
        v(0.8em)
        grid(
          columns: (auto, 1fr),
          gutter:  6pt,
          align:   horizon,
        )[
          #block(width: 16pt, height: 0.75pt, fill: colors.accent)[]
        ][
          #text(font: fonts.body, size: 7pt, fill: colors.mid, tracking: 0.5pt, upper(attribution))
        ]
      }
    ]
  ]
}

/// Callout — mixed font label, left bar
#let callout(title: none, accent: colors.accent, body) = context {
  let ink   = text.fill
  let paper = page.fill
  block(
    width:  100%,
    above:  1.4em,
    below:  1.4em,
    stroke: (left: 3pt + ink),
    inset:  (left: 12pt, right: 0pt, y: 8pt),
  )[
    #if title != none {
      block(below: 6pt)[
        #text(font: fonts.display, size: 7.5pt, weight: "bold", fill: colors.accent, upper(title))
        #h(3pt)
        #text(font: fonts.body, size: 7pt, fill: colors.mid, "___")
      ]
    }
    #body
  ]
}

/// Manifesto — layered type, first line oversized
#let manifesto(body) = context {
  let ink   = text.fill
  let paper = page.fill
  block(
    width: 100%,
    above: 3em,
    below: 3em,
    fill:  ink,
    inset: (x: 14pt, top: 18pt, bottom: 14pt),
  )[
    #text(
      font:     fonts.body,
      size:     6.5pt,
      fill:     colors.accent,
      tracking: 3pt,
      upper("  statement  "),
    )
    #v(6pt)
    #block(spacing: 0pt)[
      #set par(leading: 0.82em)
      #text(
        font:     fonts.display,
        size:     34pt,
        weight:   300,
        fill:     paper,
        tracking: -0.5pt,
        body,
      )
    ]
    #v(14pt)
    #grid(
      columns: (1fr, 20pt, 1fr),
      gutter:  0pt,
      align:   horizon,
    )[
      #line(length: 100%, stroke: 0.5pt + colors.mid)
    ][
      #block(width: 20pt, height: 3pt, fill: colors.accent)[]
    ][
      #line(length: 100%, stroke: 0.5pt + colors.mid)
    ]
  ]
}

/// Hero image frame
#let hero(caption: none, body) = context {
  let ink   = text.fill
  let paper = page.fill
  block(
    width: 100%,
    above: 1.2em,
    below: 1.2em,
  )[
    #box(
      stroke: (top: 3pt + ink, left: 3pt + ink, right: 0.5pt + colors.mid, bottom: 0.5pt + colors.mid),
      inset:  0pt,
      width:  100%,
    )[#body]
    #if caption != none {
      block(inset: (x: 0pt, y: 5pt), width: 100%)[
        #text(font: fonts.body, size: 7pt, fill: colors.mid)[
          #text(fill: colors.accent)["/ "]#upper(caption)
        ]
      ]
    }
  ]
}

/// Two-column comparison
#let compare(left-label: "A", right-label: "B", left, right) = context {
  let ink   = text.fill
  let paper = page.fill
  block(width: 100%, above: 1.5em, below: 1.5em)[
    #grid(
      columns: (1fr, 2pt, 1fr),
      gutter:  10pt,
      align:   top,
    )[
      #block(below: 5pt)[
        #text(font: fonts.display, size: 9pt, weight: "bold", fill: ink, left-label)
        #h(4pt)
        #text(font: fonts.body, size: 7pt, fill: colors.accent, "//")
      ]
      #line(length: 100%, stroke: 1pt + ink)
      #v(5pt)
      #left
    ][
      #block(width: 2pt, fill: colors.mid, height: 100%)[]
    ][
      #block(below: 5pt)[
        #text(font: fonts.display, size: 9pt, weight: "bold", fill: colors.accent, right-label)
        #h(4pt)
        #text(font: fonts.body, size: 7pt, fill: ink, "//")
      ]
      #line(length: 100%, stroke: 0.5pt + colors.mid)
      #v(5pt)
      #right
    ]
  ]
}

/// Inline tag
#let tag(body) = context {
  let ink   = text.fill
  let paper = page.fill
  box(
    stroke: (bottom: 1.5pt + colors.accent, top: 0.5pt + ink),
    inset:  (x: 4pt, y: 2pt),
  )[
    #text(font: fonts.body, size: 7pt, fill: ink, tracking: 0.5pt, upper(body))
  ]
}

/// Horizontal rule — asymmetric, labeled
#let zrule(label: none) = context {
  let ink   = text.fill
  let paper = page.fill
  block(width: 100%, above: 1.4em, below: 1.4em)[
    #if label == none {
      grid(
        columns: (2fr, 4pt, 1fr),
        gutter:  0pt,
        align:   horizon,
      )[
        #line(length: 100%, stroke: 1.5pt + ink)
      ][
        #block(width: 4pt, height: 4pt, fill: colors.accent)[]
      ][
        #line(length: 100%, stroke: 0.5pt + colors.mid)
      ]
    } else {
      grid(
        columns: (auto, 1fr, auto),
        gutter:  8pt,
        align:   center + horizon,
      )[
        #text(font: fonts.body, size: 7pt, fill: colors.accent, tracking: 1.5pt, upper(label))
      ][
        #line(length: 100%, stroke: 0.5pt + ink)
      ][
        #text(font: fonts.body, size: 7pt, fill: colors.mid, "·")
      ]
    }
  ]
}

/// TOC entry
#let toc-entry(title, page-num, blurb: none) = context {
  let ink   = text.fill
  let paper = page.fill
  block(above: 0pt, below: 0pt)[
    #grid(
      columns: (auto, 1fr, auto),
      gutter:  6pt,
      align:   (left + horizon, horizon, right + horizon),
    )[
      #text(font: fonts.body, size: 7pt, fill: colors.accent, str(page-num))
    ][
      #line(length: 100%, stroke: 0.5pt + colors.mid)
    ][
      #text(font: fonts.display, size: 9.5pt, weight: "bold", fill: ink, title)
    ]
    #if blurb != none {
      v(2pt)
      text(font: fonts.body, size: 7.5pt, fill: colors.mid, blurb)
    }
    #v(6pt)
  ]
}

/// Rotated sticker/badge
#let sticker(angle: -8deg, fill: colors.accent, body) = rotate(
  angle,
  box(fill: fill, stroke: (top: 2pt + colors.ink, left: 2pt + colors.ink, right: 0.5pt + colors.mid, bottom: 0.5pt + colors.mid), inset: (x: 8pt, y: 6pt))[
    #text(font: fonts.display, size: 11pt, fill: colors.paper, weight: "bold", upper(body))
  ],
)

/// Byline
#let byline(name, role: none, date: none) = block(above: 0.2em, below: 1em)[
  #grid(
    columns: (auto, auto),
    gutter:  6pt,
    align:   horizon,
  )[
    #block(width: 10pt, height: 1pt, fill: colors.accent)[]
  ][
    #text(font: fonts.body, size: 7.5pt, fill: colors.mid)[
      #if role != none [#upper(role + "  ")]
      #upper(name)
      #if date != none [#text(fill: colors.accent, "  /  ")#date]
    ]
  ]
]

/// Wrap body text around an image using meander.
///
/// Parameters:
///   img     [content] - the image or any content to treat as an obstacle
///   width   [ratio]   - width of the image column (default 38%)
///   align   [align]   - top + left or top + right (default top + left)
///   gap     [length]  - gutter between image and text (default 10pt)
///   caption [str]     - optional caption shown below the image
///   body    [content] - the flowing text that wraps around the image
#let wrap-image(
  img,
  width:   55%,
  align:   top + left,
  gap:     12pt,
  caption: none,
  body,
) = context {
  let ink   = text.fill
  let paper = page.fill

  let img-block = block(spacing: 0pt)[
    #box(
      stroke: (top: 2pt + ink, left: 2pt + ink, right: 0.5pt + colors.mid, bottom: 0.5pt + colors.mid),
      inset:  0pt,
      width:  100%,
    )[#img]
    #if caption != none {
      block(inset: (x: 0pt, y: 4pt), spacing: 0pt)[
        #text(font: fonts.body, size: 7pt, fill: colors.mid)[
          #text(fill: colors.accent)["/ "]#upper(caption)
        ]
      ]
    }
  ]

  meander.reflow({
    import meander: placed, container, opt
    opt.placement.spacing(below: 0pt)
    placed(align, box(width: width, img-block))
    container(
      width: 100% - width - gap,
      align: if align.x == left { right } else { left },
    )
    meander.content(body)
  })
}

/// Cover page — full bleed, typographic title treatment over an image.
/// Place before #show: webzine.with(...) in your document.
///
/// Parameters:
///   title   [str]     - publication title
///   issue   [str]     - issue number/label
///   date    [str]     - date string
///   img     [content] - full-bleed background image/content (optional)
///   accent  [color]   - accent color
///   ink     [color]   - text color (default: white for dark covers)
///   paper   [color]   - page fill (default: black)
#let cover(
  title:  "ZINE",
  issue:  "01",
  date:   "2024",
  img:    none,
  accent: rgb("#ff2d00"),
  ink:    white,
  paper:  black,
) = {
  page(margin: 0pt, fill: paper)[
    #if img != none {
      block(width: 100%, height: 100%, spacing: 0pt, clip: true)[#img]
    }
    #place(bottom + left,
      dx: 22pt,
      dy: -22pt,
      block(inset: 0pt, spacing: 0pt)[
        #text(
          font:     fonts.body,
          size:     7.5pt,
          fill:     accent,
          tracking: 2pt,
          upper("No. " + issue + "  ·  " + date),
        )
        #v(6pt)
        #block(spacing: 0pt)[
          #set par(leading: 0.72em)
          #text(
            font:     fonts.display,
            size:     64pt,
            weight:   300,
            fill:     ink,
            tracking: -2pt,
            upper(title),
          )
        ]
        #v(4pt)
        #grid(
          columns: (1fr, 20pt, 60pt),
          gutter:  0pt,
          align:   horizon,
        )[
          #line(length: 100%, stroke: 3pt + ink)
        ][
          #block(width: 20pt, height: 3pt, fill: accent)[]
        ][
          #line(length: 100%, stroke: 0.5pt + ink)
        ]
        #v(18pt)
      ]
    )
  ]
}

/// Inside cover — faces the TOC. Full bleed, minimal text.
/// Parameters:
///   img     [content] - full-bleed background (optional)
///   body    [content] - optional text content (editorial note, credits, etc.)
///   accent  [color]   - accent color
///   ink     [color]   - text color
///   paper   [color]   - page fill
#let inside-cover(
  img:    none,
  body:   none,
  accent: rgb("#ff2d00"),
  ink:    white,
  paper:  black,
) = {
  page(margin: 0pt, fill: paper)[
    #if img != none {
      block(width: 100%, height: 100%, spacing: 0pt, clip: true)[#img]
    }
    #if body != none {
      place(top + left,
        dx: 22pt,
        dy: 22pt,
        block(width: 60%, inset: 0pt)[
          #set text(font: fonts.body, size: 8pt, fill: ink)
          #set par(leading: 0.7em, spacing: 1em)
          #body
        ]
      )
    }
    #place(bottom + right,
      dx: -22pt,
      dy: -22pt,
      block(inset: 0pt)[
        #text(
          font:     fonts.body,
          size:     6.5pt,
          fill:     colors.mid,
          tracking: 1.5pt,
          upper("inside cover"),
        )
      ]
    )
  ]
}

/// Inside back cover — faces the last content page.
/// Parameters: same as inside-cover
#let inside-back-cover(
  img:    none,
  body:   none,
  accent: rgb("#ff2d00"),
  ink:    white,
  paper:  black,
) = {
  page(margin: 0pt, fill: paper)[
    #if img != none {
      block(width: 100%, height: 100%, spacing: 0pt, clip: true)[#img]
    }
    #if body != none {
      place(top + left,
        dx: 22pt,
        dy: 22pt,
        block(width: 60%, inset: 0pt)[
          #set text(font: fonts.body, size: 8pt, fill: ink)
          #set par(leading: 0.7em, spacing: 1em)
          #body
        ]
      )
    }
    #place(bottom + left,
      dx: 22pt,
      dy: -22pt,
      block(inset: 0pt)[
        #text(
          font:     fonts.body,
          size:     6.5pt,
          fill:     colors.mid,
          tracking: 1.5pt,
          upper("inside back cover"),
        )
      ]
    )
  ]
}

/// Back cover — final page. Typographic, no masthead.
/// Parameters:
///   title   [str]     - publication title
///   issue   [str]     - issue number/label
///   date    [str]     - date string
///   tagline [str]     - optional short line (e.g. "free — print it — leave it somewhere")
///   img     [content] - full-bleed background (optional)
///   accent  [color]   - accent color
///   ink     [color]   - text color
///   paper   [color]   - page fill
#let back-cover(
  title:   "ZINE",
  issue:   "01",
  date:    "2024",
  tagline: none,
  img:     none,
  accent:  rgb("#ff2d00"),
  ink:     white,
  paper:   black,
) = {
  page(margin: 0pt, fill: paper)[
    #if img != none {
      block(width: 100%, height: 100%, spacing: 0pt, clip: true)[#img]
    }
    #place(top + left,
      dx: 22pt,
      dy: 22pt,
      block(inset: 0pt)[
        #line(length: 40pt, stroke: 1.5pt + accent)
      ]
    )
    #place(bottom + left,
      dx: 22pt,
      dy: -22pt,
      block(inset: 0pt, spacing: 0pt)[
        #if tagline != none {
          text(
            font:     fonts.body,
            size:     7.5pt,
            fill:     colors.mid,
            tracking: 1.5pt,
            upper(tagline),
          )
          v(8pt)
        }
        #grid(
          columns: (60pt, 20pt, 1fr),
          gutter:  0pt,
          align:   horizon,
        )[
          #line(length: 100%, stroke: 0.5pt + ink)
        ][
          #block(width: 20pt, height: 3pt, fill: accent)[]
        ][
          #line(length: 100%, stroke: 3pt + ink)
        ]
        #v(6pt)
        #block(spacing: 0pt)[
          #set par(leading: 0.72em)
          #text(
            font:     fonts.display,
            size:     48pt,
            weight:   300,
            fill:     ink,
            tracking: -1.5pt,
            upper(title),
          )
        ]
        #v(4pt)
        #text(
          font:     fonts.body,
          size:     7.5pt,
          fill:     accent,
          tracking: 2pt,
          upper("No. " + issue + "  ·  " + date),
        )
        #v(18pt)
      ]
    )
  ]
}

/// Full-page image — occupies its own page, zero margins, bleeds edge to edge.
/// Place between articles to guarantee an image on every other page.
///
/// Parameters:
///   img       [content] - image or any content to fill the page
///   caption   [str]     - optional caption, anchored bottom-left
///   label     [str]     - optional small label, anchored top-right (e.g. issue/section)
///   ink       [color]   - override ink for caption text (default: from context)
#let page-image(img, caption: none, label: none, ink: auto) = context {
  let resolved-ink = if ink == auto { text.fill } else { ink }

  page(margin: 0pt)[
    #block(width: 100%, height: 100%, spacing: 0pt, clip: true)[#img]
    #if caption != none {
      place(bottom + left,
        dx: 14pt,
        dy: -14pt,
        block(
          fill:  resolved-ink.transparentize(100%) ,
          inset: 0pt,
        )[
          #text(
            font:     fonts.body,
            size:     7.5pt,
            fill:     colors.mid,
            tracking: 0.5pt,
          )[
            #text(fill: colors.accent)["/ "]#upper(caption)
          ]
        ]
      )
    }
    #if label != none {
      place(top + right,
        dx: -14pt,
        dy: 14pt,
        block(inset: 0pt)[
          #text(
            font:     fonts.body,
            size:     7pt,
            fill:     colors.mid,
            tracking: 1.5pt,
            upper(label),
          )
        ]
      )
    }
  ]
}

// ─── CONVENIENCE RE-EXPORTS ──────────────────────────────────────────────────

#let accent      = colors.accent
#let zine-fonts  = fonts
#let zine-colors = colors
