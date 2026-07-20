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
  accent: rgb("#777777"),
  mid:    rgb("#777777"),
)

// ─── TYPOGRAPHY ──────────────────────────────────────────────────────────────

#let fonts = (
  body:    ("Liberation Mono", "FreeMono"),
  display: ("Space Grotesk", "Aporetic Sans", "Noto Sans", "Liberation Sans"),
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
      fill:     colors.mid,
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
      #line(length: 100%, stroke: 0.5pt + ink)
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
      fill:  colors.mid,
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
    stroke: (bottom: 1.5pt + ink),
    inset:  (x: 4pt, y: 3pt),
  )[
    #text(font: fonts.body, size: 8.5pt, it)
  ]

  show raw.where(block: true): it => block(
    width:  100%,
    fill:   if paper == black { rgb("#0a0a0a") } else { rgb("#eeeeee") },
    stroke: (left: 4pt + ink, bottom: 1pt + ink),
    inset:  (left: 14pt, right: 8pt, y: 10pt),
    above:  1.2em,
    below:  1.2em,
  )[
    #text(font: fonts.body, size: 8.5pt, it)
  ]

  show link: it => underline(stroke: 1pt + ink, offset: 3pt, it)

  show figure: it => block(
    above: 1.5em,
    below: 1.5em,
    width: 100%,
  )[
    #box(stroke: (top: 3pt + ink, bottom: 0.5pt + colors.mid), inset: 0pt, width: 100%)[
      #it.body
    ]
    #if it.caption != none {
      block(inset: (x: 0pt, y: 5pt), width: 100%)[
        #text(font: fonts.body, size: 7.5pt, fill: colors.mid)[
          #text(fill: colors.mid)["/ "]fig. #it.counter.display() — #it.caption.body
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
      fill:     colors.mid,
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
        fill:   ink,
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
        #block(width: 6pt, height: 6pt, fill: colors.mid)[]
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
          fill:     colors.mid,
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
      fill:     colors.mid,
      tracking: 2pt,
      upper("  quote  "),
    )
    #v(-2pt)
    #block(
      stroke: (left: 5pt + ink, top: 0.5pt + colors.mid),
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
          #block(width: 16pt, height: 0.75pt, fill: colors.mid)[]
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
        #text(font: fonts.display, size: 7.5pt, weight: "bold", fill: ink, upper(title))
        #h(3pt)
        #text(font: fonts.body, size: 7pt, fill: colors.mid, "___")
      ]
    }
    #body
  ]
}

/// Manifesto — large type, ruled off
#let manifesto(body) = context {
  let ink   = text.fill
  let paper = page.fill
  block(
    width: 100%,
    above: 3em,
    below: 3em,
  )[
    #line(length: 100%, stroke: 2pt + ink)
    #v(16pt)
    #block(spacing: 0pt)[
      #set par(leading: 0.82em)
      #text(
        font:     fonts.display,
        size:     34pt,
        weight:   300,
        fill:     ink,
        tracking: -0.5pt,
        body,
      )
    ]
    #v(16pt)
    #line(length: 100%, stroke: 0.5pt + colors.mid)
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
          #text(fill: colors.mid)["/ "]#upper(caption)
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
        #text(font: fonts.body, size: 7pt, fill: colors.mid, "//")
      ]
      #line(length: 100%, stroke: 1pt + ink)
      #v(5pt)
      #left
    ][
      #block(width: 2pt, fill: colors.mid, height: 100%)[]
    ][
      #block(below: 5pt)[
        #text(font: fonts.display, size: 9pt, weight: "bold", fill: ink, right-label)
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
    stroke: (bottom: 1.5pt + ink, top: 0.5pt + ink),
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
        #block(width: 4pt, height: 4pt, fill: ink)[]
      ][
        #line(length: 100%, stroke: 0.5pt + colors.mid)
      ]
    } else {
      grid(
        columns: (auto, 1fr, auto),
        gutter:  8pt,
        align:   center + horizon,
      )[
        #text(font: fonts.body, size: 7pt, fill: colors.mid, tracking: 1.5pt, upper(label))
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
      #text(font: fonts.body, size: 7pt, fill: colors.mid, str(page-num))
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
#let sticker(angle: -8deg, fill: colors.ink, body) = rotate(
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
    #block(width: 10pt, height: 1pt, fill: colors.mid)[]
  ][
    #text(font: fonts.body, size: 7.5pt, fill: colors.mid)[
      #if role != none [#upper(role + "  ")]
      #upper(name)
      #if date != none [#text(fill: colors.mid, "  /  ")#date]
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
  width:    55%,
  align:    top + left,
  gap:      12pt,
  caption:  none,
  boundary: none,
  body,
) = context {
  let ink   = text.fill
  let paper = page.fill

  let img-block = block(spacing: 0pt)[
    #box(inset: 0pt, width: 100%)[#img]
    #if caption != none {
      block(inset: (x: 0pt, y: 4pt), spacing: 0pt)[
        #text(font: fonts.body, size: 7pt, fill: colors.mid)[
          #text(fill: colors.mid)["/ "]#upper(caption)
        ]
      ]
    }
  ]

  meander.reflow({
    import meander: placed, container, opt, contour
    opt.placement.spacing(below: 0pt)
    if boundary != none {
      placed(align,
        boundary: meander.contour.margin(gap) + boundary,
        box(width: width, img-block),
      )
      container(width: 100%, margin: 0pt)
    } else {
      placed(align, box(width: width, img-block))
      container(
        width: 100% - width - gap,
        align: if align.x == left { right } else { left },
      )
    }
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
      block(width: 100%, height: 100%, spacing: 0pt, inset: 0pt, clip: true)[#img]
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

#let _inner-cover(img, body, ink, paper, label, label-anchor) = {
  page(margin: 0pt, fill: paper)[
    #if img != none {
      block(width: 100%, height: 100%, spacing: 0pt, inset: 0pt, clip: true)[#img]
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
    #place(label-anchor,
      dx: if label-anchor == bottom + right { -22pt } else { 22pt },
      dy: -22pt,
      block(inset: 0pt)[
        #text(font: fonts.body, size: 6.5pt, fill: colors.mid, tracking: 1.5pt, upper(label))
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
) = _inner-cover(img, body, ink, paper, "inside cover", bottom + right)

/// Inside back cover — faces the last content page.
/// Parameters: same as inside-cover
#let inside-back-cover(
  img:    none,
  body:   none,
  accent: rgb("#ff2d00"),
  ink:    white,
  paper:  black,
) = _inner-cover(img, body, ink, paper, "inside back cover", bottom + left)

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
      block(width: 100%, height: 100%, spacing: 0pt, inset: 0pt, clip: true)[#img]
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

/// Article title card — full-bleed page preceding each article.
///
/// Images are passed as an array and tiled dynamically based on `layout`,
/// like a tiling window manager. Adding more images subdivides the layout.
///
/// Parameters:
///   title        [str]    - article title (large display type)
///   author       [str]    - byline
///   issue        [str]    - issue label (small metadata line)
///   date         [str]    - date (small metadata line)
///   images       [array]  - list of image content blocks (1–N)
///   layout       [str]    - tiling mode:
///
///     TILING LAYOUTS
///     "monocle"       1 image full-bleed
///     "h-split"       N equal horizontal bands
///     "v-split"       N equal vertical columns
///     "h-stack"       master top 60%, rest tile bottom row (alias: "main-top")
///     "h-stack-inv"   master bottom 60%, rest tile top row (alias: "main-bottom")
///     "v-stack"       master left 60%, rest stack right column (alias: "main-left")
///     "v-stack-inv"   master right 60%, rest stack left column (alias: "main-right")
///     "nh-stack"      master-count images top, rest tile bottom row
///     "nv-stack"      master-count images left, rest stack right column
///     "mirror-h"      secondary | master | secondary (horizontal bands)
///     "mirror-v"      secondary | master | secondary (vertical columns)
///     "columns"       asymmetric vertical columns (widths vary by image count)
///     "rows"          asymmetric horizontal rows (heights vary by image count)
///     "grid"          auto square-ish grid
///     "fibonacci"     golden ratio spiral subdivision (up to 8 images)
///
///     CREATIVE / EDITORIAL
///     "dupe"          image[0] + mirror (or image[1]) side by side
///     "dupe-triple"   mirror / original / mirror
///     "dupe-shift"    two panels, right nudged up; paper strip at bottom-right
///     "overlay"       image[0] full-bleed; image[1..] float as insets
///     "collision"     image[0] and image[1] collide at off-center vertical seam
///     "stagger"       images in a staircase offset (shifts right + down)
///     "drift"         images float freely, no grid, imbalanced weight
///     "corner-pull"   image[0] full-bleed; image[1..] pinned to corners
///
///   master-count [int]   - images in master zone for nh-stack/nv-stack/mirror-* (default 1)
///   gap          [length] - gutter between tiles (default 0pt)
///   stack        [dict]  - floating image stack overlay: (images, anchor, width, height, offset)
///   title-pos    [str]   - "bottom-left" (default) | "top-left" | "bottom-right" | "center"
///   ink          [color] - override ink color
#let article-page(
  title:        "",
  author:       none,
  issue:        none,
  date:         none,
  images:       (),
  layout:       "monocle",
  title-pos:    "bottom-left",
  master-count: 1,
  gap:          0pt,
  stack:        none,
  ink:          auto,
) = context {
  let resolved-ink   = if ink == auto { text.fill } else { ink }
  let resolved-paper = page.fill
  let n = images.len()

  page(margin: 0pt, fill: resolved-paper)[
    #set block(spacing: 0pt, above: 0pt, below: 0pt)
    #set par(spacing: 0pt, leading: 0pt)

    #let _img(i) = block(width: 100%, height: 100%, spacing: 0pt, inset: 0pt, clip: true)[#place(top + left, images.at(i))]
    #let _blank() = block(width: 100%, height: 100%, spacing: 0pt, inset: 0pt, fill: resolved-paper)[]
    #let _hstack(idxs, h) = {
      let rn = idxs.len()
      if rn == 0 { block(width: 100%, height: h, spacing: 0pt, fill: resolved-paper)[] }
      else if rn == 1 {
        block(width: 100%, height: h, spacing: 0pt, inset: 0pt, clip: true)[#place(top + left, images.at(idxs.at(0)))]
      } else {
        block(width: 100%, height: h, spacing: 0pt, inset: 0pt)[
          #grid(columns: range(rn).map(_ => 1fr), rows: (100%,), gutter: gap,
            ..idxs.map(i => block(width: 100%, height: 100%, spacing: 0pt, inset: 0pt, clip: true)[#place(top + left, images.at(i))])
          )
        ]
      }
    }
    #let _vstack(idxs, w) = {
      let rn = idxs.len()
      if rn == 0 { block(width: w, height: 100%, spacing: 0pt, fill: resolved-paper)[] }
      else if rn == 1 {
        block(width: w, height: 100%, spacing: 0pt, inset: 0pt, clip: true)[#place(top + left, images.at(idxs.at(0)))]
      } else {
        block(width: w, height: 100%, spacing: 0pt, inset: 0pt)[
          #grid(columns: (100%,), rows: range(rn).map(_ => 1fr), gutter: gap,
            ..idxs.map(i => block(width: 100%, height: 100%, spacing: 0pt, inset: 0pt, clip: true)[#place(top + left, images.at(i))])
          )
        ]
      }
    }

    #if layout == "monocle" {
      if n > 0 { place(top + left, _img(0)) }

    } else if layout == "h-split" or layout == "hsplit" {
      if n == 0 {
      } else if n == 1 {
        place(top + left, _img(0))
      } else {
        grid(columns: (100%,), rows: range(n).map(_ => 1fr), gutter: gap,
          ..range(n).map(i =>
            block(width: 100%, height: 100%, spacing: 0pt, inset: 0pt, clip: true)[#place(top + left, images.at(i))]
          )
        )
      }

    } else if layout == "v-split" or layout == "vsplit" {
      if n == 0 {
      } else if n == 1 {
        place(top + left, _img(0))
      } else {
        grid(columns: range(n).map(_ => 1fr), rows: (100%,), gutter: gap, ..range(n).map(i =>
          block(width: 100%, height: 100%, spacing: 0pt, inset: 0pt, clip: true)[#place(top + left, images.at(i))]
        ))
      }

    } else if layout == "h-stack" or layout == "main-top" {
      let master-idxs = if n > 0 { (0,) } else { () }
      let stack-idxs  = if n > 1 { range(1, n) } else { () }
      grid(columns: (100%,), rows: (if stack-idxs.len() > 0 { 3fr } else { 1fr }, if stack-idxs.len() > 0 { 2fr } else { 0pt }), gutter: gap,
        _hstack(master-idxs, 100%),
        if stack-idxs.len() > 0 { _hstack(stack-idxs, 100%) } else { [] },
      )

    } else if layout == "h-stack-inv" or layout == "main-bottom" {
      let master-idxs = if n > 0 { (0,) } else { () }
      let stack-idxs  = if n > 1 { range(1, n) } else { () }
      grid(columns: (100%,), rows: (if stack-idxs.len() > 0 { 2fr } else { 0pt }, if stack-idxs.len() > 0 { 3fr } else { 1fr }), gutter: gap,
        if stack-idxs.len() > 0 { _hstack(stack-idxs, 100%) } else { [] },
        _hstack(master-idxs, 100%),
      )

    } else if layout == "v-stack" or layout == "main-left" {
      let master-idxs = if n > 0 { (0,) } else { () }
      let stack-idxs  = if n > 1 { range(1, n) } else { () }
      grid(columns: (if stack-idxs.len() > 0 { 3fr } else { 1fr }, if stack-idxs.len() > 0 { 2fr } else { 0pt }), rows: (100%,), gutter: gap,
        if master-idxs.len() == 0 { _blank() } else { _img(0) },
        if stack-idxs.len() > 0 { _vstack(stack-idxs, 100%) } else { [] },
      )

    } else if layout == "v-stack-inv" or layout == "main-right" {
      let master-idxs = if n > 0 { (0,) } else { () }
      let stack-idxs  = if n > 1 { range(1, n) } else { () }
      grid(columns: (if stack-idxs.len() > 0 { 2fr } else { 0pt }, if stack-idxs.len() > 0 { 3fr } else { 1fr }), rows: (100%,), gutter: gap,
        if stack-idxs.len() > 0 { _vstack(stack-idxs, 100%) } else { [] },
        if master-idxs.len() == 0 { _blank() } else { _img(0) },
      )

    } else if layout == "nh-stack" {
      let mc = calc.max(1, master-count)
      let master-idxs = range(calc.min(mc, n))
      let stack-idxs  = if n > mc { range(mc, n) } else { () }
      if stack-idxs.len() == 0 {
        _hstack(master-idxs, 100%)
      } else {
        grid(columns: (100%,), rows: (3fr, 2fr), gutter: gap,
          _hstack(master-idxs, 100%),
          _hstack(stack-idxs, 100%),
        )
      }

    } else if layout == "nv-stack" {
      let mc = calc.max(1, master-count)
      let master-idxs = range(calc.min(mc, n))
      let stack-idxs  = if n > mc { range(mc, n) } else { () }
      if stack-idxs.len() == 0 {
        _vstack(master-idxs, 100%)
      } else {
        grid(columns: (3fr, 2fr), rows: (100%,), gutter: gap,
          _vstack(master-idxs, 100%),
          _vstack(stack-idxs, 100%),
        )
      }

    } else if layout == "mirror-h" {
      let mc = calc.max(1, master-count)
      let top-idxs    = if n > 1 { (1,) } else { () }
      let master-idxs = if n > 0 { (0,) } else { () }
      let bot-idxs    = if n > 2 { range(2, n) } else { () }
      let has-top = top-idxs.len() > 0
      let has-bot = bot-idxs.len() > 0
      let rows = (
        if has-top  { (2fr,) } else { () } +
        (3fr,) +
        if has-bot  { (2fr,) } else { () }
      )
      let cells = (
        if has-top  { (_hstack(top-idxs, 100%),) }    else { () } +
        (_hstack(master-idxs, 100%),) +
        if has-bot  { (_hstack(bot-idxs, 100%),) }    else { () }
      )
      grid(columns: (100%,), rows: rows, gutter: gap, ..cells)

    } else if layout == "mirror-v" {
      let left-idxs   = if n > 1 { (1,) } else { () }
      let master-idxs = if n > 0 { (0,) } else { () }
      let right-idxs  = if n > 2 { range(2, n) } else { () }
      let has-left  = left-idxs.len() > 0
      let has-right = right-idxs.len() > 0
      let cols = (
        if has-left  { (2fr,) } else { () } +
        (3fr,) +
        if has-right { (2fr,) } else { () }
      )
      let cells = (
        if has-left  { (_vstack(left-idxs, 100%),) }   else { () } +
        (_vstack(master-idxs, 100%),) +
        if has-right { (_vstack(right-idxs, 100%),) }  else { () }
      )
      grid(columns: cols, rows: (100%,), gutter: gap, ..cells)

    } else if layout == "columns" {
      let widths = if n <= 1 { (1fr,) }
                   else if n == 2 { (38%, 62%) }
                   else if n == 3 { (18%, 62%, 20%) }
                   else { (14%, 52%, 20%, 14%) }
      let actual = calc.min(n, widths.len())
      grid(columns: widths.slice(0, actual), rows: (100%,), gutter: gap,
        ..range(actual).map(i =>
          block(width: 100%, height: 100%, spacing: 0pt, inset: 0pt, clip: true)[#place(top + left, images.at(i))]
        )
      )

    } else if layout == "rows" {
      if n == 0 {
      } else {
        let heights = if n == 1 { (1fr,) }
                      else if n == 2 { (62%, 38%) }
                      else if n == 3 { (50%, 30%, 20%) }
                      else { (40%, 25%, 20%, 15%) }
        let actual = calc.min(n, heights.len())
        grid(columns: (100%,), rows: heights.slice(0, actual), gutter: gap,
          ..range(actual).map(i =>
            block(width: 100%, height: 100%, spacing: 0pt, inset: 0pt, clip: true)[#place(top + left, images.at(i))]
          )
        )
      }

    } else if layout == "grid" {
      if n == 0 {
      } else if n == 1 {
        place(top + left, _img(0))
      } else {
        let cols = if n <= 2 { 2 } else if n <= 4 { 2 } else if n <= 6 { 3 } else { 4 }
        let rows = calc.ceil(n / cols)
        grid(
          columns: range(cols).map(_ => 1fr),
          rows:    range(rows).map(_ => 1fr),
          gutter:  gap,
          ..range(cols * rows).map(i => {
            if i < n {
              block(width: 100%, height: 100%, spacing: 0pt, inset: 0pt, clip: true)[#place(top + left, images.at(i))]
            } else {
              block(width: 100%, height: 100%, spacing: 0pt, fill: resolved-paper)[]
            }
          })
        )
      }

    } else if layout == "fibonacci" {
      let slots = {
        let result = ()
        let x = 0%
        let y = 0%
        let w = 100%
        let h = 100%
        let total = calc.min(n, 8)
        for k in range(total) {
          let ratio = if k == total - 1 { 1.0 } else { 0.618 }
          let d = calc.rem(k, 4)
          if d == 0 {
            let mw = w * ratio
            result.push((x: x, y: y, w: mw, h: h))
            x = x + mw
            w = w - mw
          } else if d == 1 {
            let mh = h * ratio
            result.push((x: x, y: y, w: w, h: mh))
            y = y + mh
            h = h - mh
          } else if d == 2 {
            let mw = w * ratio
            result.push((x: x + w - mw, y: y, w: mw, h: h))
            w = w - mw
          } else {
            let mh = h * ratio
            result.push((x: x, y: y + h - mh, w: w, h: mh))
            h = h - mh
          }
        }
        result
      }
      let hg = gap / 2
      for i in range(slots.len()) {
        let s = slots.at(i)
        place(top + left, dx: s.x + hg, dy: s.y + hg,
          block(width: s.w - gap, height: s.h - gap, spacing: 0pt, inset: 0pt, clip: true)[#place(top + left, images.at(i))]
        )
      }

    } else if layout == "dupe" {
      let b = if n >= 2 { images.at(1) } else { images.at(0) }
      grid(columns: (1fr, 1fr), rows: (100%,), gutter: gap)[
        #block(width: 100%, height: 100%, spacing: 0pt, inset: 0pt, clip: true)[#place(top + left, images.at(0))]
      ][
        #block(width: 100%, height: 100%, spacing: 0pt, inset: 0pt, clip: true)[
          #place(top + left, scale(x: -100%, b))
        ]
      ]

    } else if layout == "dupe-triple" {
      let a = images.at(0)
      let b = if n >= 2 { images.at(1) } else { a }
      let c = if n >= 3 { images.at(2) } else { a }
      grid(columns: (1fr, 1fr, 1fr), rows: (100%,), gutter: gap)[
        #block(width: 100%, height: 100%, spacing: 0pt, inset: 0pt, clip: true)[
          #place(top + left, scale(x: -100%, a))
        ]
      ][
        #block(width: 100%, height: 100%, spacing: 0pt, inset: 0pt, clip: true)[#place(top + left, b)]
      ][
        #block(width: 100%, height: 100%, spacing: 0pt, inset: 0pt, clip: true)[
          #place(top + left, scale(x: -100%, c))
        ]
      ]

    } else if layout == "dupe-shift" {
      let shift = 20%
      let b = if n >= 2 { images.at(1) } else { images.at(0) }
      block(width: 50% - gap / 2, height: 100%, spacing: 0pt, inset: 0pt, clip: true)[#place(top + left, images.at(0))]
      place(top + right,
        dy: -(100% * shift),
        block(width: 50% - gap / 2, height: 100% + (100% * shift), spacing: 0pt, inset: 0pt, clip: true)[#place(top + left, b)]
      )

    } else if layout == "overlay" {
      if n > 0 { place(top + left, _img(0)) }
      let overlay-positions = (
        (anchor: top + right,  dx: -18pt, dy: 18%,  w: 42%),
        (anchor: bottom + left, dx: 18pt, dy: -24%, w: 34%),
        (anchor: top + left,   dx: 18pt, dy: 38%,  w: 30%),
      )
      for i in range(1, calc.min(n, 4)) {
        let p = overlay-positions.at(i - 1)
        place(p.anchor, dx: p.dx, dy: p.dy,
          block(width: p.w, spacing: 0pt, inset: 0pt, clip: true)[#box(width: 100%, height: 100%)[#images.at(i)]]
        )
      }

    } else if layout == "collision" {
      let seam = 40%
      let intrude = 13%
      let b = if n >= 2 { images.at(1) } else { images.at(0) }
      block(width: seam + intrude, height: 100%, spacing: 0pt, inset: 0pt, clip: true)[#place(top + left, images.at(0))]
      place(top + left, dx: seam - intrude, dy: 0pt,
        block(width: 100% - seam + intrude, height: 100%, spacing: 0pt, inset: 0pt, clip: true)[#place(top + left, b)]
      )

    } else if layout == "stagger" {
      let offsets = (
        (x: 0%,  y: 0%,  w: 60%, h: 55%),
        (x: 20%, y: 34%, w: 60%, h: 55%),
        (x: 40%, y: 60%, w: 60%, h: 40%),
        (x: 10%, y: 72%, w: 50%, h: 28%),
      )
      for i in range(calc.min(n, offsets.len())) {
        let o = offsets.at(i)
        place(top + left,
          dx: 100% * o.x,
          dy: 100% * o.y,
          block(width: 100% * o.w, height: 100% * o.h, spacing: 0pt, inset: 0pt, clip: true)[#place(top + left, images.at(i))]
        )
      }

    } else if layout == "drift" {
      let slots = (
        (anchor: top + left,    dx: 0pt,   dy: 0pt,   w: 68%, h: 70%),
        (anchor: top + right,   dx: 0pt,   dy: 8%,    w: 38%, h: 44%),
        (anchor: bottom + right, dx: 0pt,  dy: 0pt,   w: 72%, h: 36%),
        (anchor: bottom + left,  dx: 4%,   dy: -4%,   w: 30%, h: 24%),
      )
      for i in range(calc.min(n, slots.len())) {
        let s = slots.at(i)
        place(s.anchor, dx: s.dx, dy: s.dy,
          block(width: s.w, height: s.h, spacing: 0pt, inset: 0pt, clip: true)[#place(top + left, images.at(i))]
        )
      }

    } else if layout == "corner-pull" {
      if n > 0 { place(top + left, _img(0)) }
      let corner-slots = (
        (anchor: bottom + right, dx: 0pt,  dy: 0pt,  w: 38%, h: 32%),
        (anchor: top + left,    dx: 0pt,  dy: 0pt,  w: 32%, h: 38%),
        (anchor: top + right,   dx: 0pt,  dy: 0pt,  w: 30%, h: 30%),
        (anchor: bottom + left, dx: 0pt,  dy: 0pt,  w: 28%, h: 26%),
      )
      for i in range(1, calc.min(n, 5)) {
        let s = corner-slots.at(i - 1)
        place(s.anchor, dx: s.dx, dy: s.dy,
          block(width: s.w, height: s.h, spacing: 0pt, inset: 0pt, clip: true)[#place(top + left, images.at(i))]
        )
      }
    }

    #let _meta = if issue != none or date != none {
      upper(
        if issue != none and date != none { "No. " + issue + "  ·  " + date }
        else if issue != none { "No. " + issue }
        else { date }
      )
    } else { none }

    #let _title-block = block(inset: 0pt, spacing: 0pt)[
      #if _meta != none {
        text(font: fonts.body, size: 6.5pt, fill: colors.mid, tracking: 2pt, _meta)
        v(5pt)
      }
      #block(spacing: 0pt)[
        #set par(leading: 0.72em)
        #text(
          font:     fonts.display,
          size:     42pt,
          weight:   300,
          fill:     resolved-ink,
          tracking: -1pt,
          upper(title),
        )
      ]
      #if author != none {
        v(6pt)
        grid(columns: (auto, auto), gutter: 6pt, align: horizon)[
          #block(width: 10pt, height: 1pt, fill: colors.mid)[]
        ][
          #text(font: fonts.body, size: 7.5pt, fill: colors.mid, tracking: 0.5pt, upper(author))
        ]
      }
    ]

    #if title-pos == "bottom-left" {
      place(bottom + left, dx: 22pt, dy: -22pt, _title-block)
    } else if title-pos == "top-left" {
      place(top + left, dx: 22pt, dy: 22pt, _title-block)
    } else if title-pos == "bottom-right" {
      place(bottom + right, dx: -22pt, dy: -22pt, _title-block)
    } else {
      place(center + horizon, _title-block)
    }

    #place(top + left, dx: 22pt, dy: 14pt,
      line(length: 28pt, stroke: 1pt + colors.mid)
    )

    #if stack != none {
      let simgs   = stack.at("images",  default: ())
      let sanchor = stack.at("anchor",  default: bottom + right)
      let sw      = stack.at("width",   default: 38%)
      let sh      = stack.at("height",  default: 32%)
      let soff    = stack.at("offset",  default: 14pt)
      let sn      = simgs.len()
      for k in range(sn) {
        let idx = sn - 1 - k
        let shift = soff * idx
        let adx = if sanchor == top + left or sanchor == bottom + left { shift } else { -shift }
        let ady = if sanchor == top + left or sanchor == top + right   { shift } else { -shift }
        place(sanchor, dx: adx, dy: ady,
          block(width: sw, height: sh, spacing: 0pt, inset: 0pt, clip: true)[
            #place(top + left, simgs.at(idx))
          ]
        )
      }
    }
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
    #block(width: 100%, height: 100%, spacing: 0pt, inset: 0pt, clip: true)[#img]
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
            #text(fill: colors.mid)["/ "]#upper(caption)
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


/// Overlay page — full-bleed background image with a second image pinned
/// asymmetrically on top, plus ruled typographic annotation.
///
/// Parameters:
///   img       [content] - full-bleed background image
///   img2      [content] - overlay image (optional)
///   overlay-w [ratio]   - width of overlay image (default 48%)
///   overlay-x [align]   - horizontal anchor: left or right (default right)
///   overlay-y [ratio]   - vertical position from top as fraction (default 25%)
///   caption   [str]     - caption anchored bottom-left
///   label     [str]     - top-right tag
///   ink       [color]   - override ink
#let page-image-overlay(
  img,
  img2:      none,
  overlay-w: 48%,
  overlay-x: right,
  overlay-y: 25%,
  caption:   none,
  label:     none,
  ink:       auto,
) = context {
  let resolved-ink = if ink == auto { text.fill } else { ink }

  page(margin: 0pt)[
    #block(width: 100%, height: 100%, spacing: 0pt, inset: 0pt, clip: true)[#img]
    #if img2 != none {
      let anchor = if overlay-x == right { top + right } else { top + left }
      let dx-val = if overlay-x == right { -22pt } else { 22pt }
      place(anchor,
        dx: dx-val,
        dy: 100% * overlay-y,
        block(
          width:   overlay-w,
          spacing: 0pt,
          clip:    true,
        )[#img2]
      )
      place(anchor,
        dx: if overlay-x == right { -22pt - 28pt } else { 22pt + 6pt },
        dy: 100% * overlay-y - 14pt,
        rotate(-90deg,
          text(font: fonts.body, size: 6pt, fill: colors.mid, tracking: 2pt, upper("detail"))
        )
      )
    }
    #if caption != none {
      place(bottom + left,
        dx: 14pt,
        dy: -14pt,
        block(inset: 0pt)[
          #text(font: fonts.body, size: 7.5pt, fill: colors.mid, tracking: 0.5pt, upper(caption))
        ]
      )
    }
    #if label != none {
      place(top + right,
        dx: -14pt,
        dy: 14pt,
        block(inset: 0pt)[
          #text(font: fonts.body, size: 7pt, fill: colors.mid, tracking: 1.5pt, upper(label))
        ]
      )
    }
  ]
}


/// Triptych page — three vertical image panels side by side.
/// New Wave: identical cadence, hard seams, no gutter, labels below each panel.
///
/// Parameters:
///   img1, img2, img3  [content] - three panels (required)
///   captions          [array]   - up to 3 caption strings (optional)
///   label             [str]     - top-right tag
///   ink               [color]   - override ink
#let page-image-triptych(
  img1,
  img2,
  img3,
  captions: (),
  label:    none,
  ink:      auto,
) = context {
  let resolved-ink   = if ink == auto { text.fill } else { ink }
  let resolved-paper = page.fill
  let cap-h = if captions.len() > 0 { 28pt } else { 0pt }

  page(margin: 0pt)[
    #grid(
      columns: (1fr, 1fr, 1fr),
      gutter:  0pt,
    )[
      #block(width: 100%, height: 100% - cap-h, spacing: 0pt, inset: 0pt, clip: true)[#img1]
    ][
      #block(width: 100%, height: 100% - cap-h, spacing: 0pt, inset: 0pt, clip: true)[#img2]
    ][
      #block(width: 100%, height: 100% - cap-h, spacing: 0pt, inset: 0pt, clip: true)[#img3]
    ]
    #if captions.len() > 0 {
      place(bottom + left, dy: 0pt,
        block(width: 100%, height: cap-h, fill: resolved-paper, spacing: 0pt)[
          #line(length: 100%, stroke: 0.5pt + resolved-ink)
          #grid(columns: (1fr, 1fr, 1fr), gutter: 0pt)[
            #block(inset: (x: 10pt, y: 6pt))[
              #text(font: fonts.body, size: 6.5pt, fill: colors.mid, tracking: 1pt,
                upper(if captions.len() >= 1 { captions.at(0) } else { "" }))
            ]
          ][
            #block(inset: (x: 10pt, y: 6pt), stroke: (left: 0.5pt + colors.mid))[
              #text(font: fonts.body, size: 6.5pt, fill: colors.mid, tracking: 1pt,
                upper(if captions.len() >= 2 { captions.at(1) } else { "" }))
            ]
          ][
            #block(inset: (x: 10pt, y: 6pt), stroke: (left: 0.5pt + colors.mid))[
              #text(font: fonts.body, size: 6.5pt, fill: colors.mid, tracking: 1pt,
                upper(if captions.len() >= 3 { captions.at(2) } else { "" }))
            ]
          ]
        ]
      )
    }
    #if label != none {
      place(top + right, dx: -14pt, dy: 14pt,
        block(inset: 0pt)[
          #text(font: fonts.body, size: 7pt, fill: colors.mid, tracking: 1.5pt, upper(label))
        ]
      )
    }
  ]
}

/// Type-dominant page — dark paper, no image required.
/// Giant tracked display type fills the page. Acid / Weingart: type IS the image.
///
/// Parameters:
///   body      [content] - the text (short — 1–4 words ideal)
///   img       [content] - optional background image (heavily dimmed)
///   size      [length]  - font size (default 96pt)
///   sub       [str]     - small label top-left
///   caption   [str]     - small label bottom-right
///   ink       [color]   - override ink
#let page-image-type(
  body,
  img:     none,
  size:    96pt,
  sub:     none,
  caption: none,
  ink:     auto,
) = context {
  let resolved-ink   = if ink == auto { text.fill } else { ink }
  let resolved-paper = page.fill

  page(margin: 0pt, fill: resolved-paper)[
    #if img != none {
      block(width: 100%, height: 100%, spacing: 0pt, inset: 0pt, clip: true)[
        #set text(fill: resolved-ink)
        #img
      ]
      block(width: 100%, height: 100%, fill: resolved-paper.transparentize(30%),
        spacing: 0pt, above: 0pt)[]
    }
    #place(center + horizon,
      block(inset: (x: 22pt), spacing: 0pt)[
        #set par(leading: 0.7em)
        #text(
          font:     fonts.display,
          size:     size,
          weight:   300,
          fill:     resolved-ink,
          tracking: -2pt,
          upper(body),
        )
      ]
    )
    #if sub != none {
      place(top + left, dx: 14pt, dy: 14pt,
        block(inset: 0pt)[
          #text(font: fonts.body, size: 6.5pt, fill: colors.mid, tracking: 2pt, upper(sub))
        ]
      )
    }
    #if caption != none {
      place(bottom + right, dx: -14pt, dy: -14pt,
        block(inset: 0pt)[
          #text(font: fonts.body, size: 6.5pt, fill: colors.mid, tracking: 1.5pt, upper(caption))
        ]
      )
    }
  ]
}


/// Dupe page — same image mirrored side by side, vertical rule + overprinted label.
/// New Wave repetition: identical source, different reading.
///
/// Parameters:
///   img      [content] - image (shown twice)
///   label    [str]     - large vertical label on the center rule
///   caption  [str]     - bottom-left caption
///   ink      [color]   - override ink
#let page-image-dupe(
  img,
  label:   none,
  caption: none,
  ink:     auto,
) = context {
  let resolved-ink   = if ink == auto { text.fill } else { ink }
  let resolved-paper = page.fill

  page(margin: 0pt)[
    #grid(columns: (1fr, 1fr), gutter: 0pt)[
      #block(width: 100%, height: 100%, spacing: 0pt, inset: 0pt, clip: true)[#img]
    ][
      #block(width: 100%, height: 100%, spacing: 0pt, inset: 0pt, clip: true)[
        #scale(x: -100%)[#img]
      ]
    ]
    #place(center + horizon,
      block(width: 2pt, height: 100%, fill: resolved-ink)[]
    )
    #if label != none {
      place(center + horizon,
        rotate(-90deg,
          block(
            fill:  resolved-paper,
            inset: (x: 10pt, y: 4pt),
          )[
            #text(
              font:     fonts.body,
              size:     7pt,
              fill:     resolved-ink,
              tracking: 3pt,
              upper(label),
            )
          ]
        )
      )
    }
    #if caption != none {
      place(bottom + left, dx: 14pt, dy: -14pt,
        text(font: fonts.body, size: 7pt, fill: colors.mid, tracking: 0.5pt, upper(caption))
      )
    }
  ]
}

/// Stack page — two or three images in unequal horizontal bands.
/// Aggressive rules between bands. Acid: raw sequencing, no breathing room.
///
/// Parameters:
///   img1, img2        [content] - required images (top and middle/bottom)
///   img3              [content] - optional third image
///   splits            [array]   - two heights as ratios, e.g. (45%, 35%) — remainder goes to img3
///   rule-w            [length]  - rule weight between bands (default 2pt)
///   captions          [array]   - per-band captions (optional)
///   label             [str]     - top-right tag
///   ink               [color]   - override ink
#let page-image-stack(
  img1,
  img2,
  img3:     none,
  splits:   (50%, 30%),
  rule-w:   2pt,
  captions: (),
  label:    none,
  ink:      auto,
) = context {
  let resolved-ink = if ink == auto { text.fill } else { ink }
  let h1 = splits.at(0)
  let h2 = splits.at(1)
  let h3 = 100% - h1 - h2

  page(margin: 0pt)[
    #block(width: 100%, height: h1, spacing: 0pt, inset: 0pt, clip: true)[#img1]
    #if captions.len() >= 1 {
      place(
        top + left,
        dy: h1 - 18pt,
        dx: 14pt,
        text(font: fonts.body, size: 6pt, fill: colors.mid, tracking: 1pt, upper(captions.at(0)))
      )
    }
    #line(length: 100%, stroke: rule-w + resolved-ink)
    #block(width: 100%, height: h2, spacing: 0pt, inset: 0pt, clip: true)[#img2]
    #if captions.len() >= 2 {
      place(
        top + left,
        dy: h1 + h2 - 18pt,
        dx: 14pt,
        text(font: fonts.body, size: 6pt, fill: colors.mid, tracking: 1pt, upper(captions.at(1)))
      )
    }
    #if img3 != none {
      line(length: 100%, stroke: (rule-w / 2) + colors.mid)
      block(width: 100%, height: h3, spacing: 0pt, inset: 0pt, clip: true)[#img3]
      if captions.len() >= 3 {
        place(
          bottom + left,
          dy: -14pt,
          dx: 14pt,
          text(font: fonts.body, size: 6pt, fill: colors.mid, tracking: 1pt, upper(captions.at(2)))
        )
      }
    }
    #if label != none {
      place(top + right, dx: -14pt, dy: 14pt,
        text(font: fonts.body, size: 7pt, fill: colors.mid, tracking: 1.5pt, upper(label))
      )
    }
  ]
}


/// Triple-dupe — same image three times across, outer two mirrored.
/// Rhythm through repetition; the seams become the subject.
///
/// Parameters:
///   img     [content] - image (shown three times)
///   label   [str]     - rotated label on left seam
///   caption [str]     - bottom-left caption
///   ink     [color]   - override ink
#let page-image-dupe-triple(
  img,
  label:   none,
  caption: none,
  ink:     auto,
) = context {
  let resolved-ink   = if ink == auto { text.fill } else { ink }
  let resolved-paper = page.fill

  page(margin: 0pt)[
    #grid(columns: (1fr, 1fr, 1fr), gutter: 0pt)[
      #block(width: 100%, height: 100%, spacing: 0pt, inset: 0pt, clip: true)[
        #scale(x: -100%)[#img]
      ]
    ][
      #block(width: 100%, height: 100%, spacing: 0pt, inset: 0pt, clip: true)[#img]
    ][
      #block(width: 100%, height: 100%, spacing: 0pt, inset: 0pt, clip: true)[
        #scale(x: -100%)[#img]
      ]
    ]
    #if label != none {
      place(left + horizon,
        dx: 33.3% + 4pt,
        rotate(-90deg,
          block(fill: resolved-paper, inset: (x: 8pt, y: 3pt))[
            #text(font: fonts.body, size: 6pt, fill: resolved-ink, tracking: 3pt, upper(label))
          ]
        )
      )
    }
    #if caption != none {
      place(bottom + left, dx: 14pt, dy: -14pt,
        text(font: fonts.body, size: 7pt, fill: colors.mid, tracking: 0.5pt, upper(caption))
      )
    }
  ]
}

/// Dupe-shift — two images side by side, one nudged up, paper strip revealed at bottom.
/// The shift creates a register-misalignment tension.
///
/// Parameters:
///   img1    [content] - left image
///   img2    [content] - right image (or same image)
///   shift   [ratio]   - how far the right panel shifts up (default 20%)
///   label   [str]     - label in the paper strip
///   caption [str]     - bottom-left caption
///   ink     [color]   - override ink
#let page-image-dupe-shift(
  img1,
  img2,
  shift:   20%,
  label:   none,
  caption: none,
  ink:     auto,
) = context {
  let resolved-ink   = if ink == auto { text.fill } else { ink }
  let resolved-paper = page.fill

  page(margin: 0pt, fill: resolved-paper)[
    #block(width: 50%, height: 100%, spacing: 0pt, inset: 0pt, clip: true)[#img1]
    #place(top + right,
      dy: -(100% * shift),
      block(width: 50%, height: 100% + (100% * shift), spacing: 0pt, inset: 0pt, clip: true)[#img2]
    )
    #place(bottom + right,
      dy: 0pt,
      block(
        width:   50%,
        height:  100% * shift,
        fill:    resolved-paper,
        inset:   (x: 16pt, y: 10pt),
        spacing: 0pt,
        stroke:  (top: 2pt + resolved-ink),
      )[
        #if label != none {
          set par(leading: 0.72em)
          text(font: fonts.display, size: 28pt, weight: 300, fill: resolved-ink,
            tracking: -0.5pt, upper(label))
        }
      ]
    )
    #if caption != none {
      place(bottom + left, dx: 14pt, dy: -14pt,
        text(font: fonts.body, size: 7pt, fill: colors.mid, tracking: 0.5pt, upper(caption))
      )
    }
  ]
}


/// Triptych-dominant — three vertical panels at unequal widths; center dominates.
/// Swiss asymmetry: one panel commands, two flank.
///
/// Parameters:
///   img1, img2, img3  [content] - left, center, right panels
///   widths            [array]   - three widths, e.g. (20%, 58%, 22%)
///   captions          [array]   - per-panel captions (optional)
///   label             [str]     - top-right tag
///   ink               [color]   - override ink
#let page-image-triptych-dominant(
  img1,
  img2,
  img3,
  widths:   (20%, 58%, 22%),
  captions: (),
  label:    none,
  ink:      auto,
) = context {
  let resolved-ink   = if ink == auto { text.fill } else { ink }
  let resolved-paper = page.fill
  let cap-h = if captions.len() > 0 { 26pt } else { 0pt }

  page(margin: 0pt)[
    #grid(
      columns: widths,
      gutter:  0pt,
    )[
      #block(width: 100%, height: 100% - cap-h, spacing: 0pt, inset: 0pt, clip: true)[#img1]
    ][
      #block(width: 100%, height: 100% - cap-h, spacing: 0pt, inset: 0pt, clip: true)[#img2]
    ][
      #block(width: 100%, height: 100% - cap-h, spacing: 0pt, inset: 0pt, clip: true)[#img3]
    ]
    #if captions.len() > 0 {
      place(bottom + left, dy: 0pt,
        block(width: 100%, height: cap-h, fill: resolved-paper, spacing: 0pt)[
          #line(length: 100%, stroke: 0.5pt + resolved-ink)
          #grid(columns: widths, gutter: 0pt)[
            #block(inset: (x: 8pt, y: 5pt))[
              #text(font: fonts.body, size: 6pt, fill: colors.mid, tracking: 1pt,
                upper(if captions.len() >= 1 { captions.at(0) } else { "" }))
            ]
          ][
            #block(inset: (x: 8pt, y: 5pt), stroke: (left: 0.5pt + colors.mid))[
              #text(font: fonts.body, size: 6pt, fill: colors.mid, tracking: 1pt,
                upper(if captions.len() >= 2 { captions.at(1) } else { "" }))
            ]
          ][
            #block(inset: (x: 8pt, y: 5pt), stroke: (left: 0.5pt + colors.mid))[
              #text(font: fonts.body, size: 6pt, fill: colors.mid, tracking: 1pt,
                upper(if captions.len() >= 3 { captions.at(2) } else { "" }))
            ]
          ]
        ]
      )
    }
    #if label != none {
      place(top + right, dx: -14pt, dy: 14pt,
        text(font: fonts.body, size: 7pt, fill: colors.mid, tracking: 1.5pt, upper(label))
      )
    }
  ]
}

/// Overlay-multi — full-bleed bg with TWO inset images at different positions/sizes.
/// Acid collage: depth through layering, no single focal point.
///
/// Parameters:
///   img       [content] - full-bleed background
///   img2      [content] - first overlay (top-right area)
///   img3      [content] - second overlay (bottom-left area)
///   w2        [ratio]   - width of first overlay (default 40%)
///   w3        [ratio]   - width of second overlay (default 34%)
///   caption   [str]     - bottom caption
///   label     [str]     - top-right tag
///   ink       [color]   - override ink
#let page-image-overlay-multi(
  img,
  img2:    none,
  img3:    none,
  w2:      40%,
  w3:      34%,
  caption: none,
  label:   none,
  ink:     auto,
) = context {
  let resolved-ink = if ink == auto { text.fill } else { ink }

  page(margin: 0pt)[
    #block(width: 100%, height: 100%, spacing: 0pt, inset: 0pt, clip: true)[#img]
    #if img2 != none {
      place(top + right,
        dx: -18pt,
        dy: 16%,
        block(width: w2, spacing: 0pt, inset: 0pt, clip: true)[#box(width: 100%, height: 100%)[#img2]]
      )
      place(top + right,
        dx: -18pt - 22pt,
        dy: 16% - 12pt,
        rotate(-90deg,
          text(font: fonts.body, size: 6pt, fill: colors.mid, tracking: 2pt, upper("01"))
        )
      )
    }
    #if img3 != none {
      place(bottom + left,
        dx: 18pt,
        dy: -16%,
        block(width: w3, spacing: 0pt, inset: 0pt, clip: true)[#box(width: 100%, height: 100%)[#img3]]
      )
      place(bottom + left,
        dx: 18pt + 6pt,
        dy: -16% - 12pt,
        rotate(-90deg,
          text(font: fonts.body, size: 6pt, fill: colors.mid, tracking: 2pt, upper("02"))
        )
      )
    }
    #if caption != none {
      place(bottom + left, dx: 14pt, dy: -14pt,
        text(font: fonts.body, size: 7pt, fill: colors.mid, tracking: 0.5pt, upper(caption))
      )
    }
    #if label != none {
      place(top + right, dx: -14pt, dy: 14pt,
        text(font: fonts.body, size: 7pt, fill: colors.mid, tracking: 1.5pt, upper(label))
      )
    }
  ]
}

/// Quadrant — four images in an irregular 2×2 grid; rows and columns are unequal.
/// Asymmetric axes: the horizontal and vertical cuts do not bisect.
///
/// Parameters:
///   img1..img4  [content] - four images (tl, tr, bl, br)
///   col-split   [ratio]   - left column width (default 55%)
///   row-split   [ratio]   - top row height (default 62%)
///   rule-w      [length]  - rule weight at seams (default 2pt)
///   captions    [array]   - per-quadrant captions (optional, max 4)
///   label       [str]     - top-right tag
///   ink         [color]   - override ink
#let page-image-quadrant(
  img1,
  img2,
  img3,
  img4,
  col-split:  55%,
  row-split:  62%,
  rule-w:     2pt,
  captions:   (),
  label:      none,
  ink:        auto,
) = context {
  let resolved-ink   = if ink == auto { text.fill } else { ink }
  let resolved-paper = page.fill
  let col2 = 100% - col-split
  let row2 = 100% - row-split

  page(margin: 0pt)[
    #grid(columns: (col-split, col2), rows: (row-split, row2), gutter: 0pt)[
      #block(width: 100%, height: 100%, spacing: 0pt, inset: 0pt, clip: true)[#img1]
    ][
      #block(width: 100%, height: 100%, spacing: 0pt, inset: 0pt, clip: true)[#img2]
    ][
      #block(width: 100%, height: 100%, spacing: 0pt, inset: 0pt, clip: true)[#img3]
    ][
      #block(width: 100%, height: 100%, spacing: 0pt, inset: 0pt, clip: true)[#img4]
    ]
    #if captions.len() > 0 {
      let cap-positions = (
        (dx: 8pt,         dy: row-split - 18pt),
        (dx: col-split + 8pt, dy: row-split - 18pt),
        (dx: 8pt,         dy: 100% - 14pt),
        (dx: col-split + 8pt, dy: 100% - 14pt),
      )
      for i in range(calc.min(captions.len(), 4)) {
        let pos = cap-positions.at(i)
        place(top + left, dx: pos.dx, dy: pos.dy,
          text(font: fonts.body, size: 6pt, fill: colors.mid, tracking: 1pt, upper(captions.at(i)))
        )
      }
    }
    #if label != none {
      place(top + right, dx: -14pt, dy: 14pt,
        text(font: fonts.body, size: 7pt, fill: colors.mid, tracking: 1.5pt, upper(label))
      )
    }
  ]
}

/// Drift — three images at staggered positions; no grid, images bleed off edges.
/// New Wave: compositional weight is off-center, tension through imbalance.
///
/// Parameters:
///   img1    [content] - bleeds full left edge, takes upper 65% of page
///   img2    [content] - small, anchored top-right, overlaps img1 slightly
///   img3    [content] - anchored bottom, spans 70% width from right edge
///   label   [str]     - rotated label, center-left
///   caption [str]     - bottom-left caption
///   ink     [color]   - override ink
#let page-image-drift(
  img1,
  img2:    none,
  img3:    none,
  label:   none,
  caption: none,
  ink:     auto,
) = context {
  let resolved-ink   = if ink == auto { text.fill } else { ink }
  let resolved-paper = page.fill

  page(margin: 0pt)[
    #block(width: 68%, height: 70%, spacing: 0pt, inset: 0pt, clip: true)[#img1]
    #if img2 != none {
      place(top + right,
        dx: 0pt,
        dy: 8%,
        block(width: 38%, height: 44%, spacing: 0pt, inset: 0pt, clip: true)[#img2]
      )
    }
    #if img3 != none {
      place(bottom + right,
        dx: 0pt,
        dy: 0pt,
        block(width: 72%, height: 36%, spacing: 0pt, inset: 0pt, clip: true)[#img3]
      )
    }
    #if label != none {
      place(left + horizon,
        dx: 8pt,
        rotate(-90deg,
          block(fill: resolved-paper, inset: (x: 8pt, y: 3pt))[
            #text(font: fonts.body, size: 6pt, fill: resolved-ink, tracking: 3pt, upper(label))
          ]
        )
      )
    }
    #if caption != none {
      place(bottom + left, dx: 14pt, dy: -14pt,
        text(font: fonts.body, size: 7pt, fill: colors.mid, tracking: 0.5pt, upper(caption))
      )
    }
  ]
}

/// Stagger — three images in a staircase offset layout; each panel shifts right and down.
/// Pure register tension: nothing aligns, everything rhymes.
///
/// Parameters:
///   img1    [content] - top-left anchor
///   img2    [content] - shifted right + down
///   img3    [content] - further right + down, bleeds bottom-right
///   rule-w  [length]  - rule weight (default 1.5pt)
///   label   [str]     - top-left tag
///   caption [str]     - bottom-right caption
///   ink     [color]   - override ink
#let page-image-stagger(
  img1,
  img2,
  img3:    none,
  rule-w:  1.5pt,
  label:   none,
  caption: none,
  ink:     auto,
) = context {
  let resolved-ink   = if ink == auto { text.fill } else { ink }
  let resolved-paper = page.fill

  page(margin: 0pt, fill: resolved-paper)[
    #block(width: 58%, height: 52%, spacing: 0pt, inset: 0pt, clip: true)[#img1]
    #place(top + left,
      dx: 22%,
      dy: 36%,
      block(width: 58%, height: 52%, spacing: 0pt, inset: 0pt, clip: true)[#img2]
    )
    #if img3 != none {
      place(top + left,
        dx: 42%,
        dy: 62%,
        block(width: 58%, height: 38%, spacing: 0pt, inset: 0pt, clip: true)[#img3]
      )
    }
    #if label != none {
      place(top + left, dx: 14pt, dy: 14pt,
        text(font: fonts.body, size: 6.5pt, fill: colors.mid, tracking: 2pt, upper(label))
      )
    }
    #if caption != none {
      place(bottom + right, dx: -14pt, dy: -14pt,
        text(font: fonts.body, size: 7pt, fill: colors.mid, tracking: 0.5pt, upper(caption))
      )
    }
  ]
}

/// Collision — two images that meet and overlap at an off-center vertical seam.
/// A 3pt rule cuts through both; one image intrudes into the other's territory.
///
/// Parameters:
///   img1      [content] - left image
///   img2      [content] - right image
///   seam      [ratio]   - horizontal position of the hard seam (default 42%)
///   intrude   [ratio]   - how far img2 bleeds left past the seam (default 12%)
///   label     [str]     - rotated label at seam
///   caption   [str]     - bottom-left caption
///   ink       [color]   - override ink
#let page-image-collision(
  img1,
  img2,
  seam:    42%,
  intrude: 12%,
  label:   none,
  caption: none,
  ink:     auto,
) = context {
  let resolved-ink   = if ink == auto { text.fill } else { ink }
  let resolved-paper = page.fill

  page(margin: 0pt)[
    #block(width: seam + intrude, height: 100%, spacing: 0pt, inset: 0pt, clip: true)[#img1]
    #place(top + left,
      dx: seam - intrude,
      dy: 0pt,
      block(width: 100% - seam + intrude, height: 100%, spacing: 0pt, inset: 0pt, clip: true)[#img2]
    )
    #if label != none {
      place(left + horizon,
        dx: seam + 6pt,
        rotate(-90deg,
          block(fill: resolved-paper, inset: (x: 8pt, y: 3pt))[
            #text(font: fonts.body, size: 6pt, fill: resolved-ink, tracking: 3pt, upper(label))
          ]
        )
      )
    }
    #if caption != none {
      place(bottom + left, dx: 14pt, dy: -14pt,
        text(font: fonts.body, size: 7pt, fill: colors.mid, tracking: 0.5pt, upper(caption))
      )
    }
  ]
}

/// Corner-pull — one image dominates three corners; a small image is pinned to the
/// fourth corner at a different scale, creating diagonal visual tension.
///
/// Parameters:
///   img1      [content] - large image (fills page)
///   img2      [content] - small corner image
///   corner    [align]   - which corner img2 occupies (default bottom + right)
///   img2-w    [ratio]   - width of img2 (default 36%)
///   img2-h    [ratio]   - height of img2 (default 30%)
///   rule-w    [length]  - rule bordering img2 (default 2pt)
///   label     [str]     - rotated label beside img2
///   caption   [str]     - bottom caption
///   ink       [color]   - override ink
#let page-image-corner-pull(
  img1,
  img2:    none,
  corner:  bottom + right,
  img2-w:  36%,
  img2-h:  30%,
  rule-w:  2pt,
  label:   none,
  caption: none,
  ink:     auto,
) = context {
  let resolved-ink   = if ink == auto { text.fill } else { ink }
  let resolved-paper = page.fill
  let h-anchor = if corner.x == right { right } else { left }
  let v-anchor = if corner.y == bottom { bottom } else { top }
  let dx-val = 0pt
  let dy-val = 0pt

  page(margin: 0pt)[
    #block(width: 100%, height: 100%, spacing: 0pt, inset: 0pt, clip: true)[#img1]
    #if img2 != none {
      place(v-anchor + h-anchor,
        dx: dx-val,
        dy: dy-val,
        block(width: img2-w, height: img2-h, spacing: 0pt, inset: 0pt, clip: true)[#box(width: 100%, height: 100%)[#img2]]
      )
      place(v-anchor + h-anchor,
        dx: if h-anchor == right { -img2-w - 18pt } else { img2-w + 6pt },
        dy: if v-anchor == bottom { -img2-h + 16pt } else { img2-h - 16pt },
        rotate(-90deg,
          text(font: fonts.body, size: 6pt, fill: colors.mid, tracking: 2pt,
            upper(if label != none { label } else { "detail" }))
        )
      )
    }
    #if caption != none {
      place(bottom + left, dx: 14pt, dy: -14pt,
        text(font: fonts.body, size: 7pt, fill: colors.mid, tracking: 0.5pt, upper(caption))
      )
    }
  ]
}

// ─── CONVENIENCE RE-EXPORTS ──────────────────────────────────────────────────

#let accent      = colors.accent
#let zine-fonts  = fonts
#let zine-colors = colors
