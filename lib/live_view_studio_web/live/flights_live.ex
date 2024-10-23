defmodule LiveViewStudioWeb.FlightsLive do
  use LiveViewStudioWeb, :live_view

  alias LiveViewStudio.Flights
  alias LiveViewStudio.Airports

  def mount(_params, _session, socket) do
    socket = reset_data(socket)

    {:ok, socket}
  end

  def handle_event("suggest", %{"airport" => prefix}, socket) do
    if String.length(prefix) > 0 do
      matches = Airports.suggest(prefix)
      socket = assign(socket, matches: matches, can_search?: true)
      {:noreply, socket}
    else
      socket = reset_data(socket)
      {:noreply, socket}
    end
  end

  def handle_event("search-flight", %{"airport" => airport}, socket) do
    {:noreply, search_button_action(airport, socket)}
  end

  def handle_event("reset-search", _, socket) do
    {:noreply, reset_data(socket)}
  end

  defp reset_data(socket) do
    assign(socket,
      airport: "",
      flights: Flights.list_flights(),
      loading: false,
      matches: %{},
      can_search?: false
    )
  end

  defp search_button_action("", socket) do
    reset_data(socket)
  end

  defp search_button_action(airport, socket) do
    send(self(), {:searching, airport})

    assign(socket,
      airport: airport,
      flights: [],
      loading: true,
      matches: %{},
      can_search?: true
    )
  end

  def handle_info({:searching, airport}, socket) do
    socket =
      assign(socket,
        flights: Flights.search_by_airport(airport),
        airport: "",
        loading: false
      )

    {:noreply, socket}
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

        <button disabled={not @can_search?} phx-disable-with="Searching...">
          <img src="/images/search.svg" />
        </button>
      </form>

      <.loading_indicator visible={@loading} />

      <datalist id="matches">
        <option :for={{code, name} <- @matches} value={code}>
          <%= name %> (<%= code %>)
        </option>
      </datalist>

      <div class="flights">
        <ul :if={not Enum.empty?(@flights)}>
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

        <div :if={Enum.empty?(@flights) && not @loading} class="">
          <h1>No flights here!</h1>

          <button class="mt-4" phx-click="reset-search">
            Reset the search
          </button>
        </div>
      </div>
    </div>
    """
  end
end
