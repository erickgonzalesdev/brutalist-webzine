#import "lib.typ": *

#import "@preview/meander:0.4.3"

#let png1 = image("47-472115_counter-strike-png-transparent-png.png", width: 100%, fit: "contain")
#let png2 = image(format: "jpg", "cHJpdmF0ZS9sci9pbWFnZXMvd2Vic2l0ZS8yMDI0LTAzL3Jhd3BpeGVsX29mZmljZV8yMl9waG90b19vZl93ZWFwb25faXNvbGF0ZWRfb25fY2xlYXJfd2hpdGVfYmFja19mMDYwNTg1Ni0zNGU1LTQ1OWQtYjNkOS1hOWNkMjQ0ZjE1ODBfMS5wbmc.png", width: 100%, fit: "contain")
#let png3 = image(format: "jpg", "cHJpdmF0ZS9sci9pbWFnZXMvd2Vic2l0ZS8yMDIzLTExL3Jhd3BpeGVsX29mZmljZV8yNF9waG90b19vZl90b3lfYmxhY2tfaGFuZGd1bl9pc29sYXRlZF93aGl0ZV9iYV9hZmQ5MmZhNC1lZTM5LTQyZGItYjM4NC1lM2YzOWU0MTUxNDMucG5n.png", width: 100%, fit: "contain")

// Silhouette contours for each PNG obstacle
// (x, y) in [0,1]×[0,1], top-left origin; true = obstacle (opaque pixel region)
#let contour-soldiers = meander.contour.grid(
  div: 32,
  (x, y) => {
    // Gun barrel: thin diagonal from top-left to top-right
    let barrel = y < 0.26 and y > (0.05 + x * 0.14) and x > 0.12
    // Standing figure (right): fills right 65%, full height, tapers at very top
    let standing = x > 0.33 and (y > 0.08 or x < 0.82)
    // Crouching figure (left): fills left 75%, lower 65%
    let crouching = x < 0.78 and y > 0.35
    // Clear top-left triangle where there's nothing
    let clear-tl = x < 0.33 and y < 0.35 and not barrel
    (barrel or standing or crouching) and not clear-tl
  }
)

#let contour-rifle = meander.contour.grid(
  div: 32,
  (x, y) => {
    // Rifle diagonal: bottom-left to top-right
    // Centre line approx y = 0.95 - x*0.90
    let centre = 0.95 - x * 0.90
    let width  = 0.18 + x * 0.06
    let in-body = calc.abs(y - centre) < width
    // Magazine box: lower-left of centre
    let mag = x > 0.08 and x < 0.38 and y > 0.55 and y < 0.88
    // Stock: right portion, lower area
    let stock = x > 0.70 and y > 0.42 and y < 0.72
    // Clear true corners
    let clear-tl = x < 0.06 and y < 0.20
    let clear-br = x > 0.94 and y > 0.80
    (in-body or mag or stock) and not clear-tl and not clear-br
  }
)

#let contour-handgun = meander.contour.grid(
  div: 32,
  (x, y) => {
    // Slide + barrel: horizontal band across most of image
    let slide  = y > 0.08 and y < 0.58 and x > 0.04 and x < 0.88
    // Grip: lower-right block
    let grip   = x > 0.46 and x < 0.84 and y > 0.42 and y < 0.96
    // Clear empty corners
    let clear-tl = x < 0.10 and y < 0.18
    let clear-bl = x < 0.30 and y > 0.70
    let clear-tr = x > 0.86 and y < 0.25
    let clear-br = x > 0.86 and y > 0.80
    (slide or grip) and not clear-tl and not clear-bl and not clear-tr and not clear-br
  }
)

#cover(
  title:  "VOID DISPATCH",
  issue:  "03",
  date:   "AUTUMN 2025",
  img:    image("image1.jpg", width: 100%, height: 100%, fit: "cover"),
  accent: white,
)

#inside-cover(
  img:  image("image2.jpg", width: 100%, height: 100%, fit: "cover"),
  body: [
    *Void Dispatch* is a zine about cities, infrastructure, and the systems we live inside.
    Free to read. Free to print. Free to leave somewhere.

    Contributing writers: Dana Ferris, M. Okafor,\ T. Nakamura, S. Reyes, P. Voss.

    Printed on whatever you have.\
    void-dispatch #sym.at proton.me
  ],
)

#show: webzine.with(
  title:   "VOID DISPATCH",
  issue:   "03",
  date:    "AUTUMN 2025",
  cols:          1,
  accent:        white,
  format:        "letter",
  margins:       0.9in,
  dark:          true,
  show-masthead: true,
)

#toc-entry("CITIES THAT NEVER SLEEP", 1)
#toc-entry("THREE WAYS TO DISAPPEAR", 2)
#toc-entry("THE LAST PAYPHONE", 3)
#toc-entry("SMALL GRID THEORY", 4)
#toc-entry("THE MAINTENANCE WORKERS", 5)
#toc-entry("THE SIGNAL LAYER", 6)

#zrule()

// ── ARTICLE 1 ─────────────────────────────────────────────────────────────────
#article-page(
  title:  "Cities That Never Sleep",
  author: "Dana Ferris",
  issue:  "03",
  date:   "Autumn 2025",
  images: (
    image("image3.jpg", width: 100%, height: 100%, fit: "cover"),
    image("image1.jpg", width: 100%, height: 100%, fit: "cover"),
    image("image4.jpg", width: 100%, height: 100%, fit: "cover"),
    image("image2.jpg", width: 100%, height: 100%, fit: "cover"),
  ),
  layout: "main-left",
)

= CITIES THAT NEVER SLEEP

#byline("DANA FERRIS")

#wrap-image(
  png2,
  boundary: contour-rifle,
  width:   52%,
  align:   top + right,
  gap:     14pt,
  caption: "fulfillment center, outer ring road",
)[There is a version of the 24-hour city that is glamorous. Jazz clubs. Diners. The last bus home and someone interesting on it. That version existed, briefly, in a handful of places, and it was good.

The version we have now is different. It is *logistics*. It is a warehouse that cannot go dark because the sortation algorithm runs continuously and the humans inside it are cheaper than the reconfiguration cost of stopping.

The romantic 24-hour city was organized around _desire_. Someone wanted to be there at 3am. The logistical 24-hour city is organized around throughput. No one wants to be there. They are there because the model requires it.]

#pull-quote(attribution: "outside a fulfillment center, 3:14am")[
  The lights are always on here. That used to mean something.
]

#wrap-image(
  png3,
  boundary: contour-handgun,
  width:   44%,
  align:   top + left,
  gap:     12pt,
)[This is the distinction that city planners, when they invoke "vibrancy," consistently fail to make. Vibrancy is not a property of illuminated windows. It is a property of people choosing to be somewhere.

We built infrastructure for the night and called it nightlife. We built coverage for every hour and called it community. We lit every corner and called it safety. None of these substitutions are neutral.]

#manifesto[
  A city that cannot sleep is not awake. It is running a process.
]

// ── ARTICLE 2 ─────────────────────────────────────────────────────────────────
#article-page(
  title:  "Three Ways To Disappear",
  author: "M. Okafor",
  issue:  "03",
  date:   "Autumn 2025",
  images: (
    image("image2.jpg", width: 100%, height: 100%, fit: "cover"),
    image("image4.jpg", width: 100%, height: 100%, fit: "cover"),
    image("image1.jpg", width: 100%, height: 100%, fit: "cover"),
    image("image3.jpg", width: 100%, height: 100%, fit: "cover"),
  ),
  layout: "dupe-shift",
)

= THREE WAYS TO DISAPPEAR

#byline("M. OKAFOR")

#wrap-image(
  png1,
  boundary: contour-soldiers,
  width:   48%,
  align:   top + left,
  gap:     13pt,
  caption: "analog, unconnected",
)[This is not a paranoia piece. This is a practice piece. Paranoia assumes a specific adversary. Practice assumes a general condition and responds proportionally.

*Method one: go analog for the boring stuff.* Most surveillance is passive and opportunistic. It collects whatever flows through the pipes. A notebook does not have a privacy policy. A pocket calendar does not sync to a data broker. Shopping lists, personal notes, appointments with people you trust — none of these need a network.]

#wrap-image(
  png3,
  boundary: contour-handgun,
  width:   42%,
  align:   top + right,
  gap:     12pt,
)[*Method two: reduce identity surface area.* You have more accounts than you need. Some are attached to your real name, phone number, a payment method, a device fingerprint. The reduction is not deactivation. It is to stop creating new ones. Every new account is a new exposure surface.

*Method three: make boring choices visible.* Notice when you are making a choice. Not every choice requires a different decision. But many defaults were set by someone whose interests are not yours. Default on: location sharing, analytics, cross-app tracking, personalized ads. Reversing these — not in every case, just deliberately — changes what flows through the pipes.]

#callout(title: "the actual threat model")[
  You are probably not being targeted specifically. You are in a database being queried by systems with no opinion about you as a person. The goal is not to escape the database. The goal is to make the query less useful.
]

// ── ARTICLE 3 ─────────────────────────────────────────────────────────────────
#article-page(
  title:     "The Last Payphone",
  author:    "T. Nakamura",
  issue:     "03",
  date:      "Autumn 2025",
  images: (
    image("image3.jpg", width: 100%, height: 100%, fit: "cover"),
    image("image1.jpg", width: 100%, height: 100%, fit: "cover"),
    image("image4.jpg", width: 100%, height: 100%, fit: "cover"),
    image("image2.jpg", width: 100%, height: 100%, fit: "cover"),
  ),
  layout:    "hsplit",
  title-pos: "bottom-right",
)

= THE LAST PAYPHONE

#byline("T. NAKAMURA")

#wrap-image(
  png2,
  boundary: contour-rifle,
  width:   55%,
  align:   top + right,
  gap:     14pt,
  caption: "delancey and essex, 2019",
)[_A photo essay without photos, because we lost the memory card._

The payphone on Delancey and Essex was removed in 2019. There is a LinkNYC kiosk there now. The kiosk offers free calls, fast Wi-Fi, and a screen that displays advertisements. It also collects device identifiers from passing phones.

The payphone offered free emergency calls and required a quarter for everything else. It collected nothing. It remembered nothing. When you hung up, the conversation was over.

This was not a bug. This was a feature that nobody wrote down because nobody thought it would need to be defended.]

#pull-quote(attribution: "a person who remembered the quarter")[
  You could call anyone and they couldn't call you back unless they already knew where you were.
]

#wrap-image(
  png1,
  boundary: contour-soldiers,
  width:   40%,
  align:   top + left,
  gap:     12pt,
)[The last payphone in New York City was removed from a hotel lobby in 2022. It is now in a museum. Which is the correct place for things that society has decided it no longer needs, and which is also the correct place to go to feel the specific grief of infrastructure loss.

The kiosk is faster. The kiosk is free. The kiosk is always available. The kiosk knows your phone was near it at 11:47am on a Tuesday in March.

The payphone knew nothing. That was the whole point.]

// ── ARTICLE 4 ─────────────────────────────────────────────────────────────────
#article-page(
  title:  "Small Grid Theory",
  author: "S. Reyes",
  issue:  "03",
  date:   "Autumn 2025",
  images: (
    image("image4.jpg", width: 100%, height: 100%, fit: "cover"),
    image("image1.jpg", width: 100%, height: 100%, fit: "cover"),
    image("image2.jpg", width: 100%, height: 100%, fit: "cover"),
    image("image3.jpg", width: 100%, height: 100%, fit: "cover"),
  ),
  layout: "corner-pull",
)

= SMALL GRID THEORY

#byline("S. REYES")

#wrap-image(
  png3,
  boundary: contour-handgun,
  width:   50%,
  align:   top + left,
  gap:     13pt,
  caption: "small block grid, central district",
)[The most livable neighborhoods in most cities share one physical characteristic that urban planners consistently undervalue: *small blocks*. Not "walkable" in the sense of having sidewalks. Not "mixed-use" in the sense of having a Starbucks on the ground floor of a condo tower. Small blocks. Short distances between intersections. Many choices per square mile.

The reason small blocks win is not aesthetic. It is combinatorial. A grid of small blocks offers exponentially more route choices than a grid of large blocks covering the same area. More route choices means more foot traffic distributed across more paths means more storefronts viable means more activity.]

#wrap-image(
  png2,
  boundary: contour-rifle,
  width:   46%,
  align:   top + right,
  gap:     12pt,
)[Large blocks produce dead zones. Not because they are ugly — though they often are — but because a single failed anchor tenant takes an entire frontage offline. On a small block, one failed storefront is one failed storefront. On a superblock, it is four hundred feet of blank wall.]

#manifesto[
  Density is not the variable. Granularity is the variable.
]

#wrap-image(
  png1,
  boundary: contour-soldiers,
  width:   44%,
  align:   top + left,
  gap:     12pt,
)[You cannot retrofit walkability onto a large-block grid by adding mixed-use zoning. You can add a coffee shop on the ground floor of a 700-foot-frontage building and it will feel like a coffee shop in an airport. Because it is.

The blocks have to be small first. Everything else follows from the blocks. Jane Jacobs said this in 1961. We have spent sixty years building the opposite.]

// ── ARTICLE 5 ─────────────────────────────────────────────────────────────────
#article-page(
  title:     "The Maintenance Workers",
  author:    "P. Voss",
  issue:     "03",
  date:      "Autumn 2025",
  images: (
    image("image2.jpg", width: 100%, height: 100%, fit: "cover"),
    image("image4.jpg", width: 100%, height: 100%, fit: "cover"),
  ),
  layout:    "v-stack",
  title-pos: "bottom-right",
  stack: (
    images: (
      image("image1.jpg", width: 100%, height: 100%, fit: "cover"),
      image("image3.jpg", width: 100%, height: 100%, fit: "cover"),
    ),
    anchor: bottom + left,
    width:  36%,
    height: 28%,
    offset: 12pt,
  ),
)

= THE MAINTENANCE WORKERS

#byline("P. VOSS")

#wrap-image(
  png2,
  boundary: contour-rifle,
  width:   52%,
  align:   top + right,
  gap:     14pt,
  caption: "substation crew, 2:30am",
)[Every city has two kinds of workers. The ones you see and the ones who make it possible for you to see them. The street-level economy — cafés, shops, deliveries — depends on a substrate that is mostly invisible: the people who fix the pipes, patch the road, swap the transformer, re-hang the signal.

They work at 2am because the work cannot happen when the city is using itself. The road has to be empty. The water main has to be isolated. The substation has to be de-energized. The shift starts at midnight and ends before anyone notices it happened.]

#wrap-image(
  png3,
  boundary: contour-handgun,
  width:   42%,
  align:   top + left,
  gap:     12pt,
)[This is by design. The ideal maintenance event is one that nobody knows occurred. The pipe doesn't burst, so there's no story. The signal doesn't fail, so there's no backup. The transformer holds, so the hospital stays on.]

#callout(title: "invisibility as success metric")[
  The KPI for infrastructure maintenance is the absence of events. Nothing happened. That is the goal. That is how you know it worked.
]

#wrap-image(
  png1,
  boundary: contour-soldiers,
  width:   48%,
  align:   top + right,
  gap:     12pt,
)[We have built an economy around visibility — metrics, dashboards, likes, impressions. And then we have built the physical world on top of people whose best outcome is that you never think about them at all.]

// ── ARTICLE 6 ─────────────────────────────────────────────────────────────────
#article-page(
  title:  "The Signal Layer",
  author: "P. Voss",
  issue:  "03",
  date:   "Autumn 2025",
  images: (
    image("image1.jpg", width: 100%, height: 100%, fit: "cover"),
    image("image3.jpg", width: 100%, height: 100%, fit: "cover"),
    image("image4.jpg", width: 100%, height: 100%, fit: "cover"),
    image("image2.jpg", width: 100%, height: 100%, fit: "cover"),
  ),
  layout: "dupe-triple",
)

= THE SIGNAL LAYER

#byline("P. VOSS")

#wrap-image(
  png3,
  boundary: contour-handgun,
  width:   48%,
  align:   top + left,
  gap:     13pt,
  caption: "mesh node, lamp post array",
)[Every city runs on a layer you cannot see. Not the pipes, not the wires — those are findable, mappable, orange-flagged before you dig. The signal layer is different. It is the mesh of transmissions that tells the traffic light what the car did three blocks away, that tells the transit authority the bus is running four minutes late, that tells the logistics platform the driver has paused.

The signal layer is where the city becomes legible to itself. Without it, the buses are just buses. With it, the buses are a dataset. The streets are a dataset. The pedestrians are a dataset. The city reads itself continuously and the reading changes what it does.]

#wrap-image(
  png2,
  boundary: contour-rifle,
  width:   44%,
  align:   top + right,
  gap:     12pt,
)[Most people do not know the signal layer exists. They know the wifi. They know the cell signal. They do not know the mesh, the LIDAR, the Bluetooth sniffers embedded in lamp posts, the license plate readers every four blocks, the acoustic monitors that can tell a gunshot from a car backfire with ninety-three percent accuracy.]

#callout(title: "what the signal layer knows")[
  Where you were. How fast you moved. What device you carried. Whether you stopped. For how long. Whether you stopped at that spot before.
]

#wrap-image(
  png1,
  boundary: contour-soldiers,
  width:   42%,
  align:   top + left,
  gap:     12pt,
)[The signal layer does not forget. The buses forget. The people forget. The signal layer keeps a log.]

// ── LAYOUT SHOWCASE ───────────────────────────────────────────────────────────
#article-page(
  title:  "Grid",
  issue:  "03",
  date:   "Autumn 2025",
  images: (
    image("image1.jpg", width: 100%, height: 100%, fit: "cover"),
    image("image2.jpg", width: 100%, height: 100%, fit: "cover"),
    image("image3.jpg", width: 100%, height: 100%, fit: "cover"),
    image("image4.jpg", width: 100%, height: 100%, fit: "cover"),
  ),
  layout: "grid",
  gap:    0pt,
)

#article-page(
  title:  "Fibonacci",
  issue:  "03",
  date:   "Autumn 2025",
  images: (
    image("image1.jpg", width: 100%, height: 100%, fit: "cover"),
    image("image2.jpg", width: 100%, height: 100%, fit: "cover"),
    image("image3.jpg", width: 100%, height: 100%, fit: "cover"),
    image("image4.jpg", width: 100%, height: 100%, fit: "cover"),
    image("image1.jpg", width: 100%, height: 100%, fit: "cover"),
  ),
  layout: "fibonacci",
  gap:    0pt,
)

#article-page(
  title:  "H-Split",
  issue:  "03",
  date:   "Autumn 2025",
  images: (
    image("image2.jpg", width: 100%, height: 100%, fit: "cover"),
    image("image4.jpg", width: 100%, height: 100%, fit: "cover"),
    image("image1.jpg", width: 100%, height: 100%, fit: "cover"),
  ),
  layout: "h-split",
  gap:    0pt,
)

#article-page(
  title:  "V-Split",
  issue:  "03",
  date:   "Autumn 2025",
  images: (
    image("image3.jpg", width: 100%, height: 100%, fit: "cover"),
    image("image1.jpg", width: 100%, height: 100%, fit: "cover"),
    image("image4.jpg", width: 100%, height: 100%, fit: "cover"),
  ),
  layout: "v-split",
  gap:    0pt,
)

#article-page(
  title:     "NH-Stack",
  issue:     "03",
  date:      "Autumn 2025",
  images: (
    image("image4.jpg", width: 100%, height: 100%, fit: "cover"),
    image("image2.jpg", width: 100%, height: 100%, fit: "cover"),
    image("image3.jpg", width: 100%, height: 100%, fit: "cover"),
    image("image1.jpg", width: 100%, height: 100%, fit: "cover"),
  ),
  layout:       "nh-stack",
  master-count: 2,
  gap:          0pt,
  title-pos:    "bottom-right",
)

#article-page(
  title:     "NV-Stack",
  issue:     "03",
  date:      "Autumn 2025",
  images: (
    image("image1.jpg", width: 100%, height: 100%, fit: "cover"),
    image("image3.jpg", width: 100%, height: 100%, fit: "cover"),
    image("image2.jpg", width: 100%, height: 100%, fit: "cover"),
    image("image4.jpg", width: 100%, height: 100%, fit: "cover"),
  ),
  layout:       "nv-stack",
  master-count: 2,
  gap:          0pt,
)

#article-page(
  title:  "Mirror-H",
  issue:  "03",
  date:   "Autumn 2025",
  images: (
    image("image2.jpg", width: 100%, height: 100%, fit: "cover"),
    image("image4.jpg", width: 100%, height: 100%, fit: "cover"),
    image("image3.jpg", width: 100%, height: 100%, fit: "cover"),
    image("image1.jpg", width: 100%, height: 100%, fit: "cover"),
  ),
  layout: "mirror-h",
  gap:    0pt,
)

#article-page(
  title:  "Mirror-V",
  issue:  "03",
  date:   "Autumn 2025",
  images: (
    image("image3.jpg", width: 100%, height: 100%, fit: "cover"),
    image("image1.jpg", width: 100%, height: 100%, fit: "cover"),
    image("image2.jpg", width: 100%, height: 100%, fit: "cover"),
    image("image4.jpg", width: 100%, height: 100%, fit: "cover"),
  ),
  layout:    "mirror-v",
  gap:       0pt,
  title-pos: "bottom-right",
)

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
  img:  image("image2.jpg", width: 100%, height: 100%, fit: "cover"),
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
  img:     image("image3.jpg", width: 100%, height: 100%, fit: "cover"),
  accent:  white,
)
