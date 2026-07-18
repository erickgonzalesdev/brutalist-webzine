// brutalist-webzine — example issue
// compile: typst compile example.typ
// html:    typst compile --format html example.typ example.html

#import "lib.typ": *

#show: webzine.with(
  title:    "SIGNAL/NOISE",
  issue:    "07",
  date:     "SUMMER 2025",
  cols:     2,
  accent:   rgb("#ff2d00"),
  format:   "letter",
  margins:  0.65in,
)

// ── FRONT MATTER / TOC ──────────────────────────────────────────────────────

#section("contents")

#toc-entry("THE MACHINE TALKS BACK", 1,
  blurb: "on language models and the collapse of authorship")
#toc-entry("AGAINST CLEAN CODE", 2,
  blurb: "readability as ideology")
#toc-entry("ZINE INFRASTRUCTURE", 3,
  blurb: "self-publishing in the age of content delivery")
#toc-entry("STATIC IS POLITICAL", 4,
  blurb: "why your website should have no javascript")
#toc-entry("LETTERS", 5)

#zrule()

#sticker(angle: -5deg, fill: rgb("#ff2d00"))[FREE / TAKE ONE]

#v(0.5em)

// ── ARTICLE 1 ───────────────────────────────────────────────────────────────

= THE MACHINE TALKS BACK

#byline("K. VARMA", role: "editor", date: "JUNE 2025")

#tag("AI") #h(0.3em) #tag("language") #h(0.3em) #tag("authorship") #h(0.3em) #tag("criticism")

#v(0.5em)

#pull-quote(attribution: "overheard at a sprint retrospective")[
  It doesn't matter who wrote it, only that it shipped.
]

Something *broke* in the way we talk about writing when the outputs became indistinguishable from the inputs. Not ethically — that debate is exhausted — but _structurally_. The sentence as unit of labor. The paragraph as deployable artifact.

We used to ask: who is speaking? Now we ask: is this correct? The shift is not neutral.

Language models don't know what they're saying. They know what _sounds like_ something being said, which is close enough to fool almost everyone, including the person reading this.

#callout(title: "NOTE ON SOURCES")[
  All quotes in this piece are reconstructed from memory or composites. Attribution is a formality we maintain out of habit.
]

The interesting failure mode isn't hallucination — it's sincerity. A system that confidently assembles true-sounding statements has no stake in whether they're true. Neither do most content pipelines. This is where they converge.

#zrule(label: "continued")

What do we do with a voice that has no body? No consequence? No history of being wrong in ways that matter?

We quote it. We cite it. We put it in the byline and call it a collaborator. The machine doesn't mind.

// ── ARTICLE 2 ───────────────────────────────────────────────────────────────

= AGAINST CLEAN CODE

#byline("P. OSEI", role: "contributor")

#tag("programming") #h(0.3em) #tag("aesthetics") #h(0.3em) #tag("craft")

#v(0.5em)

Clean code is a bourgeois concept. Not metaphorically — structurally. It optimizes for _legibility to strangers_ at the cost of legibility to self. It assumes a rotating door of developers, a permanent state of onboarding.

The insistence that code be "readable" encodes a specific reader: a mid-level engineer at a FAANG adjacent company who has 15 minutes to understand your module before a standup.

#compare(
  left-label: "CLEAN",
  right-label: "HONEST",
  [
    ```
    // processes user input
    function processUserInput(input) {
      return sanitize(validate(input));
    }
    ```
  ],
  [
    ```
    // this crashes on null
    // TODO: figure out why
    // friday, don't touch
    function doTheThing(x) {
      return maybe(x)
    }
    ```
  ],
)

The "honest" version above would fail a code review. It would also tell you more about the actual state of the system.

*Mess is information.* Commented-out code is archaeology. A function named `doTheThing` is an admission. We should value admissions.

// ── ARTICLE 3 ───────────────────────────────────────────────────────────────

= ZINE INFRASTRUCTURE

#byline("M. CHEN", role: "tech editor")

#tag("publishing") #h(0.3em) #tag("infrastructure") #h(0.3em) #tag("distribution")

#v(0.5em)

A zine has always been a political object. The photocopy. The staple. The leaving-a-stack-at-the-record-store. Distribution as declaration.

What does that mean when the record store is a CDN?

#manifesto[
  The medium is not the message. The cost of reproduction is the message.
]

This zine was typeset in Typst. It compiles to PDF for print and HTML for the web in a single pass. No CMS. No subscription. No analytics. A `typst compile` invocation and an rsync to a #raw("$5/month") VPS.

The barrier to entry for print publishing is a library. The barrier for web publishing is knowing what a CNAME record is. Both are surmountable.

What's harder to surmount is the assumption that publishing requires a platform. It doesn't. It requires a file.

#callout(title: "HOW TO COMPILE THIS ZINE", accent: rgb("#0066ff"))[
  *Print PDF:*
  ```
  typst compile example.typ
  ```

  *HTML (static site):*
  ```
  typst compile --format html \
    example.typ example.html
  ```

  *Watch mode (dev):*
  ```
  typst watch example.typ
  ```
]

// ── ARTICLE 4 ───────────────────────────────────────────────────────────────

= STATIC IS POLITICAL

#byline("R. NAKAMURA", role: "contributor")

#tag("web") #h(0.3em) #tag("javascript") #h(0.3em) #tag("performance") #h(0.3em) #tag("access")

#v(0.5em)

A webpage that requires 4MB of JavaScript to display text is not a webpage. It is a negotiation between your browser and seventeen venture-backed companies about whether you're allowed to read something.

#pull-quote(attribution: "someone's homepage, circa 2002")[
  best viewed in 800×600
]

The static page has no opinions about your device. It doesn't track sessions. It doesn't A/B test your attention span. It loads on a 3G connection in a place where 3G is an achievement.

"But you can't do X without JavaScript" — fine. Don't do X. Does X need doing?

The web got fast and then it got slow again because we used the speed budget on surveillance infrastructure. Static is not a technical limitation. It's a political choice to not participate in that.

#hero(caption: "figure 1: the entire infrastructure for this zine")[
  #align(center)[
    #block(
      fill:   rgb("#111"),
      width:  100%,
      inset:  16pt,
    )[
      #text(font: ("Liberation Mono", "FreeMono"), size: 9pt, fill: rgb("#0f0"))[
        ```
        typst file → PDF / HTML → rsync → VPS
        ```
      ]
    ]
  ]
]

// ── LETTERS ─────────────────────────────────────────────────────────────────

= LETTERS

#section("from readers")

#callout(title: "RE: ISSUE 06 — ON ATTENTION")[
  The piece on attention spans missed the obvious point: attention isn't declining, it's being harvested. — *T.K., Portland*
]

#v(0.5em)

#callout(title: "CORRECTION")[
  In issue 06 we stated that RSS is dead. RSS is not dead. We regret the error. RSS is doing fine. — *the editors*
]

#v(0.5em)

#callout(title: "SUBMISSION")[
  Write something true. Keep it under 800 words. No pitches. Send plaintext. — *signal-noise #sym.at example.com*
]

#zrule(label: "end of issue 07")

#align(center)[
  #v(1em)
  #text(font: fonts.display, size: 9pt, fill: colors.mid)[
    SIGNAL/NOISE IS PUBLISHED IRREGULARLY.\
    COPY IT. SHARE IT. CHANGE IT.\
    ATTRIBUTION APPRECIATED, NOT REQUIRED.
  ]
]
