defmodule LiveViewStudio.VolunteersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `LiveViewStudio.Volunteers` context.
  """

  @doc """
  Generate a volunteer.
  """
  def volunteer_fixture(attrs \\ %{}) do
    {:ok, volunteer} =
      attrs
      |> Enum.into(%{
        checked_out: true,
        name: "some name",
        phone: "303-555-1212"
      })
      |> LiveViewStudio.Volunteers.create_volunteer()

    volunteer
  end
end
