defmodule LiveViewStudio.AirportsTest do
  use ExUnit.Case, async: true

  alias LiveViewStudio.Airports

  test "suggest/1 with empty prefix returns empty list" do
    assert [] = Airports.suggest("")
  end

  test "suggest/1 with prefix returns list of airports with prefix" do
    matches = %{"AWK" => "Wake Island Airfield", "AWZ" => "Ahwaz Airport"}
    assert ^matches = Airports.suggest("AW")
  end
end
