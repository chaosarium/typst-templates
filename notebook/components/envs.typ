// Proof environment
#let proof(body) = block(spacing: 11.5pt, {
  emph[Proof.]
  [ ] + body
  h(1fr)
  box(scale(160%, origin: bottom + right, sym.square.stroked))
})

// components
#let blockquote(body) = {
  rect(
    stroke: (left: black + 2pt),
    inset: (x: 8pt, y: 6pt),
    outset: -2pt,
    body,
  )
}

