# brutalist-webzine — Astro project context

Astro static site implementation of the brutalist webzine. Single-column dark brutalist aesthetic. Web-only for now (print/PDF deferred).

## Stack

- **Astro 7** — static site generator
- **MDX** (`@astrojs/mdx`) — article content with inline components
- **Motion** (`motion`) — vanilla JS scroll animations via `inView` + `animate`
- **No framework** (no React/Vue/Svelte) — pure Astro components

## Structure

```
src/
  layouts/
    Layout.astro          — base HTML shell, imports global CSS, runs all Motion animations
  components/
    Cover.astro           — full-bleed front cover (8.5:11 aspect)
    InsideCover.astro     — inside cover with image bg + text overlay
    InsideBackCover.astro — inside back cover
    BackCover.astro       — full-bleed back cover
    Masthead.astro        — issue/title/asymmetric rule
    TOCEntry.astro        — table of contents row (anchor links to #article-id)
    ZRule.astro           — asymmetric horizontal rule with optional label
    ArticlePage.astro     — fullscreen tiled image splash (WM-style layouts, 8.5:11)
    ArticleImage.astro    — centered inline article image with caption
    Byline.astro          — dash-leader byline
    PullQuote.astro       — bordered pull-quote with attribution
    Callout.astro         — left-bar callout with title
    Manifesto.astro       — large display statement block
  content/
    articles/             — MDX files (one per article)
  data/
    articleLayouts.ts     — image arrays + layout names per article (keyed by article id)
  styles/
    global.css            — all styles; also sets opacity:0 initial states for animated elements
  pages/
    index.astro           — single long-scroll page: cover → inside cover → masthead/TOC → all articles → letters → back covers
    articles/[slug].astro — individual article pages (still exist but not linked from TOC)
public/
  images/                 — image1-4.jpg, soldiers.png, rifle.png, handgun.png
  fonts/                  — SpaceGrotesk-VariableFont_wght.ttf + static/
```

## Article layout system

Layouts live in `src/data/articleLayouts.ts`, keyed by article `id` (filename without extension). This avoids MDX frontmatter parsing issues with hyphenated values.

Layout names (single-word, no hyphens):

| Name | Description |
|---|---|
| `mainleft` | large left, two stacked right |
| `mainright` / `vstackinv` | two stacked left, large right |
| `hsplit` / `maintop` | wide top, two bottom |
| `hstackinv` / `mainbottom` | two top, wide bottom |
| `vstack` | alias for mainleft |
| `vsplit` | side by side |
| `monocle` | single full-bleed |
| `grid` | 2×2 equal |
| `cornerpull` | large top-left, narrow right, wide bottom |
| `dupeshift` | overlapping offset (opacity blend) |
| `dupe` | mirrored side by side |
| `dupetriple` | three columns, center mirrored |
| `fibonacci` | 3:2 left, stacked right |
| `stagger` | diagonal offset rows |
| `collision` | clip-path split |
| `mirrorh` / `mirrorv` | flip axis |
| `overlay` | full-bleed blend |
| `drift` | two wide panels |
| `asymmetric` | 1:2:1 columns |

## Animations (Motion)

All in `Layout.astro` `<script>`. Uses `inView` + `animate` + `stagger` from `motion`.

- **Cover overlay** — slide up on load
- **ArticlePage cells** — staggered scale-in on scroll, overlay fades up 300ms later
- **Article headers** — label → h1 → rule → byline cascade
- **Paragraphs** — fade + nudge up per-paragraph
- **Pull-quotes** — slide in from left
- **Callouts** — slide in from left
- **Manifestos** — scale up
- **ZRules** — scaleX wipe in

Initial `opacity: 0` set in CSS for all animated elements so there's no flash before JS runs.

## Dev commands

```sh
npm run dev       # dev server at localhost:4321
npm run build     # static build to dist/
npm run preview   # preview build
```

## Known issues / notes

- MDX frontmatter cannot contain hyphenated bare values — the MDX compiler treats them as JSX subtraction expressions. Always quote or avoid hyphens in frontmatter strings. Layout data is kept in `articleLayouts.ts` for this reason.
- Individual article pages at `/articles/[slug]` still exist and build, but TOC now links to `#anchor` on the index page for the single-scroll experience.
- `motion` package is vanilla JS (no React needed) — uses `inView` from the Motion DOM API.
