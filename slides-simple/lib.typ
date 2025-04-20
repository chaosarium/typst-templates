// based on https://github.com/skriptum/Diatypst

#let layouts = (
  "small": ("height": 9cm, "space": 1.4cm),
  "medium": ("height": 10.5cm, "space": 1.6cm),
  "large": ("height": 12cm, "space": 1.8cm),
)

#let slides(
  content,

  title: none,
  subtitle: none,
  date: none,
  authors: (),
  
  layout: "medium",
  ratio: 16/9,
  title-color: blue.darken(50%),
  
  slides_counter: true,
  footer: true,
  toc: true,
  // code-styling: true,

  font_size: 11pt,
  font: "Libertinus Serif",
  leading: 0.65em
) = {

  // Parsing
  if layout not in layouts {
      panic("Unknown layout " + layout)
  }
  let (height, space) = layouts.at(layout)
  let width = ratio * height

  // Colors
  let body-color = title-color.lighten(80%)
  let header-color = title-color.lighten(65%)
  let fill-color = title-color.lighten(50%)

  // Setup
  set document(
    title: title,
  )
  set heading(numbering: "1.1.")
  set page(
    width: width,
    height: height,
    margin: (x: 0.5 * space, top: space, bottom: 0.6 * space),
    
    // Header
    header: [
      #context {  
        let page = here().page()
        let headings = query(selector(heading.where(level: 2)))
        let heading = headings.rev().find(x => x.location().page() <= page)
        if heading != none {
          set align(top)
          set text(1.4em, weight: "bold", fill: title-color)
          v(space / 2)
          block(heading.body +
            if not heading.location().page() == page [
              #{numbering("(i)", page - heading.location().page() + 1)}
            ]
          )
        }
      }

      // Slides Counter
      #if slides_counter == true {
        v(-space/1.5)
        align(right+top)[

          #context {
            let curr_page = here().page()
            let all_h2 = query(selector(heading.where(level: 2)))
            let curr_h2 = all_h2.rev().find(x => x.location().page() <= curr_page)
            let curr_h2_page = curr_h2.location().page()

            let last_h1 = query(selector(heading.where(level: 1))).rev().find(x => x.location().page() <= here().page())
            let next_h1 = query(selector(heading.where(level: 1))).find(x => x.location().page() >= here().page())
            let h2s_before = query(
              selector(heading.where(level: 2)).before(curr_h2.location())
            )
              .filter(x => x.location().page() < curr_h2_page)
              .filter(x => if last_h1 != none {x.location().page() >= last_h1.location().page()} else {true})
              .filter(x => if next_h1 != none {x.location().page() <= next_h1.location().page()} else {true})

            let h2s_after = query(
              selector(heading.where(level: 2)).after(curr_h2.location())
            ).slice(1)
              .filter(x => if last_h1 != none {x.location().page() >= last_h1.location().page()} else {true})
              .filter(x => if next_h1 != none {x.location().page() <= next_h1.location().page()} else {true})

            // Dots before the current slide
            for h in h2s_before {
              [
                #link(h.location())[
                  #box(circle(radius: 0.08cm, stroke: 1pt+fill-color)) 
                ]
              ]
            }   

            link(curr_h2.location())[
              #box(circle(radius: 0.08cm, fill: fill-color, stroke: 1pt+fill-color)) 
            ]

            for h in h2s_after {
              [
                #link(h.location())[
                  #box(circle(radius: 0.08cm, stroke: 1pt+fill-color))
                ]
              ]
            }   

          }

        ]
      }
    ],
    header-ascent: 0%,
    
    // Footer
    footer: [
      #if footer == true {
        
        set text(7pt, fill: fill-color, font: "IBM Plex Sans")
        // box()[#line(length: 50%, stroke: 1pt+fill-color )]
        // box()[#line(length: 50%, stroke: 1pt+body-color)]
        // v(-0.3cm)
        

        grid(
          columns: (1fr, 1fr),
          align: (left,right),
          inset: 0pt,
          [#title],
          // [ #if subtitle != none {
          //     subtitle
          //   } else if authors != none {
          //       authors
          //     } else [#date]
          // ],
          [
            #context counter(page).get().at(0) /
            #context counter(page).final().at(0)
            // .display(
            //   "1/1",
            //   both: true,
            // )
          ]
        )
    } 
    ],
    footer-descent:0.8em,
  )


  // Text
  set text(
    size: font_size,
    font: font
  )
  set par(
    leading: leading
  )
  show footnote.entry: set text(size: 0.9em)
  set footnote.entry(separator: line(stroke: 1pt + fill-color.lighten(40%), length: 20%), indent: 0cm)


  
  // Bib
  set bibliography(
    title: none
  )


  // Section Slides
  show heading.where(level: 1): x => {
    set page(header: none,footer: none, margin: 0cm)
    set align(horizon)
      grid(
        columns: (1fr, 3fr),
        inset: 10pt,
        align: (right,left),
        fill: (title-color, white),
        [#block(height: 100%)],[#text(1.2em, weight: "bold", fill: title-color)[#x]]
      )

  }
  show heading.where(level: 2): pagebreak(weak: true)
  show heading: set text(1.1em, fill: title-color)


  // Title Slide
  if (title == none) {
    panic("A title is required")
  }
  else {
    set page(footer: none, header: none, margin: 0cm)
    block(
      inset: (x:0.5*space, bottom:1em),
      fill: title-color,
      width: 100%,
      height: 60%,
      align(bottom)[#text(2.5em, fill: white, title, weight: 900)]
    )
    block(
      height: 30%,
      width: 100%,
      inset: (x:0.5*space,top: 0em, bottom: 1em),
      if subtitle != none {[
        #text(1.4em, fill: title-color, subtitle, weight: 800)
      ]} + 
      if subtitle != none and date != none { 
        text(1.4em)[ \ ] 
      } +
      if date != none {
        text(1.1em, date)
      } +
      align(left+bottom, authors)
    )
  }



  // Term
  show terms.item: it => {
    // set block(width: 100%, inset: 5pt)
    stack(
      block(
        fill: header-color.lighten(40%), 
        radius: (top: 0.1em, bottom: 0cm), 
        strong(it.term),
        
        width: 100%,
        inset: 0.6em,
      ),
      block(
        fill: body-color.lighten(40%), 
        radius: (top: 0cm, bottom: 0.1em), 
        it.description,
        width: 100%,
        inset: 0.6em,
      ),
    )
  }


  // Code
  show raw.where(block: false): it => {
    set text(font: "Hack")
    box(
      fill: body-color.lighten(70%), 
      outset: (y: 0.3em),
      inset: (x: 0.2em),
      stroke: 0.05em + body-color.lighten(30%), 
      radius: 0.2em,
      it
    )
  }

  show raw.where(block: true): it => { 
    set text(font: "Hack")
    block(
      fill: body-color.lighten(70%), 
      inset: 0.6em,
      stroke: 0.05em + body-color.lighten(30%), 
      radius: 0.2em,
      width: 100%,
      it
    )
  }


  // List
  show list: set list(marker: (
    text(fill: title-color)[•],
    text(fill: title-color)[‣],
    text(fill: title-color)[-],
  ))


  // Table styling
  show table: set table(
    stroke: (x, y) => (
      x: none,
      bottom: 0.8pt+black,
      top: if y == 0 {0.8pt+black} else if y==1 {0.4pt+black} else { 0pt },
    )
  )
  show table.cell.where(y: 0): set text(
    style: "normal", weight: "bold") // for first / header row
  set table.hline(stroke: 0.4pt+black)
  set table.vline(stroke: 0.4pt)


  // Outline
  set outline(
    // target: heading.where(level: 1),
    indent: auto,
  )
  set outline.entry(
    // target: heading.where(level: 1),
    fill: line(length: 100%, stroke: (thickness: 1pt, dash: "dotted", paint: header-color)),
  )
  show outline: set heading(level: 2)
  if (toc == true) {
    outline()
  }
  import "@preview/cheq:0.2.2": checklist
  show: checklist

  // Content
  content
}