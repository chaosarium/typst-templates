/* Blocks */
// Pls add or remove elements in this array first,
// if you want to add or remove the class of blocks
#let classes = (
  "Definition", 
  "Lemma", 
  "Theorem", 
  "Corollary", 
  "Ponder", 
  "Example", 
  "Fact", 
  "Note", 
  "Strategy", 
  "Algorithm"
)
#let h1_marker = counter("h1")
#let h2_marker = counter("h2")

#let note_block(body, class: "Block", fill: rgb("#FFFFFF"), stroke: rgb("#000000"), identifier: "") = {
  let block_counter = counter(class)

  context { let loc = here();
    // Returns the serial number of the current block
    // The format is just like "Definition 1.3.1"
    let serial_num = (
    h1_marker.at(loc).last(),
    h2_marker.at(loc).last(),
    block_counter.at(loc).last() + 1)
    .map(str)
    .join(".")

    let serial_label = label(class + " " + serial_num)
    let named_label = label(identifier)
        
    rect(fill:fill,
    width: 100%,
    inset:8pt,
    // radius: 4pt,
    stroke:stroke,
    [
      #text(12pt, weight: "bold")[#class #serial_num #serial_label #named_label #block_counter.step()] 

      #body 
    ])
  }
}


#let def(body, id: "") = note_block(
  body, class: "Definition", fill: rgb("#f0fdf4"), stroke: rgb("#16a34a"), identifier: id
)
#let ponder(body) = note_block(
  body, class: "Ponder", fill: rgb("#f1f5f9"), stroke: rgb("#475569")
)
#let note(body) = note_block(
  body, class: "Note", fill: rgb("#fffbeb"), stroke: rgb("#d97706")
)
#let ex(body) = note_block(
  body, class: "Example", fill: rgb("#eff6ff"), stroke: rgb("#2563eb")
)
#let fact(body) = note_block(
  body, class: "Fact", fill: rgb("#f5f3ff"), stroke: rgb("#7c3aed")
)
#let alg(body) = note_block(
  body, class: "Algorithm", fill: rgb("#fef2f2"), stroke: rgb("#dc2626")
)
#let thm(body) = note_block(
  body, class: "Theorem", fill: rgb("#fff7ed"), stroke: rgb("#ea580c")
)
#let corol(body) = note_block(
  body, class: "Corollary", fill: rgb("#ecfeff"), stroke: rgb("#0891b2")
)
#let lemma(body) = note_block(
  body, class: "Lemma", fill: rgb("#fefce8"), stroke: rgb("#ca8a04")
)
#let strategy(body) = note_block(
  body, class: "Strategy", fill: rgb("#f0fdfa"), stroke: rgb("#0d9488")
)