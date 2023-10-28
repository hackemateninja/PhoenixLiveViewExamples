defmodule LiveViewStudioWeb.BookingsLive do
  use LiveViewStudioWeb, :live_view

  alias LiveViewStudio.Bookings
  import Number.Currency

  def mount(_params, _session, socket) do
    {:ok,
     assign(socket,
       bookings: Bookings.list_bookings(),
       selected_dates: nil
     )}
  end

  def render(assigns) do
    ~H"""
    <h1>Bookings</h1>
    <div id="bookings">
      <div id="wrapper" phx-update="ignore">
        <div
          id="booking-calendar"
          phx-hook="Calendar"
          data-unavailable-dates={Jason.encode!(@bookings)}
        >
        </div>
      </div>
      <div :if={@selected_dates} class="details">
        <div>
          <span class="date">
            <%= format_date(@selected_dates.from) %>
          </span>
          -
          <span class="date">
            <%= format_date(@selected_dates.to) %>
          </span>
          <span class="nights">
            (<%= total_nights(@selected_dates) %> nights)
          </span>
        </div>
        <div class="price">
          <%= total_price(@selected_dates) %>
        </div>
        <button phx-click="book-selected-dates">
          Book Dates
        </button>
      </div>
    </div>
    """
  end

  def handle_event("dates-picked", [from, to], socket) do
    {:noreply, assign(socket, selected_dates: %{from: parse_date(from), to: parse_date(to)})}
  end

  def handle_event("book-selected-dates", _, socket) do
    %{selected_dates: selected_dates, bookings: bookings} = socket.assigns

    socket =
      socket
      |> assign(:bookings, [selected_dates | bookings])
      |> assign(:selected_dates, nil)
      |> push_event("add-unavailable-dates", selected_dates)

    {:noreply, socket}
  end

  def format_date(date) do
    Timex.format!(date, "%m/%d", :strftime)
  end

  def total_nights(%{from: from, to: to}) do
    Timex.diff(to, from, :days)
  end

  def total_price(selected_dates) do
    selected_dates
    |> total_nights()
    |> then(&(&1 * 100))
    |> number_to_currency(precision: 0)
  end

  def parse_date(date_string) do
    date_string |> Timex.parse!("{ISO:Extended}") |> Timex.to_date()
  end
end
