defmodule LiveViewStudioWeb.VolunteerForm do
  use LiveViewStudioWeb, :live_component

  alias LiveViewStudio.Volunteers
  alias LiveViewStudio.Volunteers.Volunteer

  def mount(socket) do
    changeset = Volunteers.change_volunteer(%Volunteer{})

    {:ok, assign(socket, form: to_form(changeset))}
  end

  def update(assigns, socket) do
    socket =
      socket
      |>assign(assigns)
      |>assign(:count, assigns.count + 1)

    {:ok, socket}
  end


  def render(assigns) do
    ~H"""
    <div>
      <div class="count">
        Go for it! You'll be volunteer #<%= @count %>
      </div>
      <.form for={@form} phx-submit="save" phx-change="update-form" phx-target={@myself}>
        <.input field={@form[:name]} placeholder="Name" autocomplete="off" phx-debounce="2000" />
        <.input field={@form[:phone]} placeholder="Phone" type="tel" phx-debounce="2000" />
        <.button phx-disable-with="Saving...">
          Check In
        </.button>
      </.form>
    </div>
    """
  end


  def handle_event("update-form", %{"volunteer" => volunteer_params}, socket) do
    changeset =
      %Volunteer{}
      |> Volunteers.change_volunteer(volunteer_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :form, to_form(changeset))}
  end


  def handle_event("save", %{"volunteer" => volunteer_params}, socket) do

    case Volunteers.create_volunteer(volunteer_params) do
      {:ok, _volunteer} ->

        socket = put_flash(socket, :info, "Volunteer successfully checked in!")

        changeset = Volunteers.change_volunteer(%Volunteer{})

        {:noreply, assign(socket, :form, to_form(changeset))}

      {:error, changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end

  end

end
