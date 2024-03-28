import gleeunit/should
import wf_drops/relics.{Drop, Relic}

pub fn parse_relic_table_test() {
  let input =
    "
<tr><th colspan=\"2\">Axi A1 Relic (Intact)</th></tr><tr><td>Akstiletto Prime Barrel</td><td>Uncommon (11.00%)</td></tr><tr><td>Trinity Prime Systems Blueprint</td><td>Uncommon (25.33%)</td></tr><tr><td>Fragor Prime Head</td><td>Uncommon (25.33%)</td></tr><tr><td>Dual Kamas Prime Handle</td><td>Uncommon (11.00%)</td></tr><tr><td>Braton Prime Stock</td><td>Uncommon (25.33%)</td></tr><tr><td>Nikana Prime Blueprint</td><td>Rare (2.00%)</td></tr>
    "

  input
  |> relics.parse_string
  |> should.be_ok
  |> should.equal(
    Relic(name: "Axi A1 Relic (Intact)", drops: [
      Drop("Akstiletto Prime Barrel", 11.0),
      Drop("Trinity Prime Systems Blueprint", 25.33),
      Drop("Fragor Prime Head", 25.33),
      Drop("Dual Kamas Prime Handle", 11.0),
      Drop("Braton Prime Stock", 25.33),
      Drop("Nikana Prime Blueprint", 2.0),
    ]),
  )
}
