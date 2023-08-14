defmodule LiveViewStudio.BookingsTest do
  use ExUnit.Case, async: true

  alias LiveViewStudio.Bookings

  test "list_bookings/0 returns a list of bookings" do
    [booking | _] = Bookings.list_bookings()

    assert %{from: %Date{}, to: %Date{}} = booking
  end
end
