import gleeunit/should
import gleam/list
import simplifile
import gleam/string
import wf_drops/albrecht

pub fn albrecht_test() {
  let assert Ok(input) = simplifile.read("./albrecht.html")

  input
  |> albrecht.parse_table
  |> should.be_ok
}
