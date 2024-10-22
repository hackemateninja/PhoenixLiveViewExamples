defmodule LiveViewStudioWeb.LightLive do
  use LiveViewStudioWeb, :live_view

  def mount(_params, _session, socket) do
    socket =
      assign(socket,
        brightness: 10,
        temp: "3000"
      )

    {:ok, socket}
  end

  def handle_event("change-temp", %{"temp" => temp}, socket) do
    {:noreply, assign(socket, temp: temp)}
  end

  def handle_event("slide", %{"brightness" => b}, socket) do
    {:noreply, assign(socket, brightness: String.to_integer(b))}
  end

  def handle_event("off", _, socket) do
    {:noreply, assign(socket, brightness: 0)}
  end

  def handle_event("up", _, socket) do
    socket = update(socket, :brightness, &min(&1 + 10, 100))
    {:noreply, socket}
  end

  def handle_event("fire", _, socket) do
    {:noreply, assign(socket, brightness: Enum.random(0..100))}
  end

  def handle_event("down", _, socket) do
    socket = update(socket, :brightness, &max(&1 - 10, 0))
    {:noreply, socket}
  end

  def handle_event("on", _, socket) do
    {:noreply, assign(socket, brightness: 100)}
  end

  defp change_temp(color) when is_binary(color) do
    %{
      "3000" => "#F1C40D",
      "4000" => "#FEFF66",
      "5000" => "#99CCFF"
    }[color]
  end

  def render(assigns) do
    ~H"""
    <h1>Front Porch Light</h1>
    <div id="light">
      <div class="meter">
        <span style={"width: #{@brightness}%; background-color: #{change_temp(@temp)}"}>
          <%= @brightness %>%
        </span>
      </div>

      <div class="my-6">
        <form phx-change="change-temp">
          <div class="temps">
            <%= for temp <- ["3000", "4000", "5000"] do %>
              <div>
                <input
                  type="radio"
                  id={temp}
                  name="temp"
                  value={temp}
                  checked={temp == @temp}
                />
                <label for={temp}><%= temp %></label>
              </div>
            <% end %>
          </div>
        </form>
      </div>
      <div class="my-6">
        <form phx-change="slide">
          <input
            type="range"
            min="0"
            max="100"
            name="brightness"
            value={@brightness}
          />
        </form>
      </div>
      <button phx-click="off">
        <img src="/images/light-off.svg" alt="light-off" />
      </button>

      <button phx-click="up">
        <img src="/images/up.svg" alt="up" />
      </button>

      <button phx-click="fire">
        <img src="/images/fire.svg" alt="fire" />
      </button>

      <button phx-click="down">
        <img src="/images/down.svg" alt="down" />
      </button>

      <button phx-click="on">
        <img src="/images/light-on.svg" alt="light-on" />
      </button>
    </div>
    """
  end
end

# defmodule LiveViewStudioWeb.LightLive do
#   use LiveViewStudioWeb, :live_view

#   def mount(_params, _session, socket) do
#     socket = assign(socket, brightness: 10, temp: "3000")
#     {:ok, socket}
#   end

#   def render(assigns) do
#     ~H"""
#     <h1>Front porch light</h1>
#     <div id="light">
#       <div class="meter">
#         <span style={"width: #{@brightness}%; background: #{temp_color(@temp)}"}>
#           <%= @brightness %>%
#         </span>
#       </div>

#       <div class="temps">
#         <form phx-change="change-temp">
#           <%= for temp <- ["3000", "4000", "5000"] do %>
#             <input
#               type="radio"
#               id={temp}
#               name="temp"
#               value={temp}
#               checked={temp == @temp}
#             />
#             <label for={temp}><%= temp %></label>
#           <% end %>
#         </form>
#       </div>
#       <div class="temps">
#         <form phx-change="slide">
#           <input
#             phx-debounce="250"
#             type="range"
#             min="0"
#             max="100"
#             name="brightness"
#             value={@brightness}
#           />
#         </form>
#       </div>
#       <button phx-click="off">
#         <img src="/images/light-off.svg" alt="light-off" />
#       </button>
#       <button phx-click="up">
#         <img src="/images/up.svg" alt="up" />
#       </button>
#       <button phx-click="fire">
#         <img src="/images/fire.svg" alt="fire" />
#       </button>
#       <button phx-click="down">
#         <img src="/images/down.svg" alt="down" />
#       </button>
#       <button phx-click="on">
#         <img src="/images/light-on.svg" alt="light-on" />
#       </button>
#     </div>
#     """
#   end

#   defp temp_color("3000"), do: "#F1C40D"
#   defp temp_color("4000"), do: "#FEFF66"
#   defp temp_color("5000"), do: "#99CCFF"

#   def handle_event("change-temp", %{"temp" => temp}, socket) do
#     socket = assign(socket, temp: temp)
#     {:noreply, socket}
#   end

#   def handle_event("slide", %{"brightness" => b}, socket) do
#     socket = assign(socket, brightness: String.to_integer(b))
#     {:noreply, socket}
#   end

#   def handle_event("off", _, socket) do
#     socket = assign(socket, brightness: 0)
#     {:noreply, socket}
#   end

#   def handle_event("up", _, socket) do
#     socket = update(socket, :brightness, &min(&1 + 10, 100))
#     {:noreply, socket}
#   end

#   def handle_event("fire", _, socket) do
#     socket = assign(socket, brightness: Enum.random(0..100))
#     {:noreply, socket}
#   end

#   def handle_event("down", _, socket) do
#     socket = update(socket, :brightness, &max(&1 - 10, 0))
#     {:noreply, socket}
#   end

#   def handle_event("on", _, socket) do
#     socket = assign(socket, brightness: 100)
#     {:noreply, socket}
#   end
# end
