// VOID DISPATCH #03 — HTML/web version
// compile: typst compile --font-path fonts --features html --format html demo-html.typ demo.html

#import "lib.typ": *

#let e(tag, class: none, body) = html.elem(
  tag,
  attrs: if class != none { (class: class) } else { (:) },
  body,
)

// ── HELPERS ──────────────────────────────────────────────────────────────────

#let h-zrule(label: none) = e("div", class: "zrule")[
  #e("div", class: "zrule-thick")[]
  #e("span", class: "zrule-dot")[]
  #if label != none { e("span", class: "zrule-label")[#upper(label)] }
  #e("div", class: "zrule-thin")[]
]

#let h-toc-entry(title, num) = e("div", class: "toc-entry")[
  #e("span", class: "toc-entry-num")[#num]
  #e("span", class: "toc-entry-title")[#upper(title)]
]

#let h-byline(name) = e("div", class: "byline")[#upper(name)]

#let h-pull-quote(attribution: "", body) = e("div", class: "pull-quote")[
  #e("blockquote", class: none, body)
  #e("cite", class: none)[#upper(attribution)]
]

#let h-callout(title: "", body) = e("div", class: "callout")[
  #e("div", class: "callout-title")[#upper(title)]
  #e("div", class: "callout-body", body)
]

#let h-manifesto(body) = e("div", class: "manifesto", body)

#let h-article-image(src, caption: none) = e("figure", class: "article-image")[
  #html.elem("img", attrs: (src: src, style: "max-height: 28em; max-width: 100%; object-fit: contain;"))
  #if caption != none { e("figcaption", class: none)[#caption] }
]

#let h-article(title, body) = e("article", class: none)[
  #e("div", class: "article-label")[ARTICLE]
  #e("h1", class: none)[#upper(title)]
  #e("div", class: "article-rule")[
    #e("div", class: "article-rule-a")[]
    #e("div", class: "article-rule-b")[]
  ]
  #body
]

// ── DOCUMENT ─────────────────────────────────────────────────────────────────

#html.elem("style")[#read("demo.css")]

#e("div", class: "masthead")[
  #e("div", class: "masthead-issue")[VOID DISPATCH — ISSUE 03 — AUTUMN 2025]
  #e("div", class: "masthead-title")[VOID DISPATCH]
  #e("div", class: "masthead-rule")[
    #e("div", class: "masthead-rule-thick")[]
    #e("span", class: "masthead-rule-dot")[]
    #e("div", class: "masthead-rule-thin")[]
  ]
]

#e("div", class: "toc")[
  #h-toc-entry("Cities That Never Sleep", 1)
  #h-toc-entry("Three Ways to Disappear", 2)
  #h-toc-entry("The Last Payphone", 3)
  #h-toc-entry("Small Grid Theory", 4)
  #h-toc-entry("The Maintenance Workers", 5)
  #h-toc-entry("The Signal Layer", 6)
]

#h-zrule()

// ── ARTICLE 1 ────────────────────────────────────────────────────────────────

#h-article("Cities That Never Sleep")[
  #h-byline("Dana Ferris")
  #h-article-image("rifle.png", caption: "fulfillment center, outer ring road")

  There is a version of the 24-hour city that is glamorous. Jazz clubs. Diners. The last bus home and someone interesting on it. That version existed, briefly, in a handful of places, and it was good.

  The version we have now is different. It is *logistics*. It is a warehouse that cannot go dark because the sortation algorithm runs continuously and the humans inside it are cheaper than the reconfiguration cost of stopping.

  The romantic 24-hour city was organized around _desire_. Someone wanted to be there at 3am. The logistical 24-hour city is organized around throughput. No one wants to be there. They are there because the model requires it.

  #h-pull-quote(attribution: "outside a fulfillment center, 3:14am")[
    The lights are always on here. That used to mean something.
  ]

  This is the distinction that city planners, when they invoke "vibrancy," consistently fail to make. Vibrancy is not a property of illuminated windows. It is a property of people choosing to be somewhere.

  We built infrastructure for the night and called it nightlife. We built coverage for every hour and called it community. We lit every corner and called it safety. None of these substitutions are neutral.

  #h-manifesto[
    A city that cannot sleep is not awake. It is running a process.
  ]
]

// ── ARTICLE 2 ────────────────────────────────────────────────────────────────

#h-article("Three Ways to Disappear")[
  #h-byline("M. Okafor")
  #h-article-image("soldiers.png", caption: "analog, unconnected")

  This is not a paranoia piece. This is a practice piece. Paranoia assumes a specific adversary. Practice assumes a general condition and responds proportionally.

  *Method one: go analog for the boring stuff.* Most surveillance is passive and opportunistic. It collects whatever flows through the pipes. A notebook does not have a privacy policy. A pocket calendar does not sync to a data broker. Shopping lists, personal notes, appointments with people you trust — none of these need a network.

  *Method two: reduce identity surface area.* You have more accounts than you need. Some are attached to your real name, phone number, a payment method, a device fingerprint. The reduction is not deactivation. It is to stop creating new ones. Every new account is a new exposure surface.

  *Method three: make boring choices visible.* Notice when you are making a choice. Not every choice requires a different decision. But many defaults were set by someone whose interests are not yours. Default on: location sharing, analytics, cross-app tracking, personalized ads. Reversing these — not in every case, just deliberately — changes what flows through the pipes.

  #h-callout(title: "the actual threat model")[
    You are probably not being targeted specifically. You are in a database being queried by systems with no opinion about you as a person. The goal is not to escape the database. The goal is to make the query less useful.
  ]
]

// ── ARTICLE 3 ────────────────────────────────────────────────────────────────

#h-article("The Last Payphone")[
  #h-byline("T. Nakamura")
  #h-article-image("rifle.png", caption: "delancey and essex, 2019")

  _A photo essay without photos, because we lost the memory card._

  The payphone on Delancey and Essex was removed in 2019. There is a LinkNYC kiosk there now. The kiosk offers free calls, fast Wi-Fi, and a screen that displays advertisements. It also collects device identifiers from passing phones.

  The payphone offered free emergency calls and required a quarter for everything else. It collected nothing. It remembered nothing. When you hung up, the conversation was over.

  This was not a bug. This was a feature that nobody wrote down because nobody thought it would need to be defended.

  #h-pull-quote(attribution: "a person who remembered the quarter")[
    You could call anyone and they couldn't call you back unless they already knew where you were.
  ]

  The last payphone in New York City was removed from a hotel lobby in 2022. It is now in a museum. Which is the correct place for things that society has decided it no longer needs, and which is also the correct place to go to feel the specific grief of infrastructure loss.

  The kiosk is faster. The kiosk is free. The kiosk is always available. The kiosk knows your phone was near it at 11:47am on a Tuesday in March.

  The payphone knew nothing. That was the whole point.
]

// ── ARTICLE 4 ────────────────────────────────────────────────────────────────

#h-article("Small Grid Theory")[
  #h-byline("S. Reyes")
  #h-article-image("handgun.png", caption: "small block grid, central district")

  The most livable neighborhoods in most cities share one physical characteristic that urban planners consistently undervalue: *small blocks*. Not "walkable" in the sense of having sidewalks. Not "mixed-use" in the sense of having a Starbucks on the ground floor of a condo tower. Small blocks. Short distances between intersections. Many choices per square mile.

  The reason small blocks win is not aesthetic. It is combinatorial. A grid of small blocks offers exponentially more route choices than a grid of large blocks covering the same area. More route choices means more foot traffic distributed across more paths means more storefronts viable means more activity.

  Large blocks produce dead zones. Not because they are ugly — though they often are — but because a single failed anchor tenant takes an entire frontage offline. On a small block, one failed storefront is one failed storefront. On a superblock, it is four hundred feet of blank wall.

  #h-manifesto[
    Density is not the variable. Granularity is the variable.
  ]

  You cannot retrofit walkability onto a large-block grid by adding mixed-use zoning. You can add a coffee shop on the ground floor of a 700-foot-frontage building and it will feel like a coffee shop in an airport. Because it is.

  The blocks have to be small first. Everything else follows from the blocks. Jane Jacobs said this in 1961. We have spent sixty years building the opposite.
]

// ── ARTICLE 5 ────────────────────────────────────────────────────────────────

#h-article("The Maintenance Workers")[
  #h-byline("P. Voss")
  #h-article-image("rifle.png", caption: "substation crew, 2:30am")

  Every city has two kinds of workers. The ones you see and the ones who make it possible for you to see them. The street-level economy — cafés, shops, deliveries — depends on a substrate that is mostly invisible: the people who fix the pipes, patch the road, swap the transformer, re-hang the signal.

  They work at 2am because the work cannot happen when the city is using itself. The road has to be empty. The water main has to be isolated. The substation has to be de-energized. The shift starts at midnight and ends before anyone notices it happened.

  This is by design. The ideal maintenance event is one that nobody knows occurred. The pipe doesn't burst, so there's no story. The signal doesn't fail, so there's no backup. The transformer holds, so the hospital stays on.

  #h-callout(title: "invisibility as success metric")[
    The KPI for infrastructure maintenance is the absence of events. Nothing happened. That is the goal. That is how you know it worked.
  ]

  We have built an economy around visibility — metrics, dashboards, likes, impressions. And then we have built the physical world on top of people whose best outcome is that you never think about them at all.
]

// ── ARTICLE 6 ────────────────────────────────────────────────────────────────

#h-article("The Signal Layer")[
  #h-byline("P. Voss")
  #h-article-image("handgun.png", caption: "mesh node, lamp post array")

  Every city runs on a layer you cannot see. Not the pipes, not the wires — those are findable, mappable, orange-flagged before you dig. The signal layer is different. It is the mesh of transmissions that tells the traffic light what the car did three blocks away, that tells the transit authority the bus is running four minutes late, that tells the logistics platform the driver has paused.

  The signal layer is where the city becomes legible to itself. Without it, the buses are just buses. With it, the buses are a dataset. The streets are a dataset. The pedestrians are a dataset. The city reads itself continuously and the reading changes what it does.

  Most people do not know the signal layer exists. They know the wifi. They know the cell signal. They do not know the mesh, the LIDAR, the Bluetooth sniffers embedded in lamp posts, the license plate readers every four blocks, the acoustic monitors that can tell a gunshot from a car backfire with ninety-three percent accuracy.

  #h-callout(title: "what the signal layer knows")[
    Where you were. How fast you moved. What device you carried. Whether you stopped. For how long. Whether you stopped at that spot before.
  ]

  The signal layer does not forget. The buses forget. The people forget. The signal layer keeps a log.
]

// ── LETTERS ──────────────────────────────────────────────────────────────────

#h-zrule(label: "letters")

#e("div", class: "letters")[
  #h-callout(title: "on the bus piece (issue 02)")[
    You said the bus is slow because of choices, not physics. I've been thinking about this for three weeks. You're right and I hate it. — *J.W., Chicago*
  ]
  #h-callout(title: "correction")[
    The Houston light rail does not go to the airport. We stated that it did. It does not. We regret this. — *the editors*
  ]
  #h-callout(title: "submissions")[
    800 words or fewer. No pitches. Send it done. Plaintext. — void-dispatch\@proton.me
  ]
]

#h-zrule(label: "end")

#e("div", class: "footer")[
  VOID DISPATCH — FREE — PRINT IT — LEAVE IT SOMEWHERE\
  ISSUE 04: WINTER 2025
]
