defmodule LiveViewStudioWeb.BingoLive do
  use LiveViewStudioWeb, :live_view

  def mount(_params, _session, socket) do
    if connected?(socket) do
      :timer.send_interval(3000, self(), :tick)
    end

    socket =
      assign(socket,
        number: nil,
        numbers: all_numbers()
      )

    {:ok, socket}
  end

  def handle_info(:tick, socket) do
    {:noreply, pick(socket)}
  end

  # Assigns the next random bingo number, removing it
  # from the assigned list of numbers. Resets the list
  # when the last number has been picked.
  defp pick(socket) do
    case socket.assigns.numbers do
      [head | []] ->
        assign(socket, number: head, numbers: all_numbers())

      [head | tail] ->
        assign(socket, number: head, numbers: tail)
    end
  end

  # Returns a list of all valid bingo numbers in random order.
  #
  # Example: ["B 4", "N 40", "O 73", "I 29", ...]
  defp all_numbers() do
    ~w(B I N G O)
    |> Enum.zip(Enum.chunk_every(1..75, 15))
    |> Enum.flat_map(fn {letter, numbers} ->
      Enum.map(numbers, &"#{letter} #{&1}")
    end)
    |> Enum.shuffle()
  end

  def render(assigns) do
    ~H"""
    <h1>Bingo Boss 📢</h1>
    <div id="bingo">
      <div class="number">
        <%= @number %>
      </div>
    </div>
    """
  end
end
