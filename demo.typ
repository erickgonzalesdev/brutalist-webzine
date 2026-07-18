#import "lib.typ": *

#cover(
  title:  "VOID DISPATCH",
  issue:  "03",
  date:   "AUTUMN 2025",
  img:    rect(width: 100%, height: 100%, fill: gradient.linear(rgb("#0d0000"), black, angle: 160deg)),
  accent: rgb("#ff2d00"),
)

#inside-cover(
  img:  rect(width: 100%, height: 100%, fill: gradient.linear(black, rgb("#100500"), angle: 30deg)),
  body: [
    *Void Dispatch* is a zine about cities, infrastructure, and the systems we live inside.
    Free to read. Free to print. Free to leave somewhere.

    Contributing writers: Dana Ferris, M. Okafor,\ T. Nakamura, S. Reyes.

    Printed on whatever you have.\
    void-dispatch #sym.at proton.me
  ],
)

#show: webzine.with(
  title:   "VOID DISPATCH",
  issue:   "03",
  date:    "AUTUMN 2025",
  cols:          1,
  accent:        rgb("#ff2d00"),
  format:        "letter",
  margins:       0.9in,
  dark:          true,
  show-masthead: true,
)

#toc-entry("CITIES THAT NEVER SLEEP", 1)
#toc-entry("THREE WAYS TO DISAPPEAR", 2)
#toc-entry("THE LAST PAYPHONE", 3)
#toc-entry("SMALL GRID THEORY", 4)

#zrule()

#page-image(
  rect(width: 100%, height: 100%, fill: gradient.linear(black, rgb("#1a0a00"), angle: 135deg)),
  caption: "void dispatch — the city at 3am",
  label:   "issue 03",
)

= CITIES THAT NEVER SLEEP

#byline("DANA FERRIS")

There is a version of the 24-hour city that is glamorous. Jazz clubs. Diners. The last bus home and someone interesting on it. That version existed, briefly, in a handful of places, and it was good.

The version we have now is different. It is *logistics*. It is a warehouse that cannot go dark because the sortation algorithm runs continuously and the humans inside it are cheaper than the reconfiguration cost of stopping.

The romantic 24-hour city was organized around _desire_. Someone wanted to be there at 3am. The logistical 24-hour city is organized around throughput. No one wants to be there. They are there because the model requires it.

#pull-quote(attribution: "outside a fulfillment center, 3:14am")[
  The lights are always on here. That used to mean something.
]

#wrap-image(
  rect(width: 100%, height: 4.8in, fill: black),
  width:   58%,
  align:   top + right,
  caption: "fulfillment center, 3:14am",
)[
  This is the distinction that city planners, when they invoke "vibrancy," consistently fail to make. Vibrancy is not a property of illuminated windows. It is a property of people choosing to be somewhere.

  We built infrastructure for the night and called it nightlife. We built coverage for every hour and called it community. We lit every corner and called it safety. None of these substitutions are neutral.
]

#manifesto[
  A city that cannot sleep is not awake. It is running a process.
]

= THREE WAYS TO DISAPPEAR

#byline("M. OKAFOR")

This is not a paranoia piece. This is a practice piece. Paranoia assumes a specific adversary. Practice assumes a general condition and responds proportionally.

#wrap-image(
  rect(width: 100%, height: 4.2in, fill: rgb("#0a0a0a")),
  width:   60%,
  align:   top + left,
  caption: "the notebook, the calendar, the pen",
)[
  *Method one: go analog for the boring stuff.* Most surveillance is passive and opportunistic. It collects whatever flows through the pipes. A notebook does not have a privacy policy. A pocket calendar does not sync to a data broker. Shopping lists, personal notes, appointments with people you trust — none of these need a network.

  *Method two: reduce identity surface area.* You have more accounts than you need. Some are attached to your real name, phone number, a payment method, a device fingerprint. The reduction is not deactivation. It is to stop creating new ones. Every new account is a new exposure surface.

  *Method three: make boring choices visible.* Notice when you are making a choice. Not every choice requires a different decision. But many defaults were set by someone whose interests are not yours. Default on: location sharing, analytics, cross-app tracking, personalized ads. Reversing these — not in every case, just deliberately — changes what flows through the pipes.
]

#callout(title: "the actual threat model")[
  You are probably not being targeted specifically. You are in a database being queried by systems with no opinion about you as a person. The goal is not to escape the database. The goal is to make the query less useful.
]

#page-image(
  rect(width: 100%, height: 100%, fill: gradient.linear(rgb("#0a0a0a"), rgb("#1a0500"), angle: 45deg)),
  caption: "the analog stack",
  label:   "three ways to disappear",
)

= THE LAST PAYPHONE

#byline("T. NAKAMURA")

_A photo essay without photos, because we lost the memory card._

#wrap-image(
  rect(width: 100%, height: 5in, fill: rgb("#080808")),
  width:   55%,
  align:   top + right,
  caption: "linknyc kiosk, delancey st",
)[
  The payphone on Delancey and Essex was removed in 2019. There is a LinkNYC kiosk there now. The kiosk offers free calls, fast Wi-Fi, and a screen that displays advertisements. It also collects device identifiers from passing phones.

  The payphone offered free emergency calls and required a quarter for everything else. It collected nothing. It remembered nothing. When you hung up, the conversation was over.

  This was not a bug. This was a feature that nobody wrote down because nobody thought it would need to be defended.
]

#pull-quote(attribution: "a person who remembered the quarter")[
  You could call anyone and they couldn't call you back unless they already knew where you were.
]

The last payphone in New York City was removed from a hotel lobby in 2022. It is now in a museum. Which is the correct place for things that society has decided it no longer needs, and which is also the correct place to go to feel the specific grief of infrastructure loss.

The kiosk is faster. The kiosk is free. The kiosk is always available. The kiosk knows your phone was near it at 11:47am on a Tuesday in March.

The payphone knew nothing. That was the whole point.

#page-image(
  rect(width: 100%, height: 100%, fill: gradient.linear(rgb("#0d0d0d"), rgb("#00050a"), angle: 200deg)),
  caption: "delancey and essex, 2019",
  label:   "the last payphone",
)

= SMALL GRID THEORY

#byline("S. REYES")

#wrap-image(
  rect(width: 100%, height: 4.5in, fill: rgb("#050505")),
  width:   62%,
  align:   top + left,
  caption: "small block grid, manhattan below 14th",
)[
  The most livable neighborhoods in most cities share one physical characteristic that urban planners consistently undervalue: *small blocks*. Not "walkable" in the sense of having sidewalks. Not "mixed-use" in the sense of having a Starbucks on the ground floor of a condo tower. Small blocks. Short distances between intersections. Many choices per square mile.

  The reason small blocks win is not aesthetic. It is combinatorial. A grid of small blocks offers exponentially more route choices than a grid of large blocks covering the same area. More route choices means more foot traffic distributed across more paths means more storefronts viable means more activity.
]

Large blocks produce dead zones. Not because they are ugly — though they often are — but because a single failed anchor tenant takes an entire frontage offline. On a small block, one failed storefront is one failed storefront. On a superblock, it is four hundred feet of blank wall.

#manifesto[
  Density is not the variable. Granularity is the variable.
]

You cannot retrofit walkability onto a large-block grid by adding mixed-use zoning. You can add a coffee shop on the ground floor of a 700-foot-frontage building and it will feel like a coffee shop in an airport. Because it is.

The blocks have to be small first. Everything else follows from the blocks. Jane Jacobs said this in 1961. We have spent sixty years building the opposite.

#zrule(label: "letters")

#callout(title: "on the bus piece (issue 02)")[
  You said the bus is slow because of choices, not physics. I've been thinking about this for three weeks. You're right and I hate it. — *J.W., Chicago*
]

#v(0.4em)

#callout(title: "correction")[
  The Houston light rail does not go to the airport. We stated that it did. It does not. We regret this. — *the editors*
]

#v(0.4em)

#callout(title: "submissions")[
  800 words or fewer. No pitches. Send it done. Plaintext. — *void-dispatch #sym.at proton.me*
]

#zrule(label: "end")

#align(center)[
  #text(font: fonts.body, size: 8pt, fill: colors.mid)[
    VOID DISPATCH — FREE — PRINT IT — LEAVE IT SOMEWHERE\
    ISSUE 04: WINTER 2025
  ]
]

#inside-back-cover(
  img:  rect(width: 100%, height: 100%, fill: gradient.linear(black, rgb("#00050d"), angle: 220deg)),
  body: [
    *Next issue:* infrastructure that fights back.
    Submissions open. 800 words or fewer.
    No pitches. Send it done.

    void-dispatch #sym.at proton.me
  ],
)

#back-cover(
  title:   "VOID DISPATCH",
  issue:   "03",
  date:    "AUTUMN 2025",
  tagline: "free — print it — leave it somewhere",
  img:     rect(width: 100%, height: 100%, fill: gradient.linear(rgb("#0a0000"), black, angle: 340deg)),
  accent:  rgb("#ff2d00"),
)
