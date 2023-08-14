defmodule LiveViewStudio.VehiclesTest do
  use ExUnit.Case, async: true

  alias LiveViewStudio.Vehicles

  test "list_vehicles/0 returns a list of vehicles" do
    [vehicle | _] = Vehicles.list_vehicles()

    assert %{make_model: "Toyota Camry"} = vehicle
  end

  test "search/1 returns vehicles matching make or model" do
    [vehicle | _] = Vehicles.search("Prius")

    assert %{make_model: "Toyota Prius"} = vehicle

    [vehicle | _] = Vehicles.search("Honda")

    assert %{make_model: "Honda CR-V"} = vehicle
  end

  test "suggest/1 with empty prefix returns empty list" do
    assert [] = Vehicles.suggest("")
  end

  test "suggest/1 with prefix returns list of vehicles with prefix" do
    matches = ["Dodge Durango", "Dodge Ram", "Dodge Charger"]

    assert ^matches = Vehicles.suggest("Dodge")
  end
end
