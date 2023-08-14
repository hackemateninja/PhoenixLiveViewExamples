defmodule LiveViewStudio.SandboxTest do
  use ExUnit.Case, async: true

  alias LiveViewStudio.Sandbox

  test "calculate_weight/3 with numbers" do
    weight = Sandbox.calculate_weight(1, 2.2, 3)

    assert 48.2 == weight
  end

  test "calculate_weight/3 with strings" do
    weight = Sandbox.calculate_weight("1", "2.2", "3")

    assert 48.2 == weight
  end

  test "calculate_price/1" do
    price = Sandbox.calculate_price(48.2)

    assert 7.23 == price
  end
end
