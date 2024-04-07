import gleam/string
import gleam/list
import gleam/result
import gleam/option
import gleam/regex
import wf_drops/relics.{type Drop}

pub type AlbrechtBountyReward {
  Reward(bounty: String, drops: List(Drop))
}

fn parse_title(text: String) -> String {
  text
  |> string.crop("Level")
  |> string.drop_right(string.length("</th></tr>"))
}

fn parse_rewards(text: String) -> List(Drop) {
  text
  |> string.split("</tr><tr><td></td>")
  |> list.filter(fn(x) { string.length(x) > 5 })
  |> list.map(fn(drop) {
    let assert Ok(#(item, raw_chance)) =
      drop
      |> string.drop_left(string.length("<td>"))
      |> string.drop_right(string.length("</td>"))
      |> string.split_once("</td><td>")

    relics.Drop(item, relics.parse_chance(raw_chance))
  })
}

pub fn parse_table(text: String) -> Result(AlbrechtBountyReward, Nil) {
  let assert Ok(regex) = regex.from_string(".*(<tr>.*colspan.*<\\/th>)")
  let assert Ok(split_string) =
    text
    |> regex.scan(with: regex)
    |> list.map(fn(x) { x.submatches })
    |> list.first()
    |> result.map(fn(x) {
      x
      |> option.values
      |> list.first
    })
    |> result.flatten

  let assert Ok(#(raw_title, raw_rewards)) =
    text
    |> string.trim
    |> string.split_once(split_string)

  let title = parse_title(raw_title)
  let rewards = parse_rewards(raw_rewards)

  Ok(Reward(title, rewards))
}
