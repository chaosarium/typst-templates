#let csv-tabel(arg) = {
  let arr = arg.trim().split("\n").map(x => x.split(",").map(x => x.trim()))
  table(
    columns: arr.at(0).len(),
    ..arr.flatten(),
  )
}