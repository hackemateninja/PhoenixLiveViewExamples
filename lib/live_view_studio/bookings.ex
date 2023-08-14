defmodule LiveViewStudio.Bookings do
  def list_bookings do
    [
      %{
        from: add_days(-14),
        to: add_days(-12)
      },
      %{
        from: add_days(4),
        to: add_days(5)
      },
      %{
        from: add_days(12),
        to: add_days(15)
      },
      %{
        from: add_days(30),
        to: add_days(33)
      },
      %{
        from: add_days(40),
        to: add_days(45)
      }
    ]
  end

  def add_days(days) do
    Timex.today() |> Timex.shift(days: days)
  end
end
