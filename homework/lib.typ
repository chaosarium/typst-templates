#let total_pages = locate(loc=>counter(page).final(loc).at(0))

#let homework_layout(doc, 
  title,
  font: "auto",
  font_size: 11pt,
  leading: .6em,
  default_lang: "sml",
) = {
  set page(
    margin: (
      y: 1in,
      x: 1in,
    ),
    paper: "us-letter",
    header: [
      #grid(columns: (2fr, 1fr), gutter: 1pt,
        align(left)[#title],
        align(right)[Page #counter(page).display() of #total_pages]
      )
      #v(-8pt)
      #line(length: 100%, stroke: 0.5pt)
    ],
    numbering: none,
  )
  set text(
    size: font_size,
    font: font
  )
  set par(
    leading: leading
  )
  set raw(lang: default_lang)
  show heading.where(level: 2): set text(size: 12pt, weight: 600)
  show heading.where(level: 1): set text(size: 16pt, weight: 800)
  show footnote.entry: set text(size: 10pt)
  show raw.where(block: false): it => box(
    fill: luma(245),
    outset: (y: 3pt),
    inset: (x: 2pt),
    stroke: 0.2pt + luma(150),
    radius: 1pt,
    it
  )
  show raw.where(block: true): block.with(
    fill: luma(245),
    inset: 8pt,
    stroke: 0.2pt + luma(150),
    width: 100%,
    radius: 1pt,
  )
  doc
}
