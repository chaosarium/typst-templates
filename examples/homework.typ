#import "../homework/lib.typ": *
#import "@preview/curryst:0.3.0": rule, proof-tree

#let layout(doc) = homework_layout(doc, "XX-XXX Assignment X")
#show: layout

= Problem 1

== 1.a

*Lorem ipsum* dolor sit amet, _consectetur_ adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magnam aliquam quaerat.

== 1.b

Random *math* test#footnote[inspired by #link("https://ilorentz.org/beenakker/MO/fonttest.tex")]

$ phi.alt (t) = 1 / sqrt(2 pi) integral_0^t e^(- x^2 \/ 2) d x $

= Problem 2

== 2.a

Some inference rule

#let layer(top, bottom, name) = align(center)[
  #proof-tree(
    rule(
      name: name,
      bottom,
      top,
    ),
  )
]

#let ctx = $Gamma$
#let ent = $tack.r$
#let e1 = $e_1$
#let t1 = $tau_1$
#let e2 = $e_2$
#let t2 = $tau_2$
#let al = $angle.l$
#let ar = $angle.r$
#let ub = math.underbracket


#layer(
  [$ctx ent e1: t1 quad ctx ent e2: t2$],
  [$ctx ent ub(al e1\, e2 ar, e): t1 times t2$],
  [Meh],
)


== 2.b

This is some code trace for `fact 2`

```sml
fun fact 0 = 1
  | fact n = n * fact (n - 1)
```

#let chunk(thing) = {
  set align(left)
  raw(
    thing.trim(),
    align: right,
  )
}

$
  chunk("fact 2") &=  chunk("2 * (fact (2 - 1))")  #[(definition of `fact`)] \
&= chunk("2 * (fact 1)")  #[(math)] \
&= chunk("2 * (1 * (fact (1 - 1)))") #[(definition of `fact`)] \
&= chunk("2 * (1 * (fact 0))")  #[(math)] \
&= chunk("2 * (1 * 1)") #[(definition of `fact`)] \
&= chunk("2 * 1") #[(math)] \
&= chunk("2") #[(math)] \
$

= Problem 3

== 3.a

#lorem(30)
