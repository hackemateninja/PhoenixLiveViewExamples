defmodule LiveViewStudioWeb.VolunteersLive do
  use LiveViewStudioWeb, :live_view

  alias LiveViewStudio.Volunteers
  alias LiveViewStudioWeb.VolunteerForm


  def mount(_params, _session, socket) do
    volunteers = Volunteers.list_volunteers()
    if connected?(socket)do
      Volunteers.subscribe()
    end
    socket =
      socket
      |>stream(:volunteers, volunteers)
      |>assign(count: length(volunteers))

    {:ok, socket}
  end


  def render(assigns) do
    ~H"""
    <h1>Volunteer Check-In</h1>
    <div id="volunteer-checkin">
      <.live_component module={VolunteerForm} id={:new} count={@count}/>
      <div id="volunteers" phx-update="stream">
        <.volunteer
          :for={{volunteer_id, volunteer} <- @streams.volunteers}
          id={volunteer_id}
          volunteer={volunteer}
        />
      </div>
    </div>
    """
  end


  def volunteer(assigns) do
    ~H"""
    <div
      class={"volunteer #{if @volunteer.checked_out, do: "out"}"}
      id={@id}>
        <div class="name">
          <%= @volunteer.name %>
        </div>
        <div class="phone">
          <%= @volunteer.phone %>
        </div>
        <div class="status">
          <button phx-click="toggle-status" phx-value-id={@volunteer.id}>
            <%= if @volunteer.checked_out, do: "Check In", else: "Check Out" %>
          </button>
        </div>
        <.link
          class="delete"
          phx-click="delete"
          phx-value-id={@volunteer.id}
          data-confirm="Are you sure?">
          <.icon name="hero-trash-solid" />
        </.link>
    </div>
    """
  end


  def handle_event("delete",%{"id" => id}, socket) do
    volunteer = Volunteers.get_volunteer!(id)
    {:ok, _} = Volunteers.delete_volunteer(volunteer)
    {:noreply, socket}
  end


  def handle_event("toggle-status", %{"id" => id}, socket) do
    volunteer = Volunteers.get_volunteer!(id)

    {:ok, _volunteer} = Volunteers.update_volunteer(volunteer, %{checked_out: !volunteer.checked_out})

    {:noreply, socket}
  end


  def handle_info({:volunteer_created, volunteer}, socket) do
    socket = update(socket, :count, &(&1 +1))
    {:noreply, stream_insert(socket, :volunteers, volunteer, at: 0)}
  end

  def handle_info({:volunteer_updated, volunteer}, socket) do
    {:noreply, stream_insert(socket, :volunteers, volunteer)}
  end

  def handle_info({:volunteer_deleted, volunteer}, socket) do
    socket = update(socket, :count, &(&1 - 1))
    {:noreply, stream_delete(socket, :volunteers, volunteer)}
  end

end
