import gleeunit/should
import simplifile
import wf_drops/albrecht
import wf_drops/relics

pub fn albrecht_test() {
  let assert Ok(input) = simplifile.read("./albrecht.html")

  input
  |> albrecht.parse_table
  |> should.be_ok
  |> should.equal(
    albrecht.Reward("Level 55 - 60 Entrati Lab Bounty", [
      relics.Drop("15,000 Credits", 17.39),
      relics.Drop("500 Endo", 17.39),
      relics.Drop("Shrill Voca", 13.04),
      relics.Drop("30,000 Credits", 13.04),
      relics.Drop("750 Endo", 13.04),
      relics.Drop("Aya", 8.7),
      relics.Drop("Qorvex Neuroptics Blueprint", 13.04),
      relics.Drop("Mandonel Blueprint", 4.35),
    ]),
  )
}
