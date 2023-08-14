defmodule LiveViewStudioWeb.PizzaOrdersLive do
  use LiveViewStudioWeb, :live_view

  alias LiveViewStudio.PizzaOrders
  import Number.Currency


  def mount(_params, _session, socket) do
    {:ok, socket, temporary_assigns: [pizza_orders: []]}
  end


  def handle_params(params, _uri, socket) do
    sort_by = valid_sort_by(params)
    sort_order = valid_sort_order(params)
    page = param_to_integer(params["page"], 1)
    per_page = param_to_integer(params["per_page"], 5)

    options = %{
      sort_by: sort_by,
      sort_order: sort_order,
      per_page: per_page,
      page: page
    }

    pizza_orders = PizzaOrders.list_pizza_orders(options)

    socket = assign(socket, pizza_orders: pizza_orders, options: options)

    {:noreply, socket}
  end


  def handle_event("select-per-page", %{"per-page" => per_page}, socket) do
    params = %{socket.assigns.options | per_page: per_page}

    socket = push_patch(socket, to: ~p"/pizza-orders/?#{params}")

    {:noreply, socket}
  end


  attr :sort_by, :atom, required: true
  attr :options, :map, required: true
  slot :inner_block, required: true

  def sort_link(assigns) do
    params = %{
      sort_by: assigns.sort_by,
      sort_order: next_sort_order(assigns.options)
    }

    assigns = assign(assigns, params: params)
    ~H"""
    <.link patch={~p"/pizza-orders?#{@params}"}>
      <%= render_slot(@inner_block) %>
      <%= sort_indicator(@sort_by, @options) %>
    </.link>
    """
  end


  defp sort_indicator(column, %{sort_by: sort_by, sort_order: sort_order}) when column == sort_by do
    case sort_order do
      :asc -> "☝🏼"
      :desc -> "👇🏼"
    end
  end


  defp sort_indicator(_, _), do: ""


  defp next_sort_order(options) do
    case options.sort_order do
      :asc -> :desc
      :desc -> :asc
    end
  end


  defp valid_sort_by(%{"sort_by" => sort_by}) when sort_by in ~w(id size style topping_1 topping_2 price) do
    String.to_atom(sort_by)
  end


  defp valid_sort_by(_params), do: :id


  defp valid_sort_order(%{"sort_order" => sort_order}) when sort_order in ~w(asc desc) do
    String.to_atom(sort_order)
  end


  defp valid_sort_order(_params), do: :asc


  defp param_to_integer(nil, default), do: default

  defp param_to_integer(param, default) do
    case Integer.parse(param) do
      {number, _} ->
        number

      :error ->
        default
    end
  end

end
