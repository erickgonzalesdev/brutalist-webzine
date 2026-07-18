# brutalist-webzine — project context

Typst package + template for aesthetically brutal webzines. Targets both print (PDF) and web (HTML static site).

## Files

```
lib.typ            — main package: palette, fonts, templates, component library
typst.toml         — package manifest (name: brutalist-webzine, version: 0.1.0)
example.typ        — 2-column print demo ("SIGNAL/NOISE #07")
example-html.typ   — same content wired to webzine-html for HTML export
demo.typ           — minimal 1-column demo ("VOID DISPATCH #03") — current preferred aesthetic
demo.pdf           — compiled output of demo.typ
example.pdf        — compiled output of example.typ
example.html       — compiled output of example-html.typ
```

## Compile commands

```sh
typst compile demo.typ                                                        # PDF
typst compile --features html --format html example-html.typ example.html    # HTML (experimental)
typst watch demo.typ                                                          # live preview
```

## Design language

- **Monospace body** (Liberation Mono / FreeMono) + **sans display** (Noto Sans)
- **Black ink on white paper** — no gratuitous color; accent is optional and defaults to black in demo
- **Exposed structure**: rules, borders, grids are visible, not hidden
- **Anti-polish**: negative space and restraint over decoration
- The minimal 1-column layout (demo.typ) is the preferred direction — strip components rather than add them

## lib.typ — key exports

### Templates
| Function | Use |
|---|---|
| `webzine(title, issue, date, cols, accent, format, margins, body)` | Print/PDF — sets page, footer, columns |
| `webzine-html(title, issue, date, accent, body)` | HTML — no page config, no footer |

`format` options: `"letter"` `"a4"` `"tabloid"` `"half"`

### Components
| Function | Notes |
|---|---|
| `section("label")` | Full-width black label bar + rule — use sparingly |
| `pull-quote(attribution:, body)` | Large bold quote, thick left border |
| `callout(title:, accent:, body)` | Bordered box; accent param controls color |
| `manifesto(body)` | Inverted full-width block, all caps |
| `hero(caption:, body)` | Image frame, 4pt border |
| `compare(left-label:, right-label:, left, right)` | 2-col grid |
| `tag(body)` | Inline black chip |
| `zrule(label:)` | Horizontal rule, optional label |
| `toc-entry(title, page-num, blurb:)` | TOC row |
| `sticker(angle:, fill:, body)` | Rotated badge |
| `byline(name, role:, date:)` | Article byline |

### Palette / fonts (accessible after import)
```typst
colors.ink / colors.paper / colors.accent / colors.mid
fonts.body / fonts.display / fonts.alt
accent          // shorthand for colors.accent
zine-colors     // alias for colors
zine-fonts      // alias for fonts
```

## Known issues / limitations

- **HTML export is experimental** in Typst 0.13 — layout elements (lines, grids, `#v()`, `#h()`) are silently dropped. Semantic content comes through fine. Use `--features html` flag.
- `webzine` uses `set page(...)` so it **cannot** be used inside a container or for HTML export. Use `webzine-html` for that.
- Font stack: Liberation Mono + FreeMono (body), Noto Sans (display/alt) — these are present on this system. On other systems adjust `fonts` dict in lib.typ or pass fonts as a Typst system font.
- `cols:` parameter (not `columns:`) — renamed to avoid shadowing Typst's built-in `columns` function.

## Aesthetic direction notes

The demo.typ iteration landed on:
- 1 column, wide margins (0.9in), `accent: black`
- Flat TOC (no blurbs), prose carries structure
- Use `pull-quote` and `manifesto` for visual breaks — skip stickers/tags/section banners unless the content calls for them
- Less is more: the blank space is the design

Next things to consider:
- A half-letter (`format: "half"`) version for physical zine printing (fold letter sheet in half)
- A `newspaper` layout variant with a wider masthead and 3-col body
- Custom font support via `#set text(font: ...)` after the show rule
- A CSS stylesheet companion for the HTML output to restore visual fidelity
