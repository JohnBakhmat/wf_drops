import gleeunit/should
import gleam/list
import wf_drops/relics.{Drop, Relic}
import simplifile
import gleam/string

pub fn parse_relic_string_test() {
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

pub fn parse_relic_table_test() {
  let input =
    "
    <tr><th colspan=\"2\">Axi A1 Relic (Intact)</th></tr><tr><td>Akstiletto Prime Barrel</td><td>Uncommon (11.00%)</td></tr><tr><td>Trinity Prime Systems Blueprint</td><td>Uncommon (25.33%)</td></tr><tr><td>Fragor Prime Head</td><td>Uncommon (25.33%)</td></tr><tr><td>Dual Kamas Prime Handle</td><td>Uncommon (11.00%)</td></tr><tr><td>Braton Prime Stock</td><td>Uncommon (25.33%)</td></tr><tr><td>Nikana Prime Blueprint</td><td>Rare (2.00%)</td></tr>
<tr class=\"blank-row\"><td class=\"blank-row\" colspan=\"2\"></td></tr>
<tr><th colspan=\"2\">Axi A1 Relic (Exceptional)</th></tr><tr><td>Akstiletto Prime Barrel</td><td>Uncommon (13.00%)</td></tr><tr><td>Trinity Prime Systems Blueprint</td><td>Uncommon (23.33%)</td></tr><tr><td>Fragor Prime Head</td><td>Uncommon (23.33%)</td></tr><tr><td>Dual Kamas Prime Handle</td><td>Uncommon (13.00%)</td></tr><tr><td>Braton Prime Stock</td><td>Uncommon (23.33%)</td></tr><tr><td>Nikana Prime Blueprint</td><td>Rare (4.00%)</td></tr>
<tr class=\"blank-row\"><td class=\"blank-row\" colspan=\"2\"></td></tr>
<tr><th colspan=\"2\">Axi A1 Relic (Flawless)</th></tr><tr><td>Akstiletto Prime Barrel</td><td>Uncommon (17.00%)</td></tr><tr><td>Trinity Prime Systems Blueprint</td><td>Uncommon (20.00%)</td></tr><tr><td>Fragor Prime Head</td><td>Uncommon (20.00%)</td></tr><tr><td>Dual Kamas Prime Handle</td><td>Uncommon (17.00%)</td></tr><tr><td>Braton Prime Stock</td><td>Uncommon (20.00%)</td></tr><tr><td>Nikana Prime Blueprint</td><td>Rare (6.00%)</td></tr>
<tr class=\"blank-row\"><td class=\"blank-row\" colspan=\"2\"></td></tr>
<tr><th colspan=\"2\">Axi A1 Relic (Radiant)</th></tr><tr><td>Akstiletto Prime Barrel</td><td>Uncommon (20.00%)</td></tr><tr><td>Trinity Prime Systems Blueprint</td><td>Uncommon (16.67%)</td></tr><tr><td>Fragor Prime Head</td><td>Uncommon (16.67%)</td></tr><tr><td>Dual Kamas Prime Handle</td><td>Uncommon (20.00%)</td></tr><tr><td>Braton Prime Stock</td><td>Uncommon (16.67%)</td></tr><tr><td>Nikana Prime Blueprint</td><td>Uncommon (10.00%)</td></tr>
<tr class=\"blank-row\"><td class=\"blank-row\" colspan=\"2\"></td></tr>
<tr><th colspan=\"2\">Axi A10 Relic (Intact)</th></tr><tr><td>Aksomati Prime Link</td><td>Rare (2.00%)</td></tr><tr><td>Wukong Prime Chassis Blueprint</td><td>Uncommon (11.00%)</td></tr><tr><td>Paris Prime Grip</td><td>Uncommon (11.00%)</td></tr><tr><td>Akbronco Prime Blueprint</td><td>Uncommon (25.33%)</td></tr><tr><td>Forma Blueprint</td><td>Uncommon (25.33%)</td></tr><tr><td>Stradavar Prime Receiver</td><td>Uncommon (25.33%)</td></tr>
<tr class=\"blank-row\"><td class=\"blank-row\" colspan=\"2\"></td></tr>
<tr><th colspan=\"2\">Axi A10 Relic (Exceptional)</th></tr><tr><td>Aksomati Prime Link</td><td>Rare (4.00%)</td></tr><tr><td>Wukong Prime Chassis Blueprint</td><td>Uncommon (13.00%)</td></tr><tr><td>Paris Prime Grip</td><td>Uncommon (13.00%)</td></tr><tr><td>Akbronco Prime Blueprint</td><td>Uncommon (23.33%)</td></tr><tr><td>Forma Blueprint</td><td>Uncommon (23.33%)</td></tr><tr><td>Stradavar Prime Receiver</td><td>Uncommon (23.33%)</td></tr>
<tr class=\"blank-row\"><td class=\"blank-row\" colspan=\"2\"></td></tr>
<tr><th colspan=\"2\">Axi A10 Relic (Flawless)</th></tr><tr><td>Aksomati Prime Link</td><td>Rare (6.00%)</td></tr><tr><td>Wukong Prime Chassis Blueprint</td><td>Uncommon (17.00%)</td></tr><tr><td>Paris Prime Grip</td><td>Uncommon (17.00%)</td></tr><tr><td>Akbronco Prime Blueprint</td><td>Uncommon (20.00%)</td></tr><tr><td>Forma Blueprint</td><td>Uncommon (20.00%)</td></tr><tr><td>Stradavar Prime Receiver</td><td>Uncommon (20.00%)</td></tr>
<tr class=\"blank-row\"><td class=\"blank-row\" colspan=\"2\"></td></tr>
<tr><th colspan=\"2\">Axi A10 Relic (Radiant)</th></tr><tr><td>Aksomati Prime Link</td><td>Uncommon (10.00%)</td></tr><tr><td>Wukong Prime Chassis Blueprint</td><td>Uncommon (20.00%)</td></tr><tr><td>Paris Prime Grip</td><td>Uncommon (20.00%)</td></tr><tr><td>Akbronco Prime Blueprint</td><td>Uncommon (16.67%)</td></tr><tr><td>Forma Blueprint</td><td>Uncommon (16.67%)</td></tr><tr><td>Stradavar Prime Receiver</td><td>Uncommon (16.67%)</td></tr>
<tr class=\"blank-row\"><td class=\"blank-row\" colspan=\"2\"></td></tr>
    "

  input
  |> relics.parse_table
  |> should.be_ok
  |> list.length
  |> should.equal(8)
}

pub fn real_parse_test() {
  let assert Ok(data) = simplifile.read("./relics.html")

  data
  |> string.trim()
  |> string.crop("<tr>")
  |> relics.parse_table
  |> should.be_ok
}
