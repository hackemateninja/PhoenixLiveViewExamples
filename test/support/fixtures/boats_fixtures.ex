defmodule LiveViewStudio.BoatsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `LiveViewStudio.Boats` context.
  """

  @doc """
  Generate a boat.
  """
  def boat_fixture(attrs \\ %{}) do
    {:ok, boat} =
      attrs
      |> Enum.into(%{
        image: "some image",
        model: "some model",
        price: "some price",
        type: "some type"
      })
      |> LiveViewStudio.Boats.create_boat()

    boat
  end
end
