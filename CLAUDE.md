# brutalist-webzine — project context

Typst package + template for aesthetically brutal webzines. Targets both print (PDF) and web (HTML static site).

## Files

```
lib.typ            — main package: palette, fonts, templates, component library
typst.toml         — package manifest (name: brutalist-webzine, version: 0.1.0)
example.typ        — 2-column print demo ("SIGNAL/NOISE #07")
example-html.typ   — same content wired to webzine-html for HTML export
demo.typ           — 1-column demo ("VOID DISPATCH #03") — current preferred aesthetic, 16 pages
demo.pdf           — compiled output of demo.typ
example.pdf        — compiled output of example.typ
example.html       — compiled output of example-html.typ
fonts/             — Space Grotesk variable font (SpaceGrotesk-VariableFont_wght.ttf + static/)
```

## Compile commands

```sh
typst compile --font-path fonts demo.typ                                                        # PDF
typst compile --font-path fonts --features html --format html example-html.typ example.html    # HTML (experimental)
typst watch --font-path fonts demo.typ                                                          # live preview
```

`--font-path fonts` is required to load Space Grotesk from the local `fonts/` directory.

## Design language — current (New Wave / Weingart)

- **Monospace body** (Liberation Mono) + **Space Grotesk display** (weight 300 — light)
- **Dark mode by default** in demo.typ (`dark: true`, `accent: white`)
- **New Wave typography**: font collision (mono body + grotesque display), asymmetric rules, rotated labels, large type as graphic element
- Masthead: tiny tracked issue/date in accent above 52pt title, asymmetric rule (4pt ink / accent square / 0.5pt ink)
- H1: `——  article` label in accent above 32pt title, 2:1 split rule below
- H2: `///` suffix in accent mono
- **Meander** text-wrap integration for images (`@preview/meander:0.4.3`) — available via `wrap-image()` in lib.typ
- **Cover pages**: cover, inside-cover, inside-back-cover, back-cover (placed outside `#show: webzine.with(...)`)
- **Page images**: full-bleed `page-image(img, caption:, label:)` component
- **PNG images**: soldiers.png, rifle.png, handgun.png — background-removed, cropped tight to content

## lib.typ — key exports

### Templates
| Function | Use |
|---|---|
| `webzine(title, issue, date, cols, accent, format, margins, dark, show-masthead, body)` | Print/PDF — sets page, footer, columns |
| `webzine-html(title, issue, date, accent, dark, body)` | HTML — no page config, no footer |

`format` options: `"letter"` `"a4"` `"tabloid"` `"half"`

### Cover pages (used outside `#show: webzine.with(...)`)
| Function | Notes |
|---|---|
| `cover(title, issue, date, img, accent, ink, paper)` | Full-bleed front cover, 64pt title bottom-left |
| `inside-cover(img, body, accent, ink, paper)` | Faces TOC; editorial/credits text top-left |
| `inside-back-cover(img, body, accent, ink, paper)` | Faces last content page |
| `back-cover(title, issue, date, tagline, img, accent, ink, paper)` | Full-bleed back, mirrored rule |

### Content components
| Function | Notes |
|---|---|
| `section("label")` | Full-width inverted label bar + rule |
| `pull-quote(attribution:, body)` | `  quote  ` label + 22pt bold, left+top border |
| `callout(title:, accent:, body)` | 3pt left bar, tracked uppercase label |
| `manifesto(body)` | Inverted block, `  statement  ` label, 34pt display |
| `page-image(img, caption:, label:)` | Full-bleed page — place between articles |
| `wrap-image(img, width:, align:, gap:, caption:, body)` | Meander text-wrap; default width 55% |
| `compare(left-label:, right-label:, left, right)` | 2-col open grid |
| `tag(body)` | Inline chip |
| `zrule(label:)` | Asymmetric horizontal rule (2:1, accent square) |
| `toc-entry(title, page-num, blurb:)` | Page number left in accent, title right |
| `sticker(angle:, fill:, body)` | Rotated badge |
| `byline(name, role:, date:)` | Accent dash leader byline |
| `article-page(title, author, issue, date, images, layout, title-pos, master-count, gap, stack)` | Full-bleed image page. |
| | **`gap`** `[length]` — gutter between tiles (default `0pt`) |
| | **`master-count`** `[int]` — number of master windows for nh-stack/nv-stack/mirror-* |
| | **`stack`** `[dict]` — floating image stack composited on top of the tiling layer: `(images: (), anchor: bottom+right, width: 38%, height: 32%, offset: 14pt)`. `anchor` sets which corner; `offset` is the cascade step between frames. Composable with any layout. |
| | **Tiling WM-style layouts**: `monocle`, `h-split`, `v-split`, `h-stack`, `h-stack-inv`, `v-stack`, `v-stack-inv`, `nh-stack`, `nv-stack`, `mirror-h`, `mirror-v`, `columns`, `rows`, `grid`, `fibonacci` |
| | **Creative/editorial layouts**: `dupe`, `dupe-triple`, `dupe-shift`, `overlay`, `asymmetric`, `collision`, `stagger`, `drift`, `corner-pull` |
| | **Legacy aliases**: `hsplit`=`h-split`, `vsplit`=`v-split`, `main-left`=`v-stack`, `main-right`=`v-stack-inv`, `main-top`=`h-stack`, `main-bottom`=`h-stack-inv` |

### Palette / fonts
```typst
colors.ink / colors.paper / colors.accent / colors.mid
fonts.body     // Liberation Mono, FreeMono
fonts.display  // Space Grotesk, Aporetic Sans, Noto Sans, Liberation Sans
accent         // shorthand for colors.accent
```

## Font weights

Space Grotesk is a variable font (wght axis 300–700). Use **numeric weights** — named weights (`"semibold"`, `"medium"`) do not reliably map in Typst 0.13. Current display weight is `300` (light) throughout lib.typ.

## Known issues / limitations

- **HTML export is experimental** in Typst 0.13 — layout elements (lines, grids, `#v()`, `#h()`) are silently dropped. Semantic content comes through fine.
- `webzine` uses `set page(...)` so it **cannot** be used inside a container or for HTML export. Use `webzine-html` for that.
- `cols:` parameter (not `columns:`) — renamed to avoid shadowing Typst's built-in `columns` function.
- **meander 0.4.3 patch**: `~/.cache/typst/packages/preview/meander/0.4.3/src/bisect.typ` line 6 — `sym.chevron.l` removed in Typst 0.13, patched to `sym.arrow.r`.
- Components use `context { let ink = text.fill; let paper = page.fill }` to inherit dark/light mode — do not pass colors directly to components.
- **article-page spacing fix**: `page(margin: 0pt)` blocks require `#set block(spacing: 0pt, above: 0pt, below: 0pt)` and `#set par(spacing: 0pt, leading: 0pt)` at the top of the page body to eliminate implicit gaps between image blocks. Without this, Typst's default paragraph/block spacing creates visible seams between images.

## Aesthetic direction notes

Current demo.typ (`VOID DISPATCH #03`) is 16 pages:
- Cover → Inside Cover → TOC + masthead → Full-page image → 6 articles → Letters → Inside Back Cover → Back Cover
- Each article has a centered PNG image (32em tall) at the top, then body text below
- `dark: true`, `accent: white`, 1 column, 0.9in margins
- PNG images (soldiers.png, rifle.png, handgun.png) are placed via `#align(center)[#png1]` directly in demo.typ

Next things to consider:
- A half-letter (`format: "half"`) version for physical zine printing
- A `newspaper` layout variant with wider masthead and 3-col body
- A CSS stylesheet companion for the HTML output to restore visual fidelity
- `page-image` with actual photography (currently using gradient rects as placeholders)
