import gleam/list
import gleam/float
import gleam/regex
import gleam/string
import gleam/result

pub type Relic {
  Relic(name: String, drops: List(Drop))
}

pub type Drop {
  Drop(item: String, chance: Float)
}

fn split_after_title(text: String) -> Result(#(String, String), Nil) {
  text
  |> string.crop("\">")
  |> string.drop_left(string.length("\">"))
  |> string.split_once("</th></tr>")
}

fn parse_drops(text: String) -> Result(List(Drop), Nil) {
  let assert Ok(number_regex) = regex.from_string("\\d+\\.\\d+")
  text
  |> string.trim()
  |> string.drop_left(string.length("<tr><td>"))
  |> string.drop_right(string.length("</td></tr>"))
  |> string.split("</td></tr><tr><td>")
  |> list.map(fn(row) {
    row
    |> string.split_once("</td><td>")
    |> result.map(fn(res) {
      let #(item, chance) = res

      let chance_number =
        chance
        |> regex.scan(with: number_regex)
        |> list.map(fn(match) { match.content })
        |> list.first
        |> result.map(float.parse)
        |> result.flatten
        |> result.unwrap(0.0)

      Drop(item, chance_number)
    })
  })
  |> result.all()
}

pub fn parse_string(text: String) -> Result(Relic, Nil) {
  let text = string.trim(text)

  use #(title, rest) <- result.try(split_after_title(text))
  use drops <- result.try(parse_drops(rest))

  Ok(Relic(title, drops))
}

const blank_row = "<tr class=\"blank-row\"><td class=\"blank-row\" colspan=\"2\"></td></tr>"

pub fn parse_table(text: String) -> Result(List(Relic), Nil) {
  text
  |> string.trim
  |> string.split(blank_row)
  |> list.filter(fn(x) { string.length(x) > 10 })
  |> list.map(fn(row) {
    row
    |> string.trim
    |> parse_string
  })
  |> result.all
}
