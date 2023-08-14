defmodule LiveViewStudio.FlightsTest do
  use ExUnit.Case, async: true

  alias LiveViewStudio.Flights

  test "list_flights/0 returns a list of flights" do
    [flight | _] = Flights.list_flights()

    assert %{number: "450", origin: "DEN", destination: "ORD"} = flight
  end

  test "search_by_airport/1 returns flights originating from airport" do
    [flight | _] = Flights.search_by_airport("DEN")

    assert %{number: "450", origin: "DEN", destination: "ORD"} = flight
  end

  test "search_by_airport/1 returns flights departing from airport" do
    [flight | _] = Flights.search_by_airport("ORD")

    assert %{number: "450", origin: "DEN", destination: "ORD"} = flight
  end
end
