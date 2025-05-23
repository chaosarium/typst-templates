#import "components/blocks.typ": *
#import "components/envs.typ": *
#let total_pages = locate(loc => counter(page).final(loc).at(0))

// template based on https://github.com/BeitianMa/typst-lecture-notes

/* Figures */
// The numbering policy is as before, and the default display is centered
#let notefig(path, width: 100%) = {
  let figure_counter = counter("Figure")

  locate(loc => {
    let serial_num = (
      h1_marker.at(loc).last(),
      h2_marker.at(loc).last(),
      figure_counter.at(loc).last() + 1,
    ).map(str).join(".")

    let serial_label = label("Figure" + " " + serial_num)

    block(
      width: 100%,
      inset: 8pt,
      align(center)[#image(path, width: width)],
    )

    set align(center)
    text(12pt, weight: "bold")[Figure #serial_num #serial_label #figure_counter.step()]
  })
}


/* References of blocks */
// Automatically jump to the corresponding blocks
// The form of the input should look something like "Definition 1.3.1"
#let refto(class_with_serial_num) = {
  link(label(class_with_serial_num), [*#class_with_serial_num*])
}


/* Headings of various levels */
// Templates support up to three levels of headings,
// and notes with more than three headings are usually mess
#let set_headings(body) = {
  set heading(numbering: "1.1.1")

  // 1st level heading
  show heading.where(level: 1): it => [
    // Under each new h1, reset the sequence number of the blocks
    #for class in classes {
      counter(class).update(0)
    }
    #counter("h2").update(0)
    #counter("Figure").update(0)

    // Start a new page unless this is the first chapter
    #locate(loc => {
      let h1_before = query(
        heading.where(level: 1).before(loc),
        loc,
      )

      if h1_before.len() != 1 {
        pagebreak()
      }
    })

    // Font size and white space
    #set text(20pt, weight: "bold")
    #block[Chapter #counter(heading).display(): #it.body]
    #v(25pt)
    #h1_marker.step()
  ]

  // 2st level heading
  show heading.where(level: 2): it => [
    #set text(17pt, weight: "bold")
    #block[#it]
    #h2_marker.step()
  ]

  // 3st level heading
  show heading.where(level: 3): it => [
    #set text(14pt, weight: "bold")
    #block[#it]
  ]

  body
}


/* Cover page */
// Create a note cover with the course name, author, and time
// Modify parameters here if you want to add or modify information item
#let cover_page(title, author, professor, creater, time, abstract, university) = {
  set page(
    paper: "a4",

    header: align(right)[
      #smallcaps[#title]
      #v(-6pt)
      #line(length: 40%)
    ],

    footer: locate(loc => {
      align(center)[#loc.page()]
    }),
  )

  block(height: 30%, fill: none)
  align(center, text(18pt)[*#title*])
  align(center, text(12pt)[*#author*])
  align(center, text(11pt)[#professor])

  v(7.5%)
  abstract

  block(height: 30%, fill: none)
  align(center, [_ #time _])
}


/* Outline page */
// Defualt depth is 2
#let outline_page(title) = {
  set page(
    paper:"a4",

    // Headers are set to right- and left-justified
    // on odd and even pages, respectively
    header: locate(loc => {
    if calc.odd(loc.page()) {
      align(right)[
        #smallcaps[#title]
        #v(-6pt)
        #line(length: 40%)
      ]
    } else {
      align(left)[
        #smallcaps[#title]
        #v(-6pt)
        #line(length: 40%)
      ]
    }
    }),

    footer: locate(loc => {
      // if calc.odd(loc.page()) {
      //   align(right)[#loc.page()]
      // } else {
      //   align(left)[#loc.page()]
      // }

      align(center)[#loc.page()]
    })
  )

  show outline.entry.where(level: 1): it => {
    v(12pt, weak: true)
    strong("§ " + it)
  }

  align(center, text(18pt, weight: "bold")[#title])
  v(15pt)
  outline(title: none, depth: 3, indent: auto)
}


/* Body text page */
// Format the headers and headings of the body
#let body_page(title, body) = {
  set page(
    paper: "a4",

    header: locate(loc => {
      let h1_before = query(
        heading.where(level: 1).before(loc),
        loc,
      )

      let h1_after = query(
        heading.where(level: 1).after(loc),
        loc,
      )

      // Right- and left-justified on odd and even pages, respectively
      // Automatically matches the nearest level 1 title
      if calc.odd(loc.page()) {
        if h1_before == () {
          align(right)[_ #h1_after.first().body _ #v(-6pt) #line(length: 40%)]
        } else {
          align(right)[_ #h1_before.last().body _ #v(-6pt) #line(length: 40%)]
        }
      } else {
        if h1_before == () {
          align(left)[_ #h1_after.first().body _ #v(-6pt) #line(length: 40%)]
        } else {
          align(left)[_ #h1_before.last().body _ #v(-6pt) #line(length: 40%)]
        }
      }
    }),

    footer: locate(loc => {
      align(center)[#loc.page()]
    }),
  )

  set_headings(body)
}


/* All pages */
// Organize all types of pages
// If you want to add or modify other global Settings, please do so here
#let note_page(title, author, professor, creater, time, abstract, university, body) = {
  set document(title: title, author: author)
  set par(justify: true)

  cover_page(title, author, professor, creater, time, abstract, university)
  outline_page("Contents")

  body_page(
    title,
    [
      // Code
      #show raw.where(block: false): box.with(
      // fill: rgb("#ffffff44"),
      // stroke: rgb("#a1a1aaaa"),
      // inset: (x: 3pt, y: 0pt),
      outset: (y: 3pt),
      radius: 2pt,
    )

      #show raw.where(block: true): block.with(
      width: 100%,
      fill: rgb("#ffffff44"),
      stroke: rgb("#a1a1aaaa"),
      inset: 10pt,
      // radius: 4pt,
    )

      #show table: it => [
        #set align(center)
        #it
      ]


      #let code_with_line_number = false // TODO fix broken numbering for long line
      // Code block with line numbers
      #show raw.where(block: true): it => {
        if not code_with_line_number {
          return it
        }
        let lines = it.text.split("\n")
        let length = lines.len()
        let i = 0
        let left_str = while i < length {
          i = i + 1
          str(i) + "\n"
        }
        grid(
          columns: (auto, 1fr),
          align(
            right,
            block(
              inset: (
                top: 10pt,
                bottom: 10pt,
                left: 0pt,
                right: 5pt,
              ),
              left_str,
            ),
          ),
          align(left, it),
        )
      }


      #body
    ],
  )



}
