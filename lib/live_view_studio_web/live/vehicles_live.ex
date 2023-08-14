defmodule LiveViewStudioWeb.VehiclesLive do
  use LiveViewStudioWeb, :live_view

  alias LiveViewStudio.Vehicles

  def mount(_params, _session, socket) do
    socket =
      assign(socket,
        vehicles: Vehicles.list_vehicles(),
        loading: false,
        query: ""
      )

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <h1>🚙 Find a Vehicle 🚘</h1>
    <div id="vehicles">
      <form phx-submit="search">
        <input
          type="text"
          name="query"
          value={@query}
          placeholder="Make or model"
          autofocus
          autocomplete="off"
        />

        <button>
          <img src="/images/search.svg" />
        </button>
      </form>

      <.loading_indicator visible={@loading} />

      <div class="vehicles">
        <ul>
          <li :for={vehicle <- @vehicles}>
            <span class="make-model">
              <%= vehicle.make_model %>
            </span>
            <span class="color">
              <%= vehicle.color %>
            </span>
            <span class={"status #{vehicle.status}"}>
              <%= vehicle.status %>
            </span>
          </li>
        </ul>
      </div>
    </div>
    """
  end


  def handle_event("search",%{"query" => query}, socket) do
    send(self(), {:query, query})
    socket =
      assign(socket,
        query: query,
        vehicles: [],
        loading: true
      )
    {:noreply, socket}
  end

  def handle_info({:query, query}, socket) do
    socket =
      assign(socket,
        query: "",
        vehicles: Vehicles.search(query),
        loading: false
      )
    {:noreply, socket}
  end
end
