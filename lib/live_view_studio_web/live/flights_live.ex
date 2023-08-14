defmodule LiveViewStudioWeb.FlightsLive do
  use LiveViewStudioWeb, :live_view

  alias LiveViewStudio.Flights
  alias LiveViewStudio.Airports

  def mount(_params, _session, socket) do
    socket =
      assign(socket,
        airport: "",
        flights: Flights.list_flights(),
        loading: false,
        matches: %{}
      )

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <h1>Find a Flight</h1>
    <div id="flights">
      <form phx-submit="search-flight" phx-change="suggest">
        <input
          type="text"
          name="airport"
          value={@airport}
          placeholder="Airport Code"
          autofocus
          autocomplete="off"
          readonly={@loading}
          list="matches"
          phx-debounce="500"
        />

        <button>
          <img src="/images/search.svg" />
        </button>
      </form>

      <.loading_indicator visible={@loading} />

      <datalist id="matches">
        <option :for={{code, name} <- @matches} value={code}>
          <%= name %>
        </option>
      </datalist>

      <div class="flights">
        <ul>
          <li :for={flight <- @flights}>
            <div class="first-line">
              <div class="number">
                Flight #<%= flight.number %>
              </div>
              <div class="origin-destination">
                <%= flight.origin %> to <%= flight.destination %>
              </div>
            </div>
            <div class="second-line">
              <div class="departs">
                Departs: <%= flight.departure_time %>
              </div>
              <div class="arrives">
                Arrives: <%= flight.arrival_time %>
              </div>
            </div>
          </li>
        </ul>
      </div>
    </div>
    """
  end

  def handle_event("suggest", %{"airport" => prefix}, socket) do
    matches = Airports.suggest(prefix)

    socket = assign(socket, matches: matches)

    {:noreply, socket}
  end

  def handle_event("search-flight",%{"airport" => airport}, socket) do
    send(self(), {:searching, airport})
    socket =
      assign(socket,
        airport: airport,
        flights: [],
        loading: true
      )
    {:noreply, socket}
  end
  def handle_info({:searching, airport}, socket) do
    socket =
      assign(socket,
        flights: Flights.search_by_airport(airport),
        loading: false
      )
    {:noreply, socket}
  end
end
