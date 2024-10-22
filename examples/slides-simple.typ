#import "../slides-simple/lib.typ": *

#show: slides.with(
  title: [Some Random Presentation],
  subtitle: [Making slides in Typst],
  date: [21 October 2024],
  authors: [list of authors],

  ratio: 16/9,
  layout: "medium",
  title-color: rgb("#4a1c8a"),

  footer: true,
  slides_counter: true,
  toc: true,
  // code-styling: true,

  font_size: 11pt,
  font: "Libertine"
)

= Style Testing

== Text

#lorem(20)#footnote[hello this is footnote]

Something *bold* and _italic_ and `raw text`. `raw`  are good

- List
  - With nesting
    - And more nesting
      - And more?

/ Term: #[
  aristenairsntiarnstei \
  ieanrst \
  iaenrst
]

#lorem(100)

/ Definition: aristenairsnt

== More text

```sml
fun fact 0 = 1
  | fact n = n * fact (n - 1)
```

Some code definitely worked...

Some math shoudl also work then

$
  E = m c ^2
$

== Table

#table(
  columns: 4,
  [], [Exam 1], [Exam 2], [Exam 3],

  [John], [], [a], [],
  [Mary], [], [a], [a],
  [Robert], [b], [a], [b],
)

= Something

== Now this is a very long title and I don't know what the template will do if it wants to handle it

hahahahaha

== Hi
Something

= Something

hello

== Hi

Something

= bibliography

== Citations should work?

Hmmm @goldbergComprehensive.

== Bib

#bibliography("pubs.bib")
