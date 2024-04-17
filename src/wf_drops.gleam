import gleam/io
import gleam/list
import gleam/result
import gleam/string
import simplifile
import wf_drops/relics

const blank_row = "<tr class=\"blank-row\"><td class=\"blank-row\" colspan=\"2\"></td></tr>"

pub fn main() {
  io.println("Hi. Trying to parse some relics. One second ...")

  let assert Ok(relic_file) = simplifile.read("./relics.html")
  relic_file
  |> string.split(blank_row)
  |> list.filter(fn(str) { string.length(str) > 10 })
  |> list.sized_chunk(6)
  |> list.map(fn(chunk) { list.map(chunk, relics.parse_string) })
  |> list.map(fn(chunk_result) {
    chunk_result
    |> result.all
    |> result.map(fn(result) {
      list.map(result, fn(relic) {
        relic.name
        |> io.debug
      })
    })
  })
}
