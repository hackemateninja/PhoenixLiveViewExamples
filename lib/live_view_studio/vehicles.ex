defmodule LiveViewStudio.Vehicles do
  def search(make_or_model) do
    list_vehicles()
    |> Enum.filter(
      &String.contains?(
        String.downcase(&1.make_model),
        String.downcase(make_or_model)
      )
    )
  end

  def suggest(""), do: []

  def suggest(prefix) do
    list_vehicles()
    |> Enum.map(& &1.make_model)
    |> Enum.uniq()
    |> Enum.filter(&has_prefix?(&1, prefix))
  end

  defp has_prefix?(make, prefix) do
    String.downcase(make)
    |> String.starts_with?(String.downcase(prefix))
  end

  def list_vehicles do
    [
      %{
        make_model: "Toyota Camry",
        color: "Gold",
        status: :new
      },
      %{
        make_model: "Toyota 4-Runner",
        color: "White",
        status: :used
      },
      %{
        make_model: "Toyota Prius",
        color: "Green",
        status: :new
      },
      %{
        make_model: "Ford F-150",
        color: "Black",
        status: :used
      },
      %{
        make_model: "Ford Mustang",
        color: "Yellow",
        status: :new
      },
      %{
        make_model: "Ford Bronco",
        color: "Blue",
        status: :used
      },
      %{
        make_model: "Ford Focus",
        color: "Red",
        status: :used
      },
      %{
        make_model: "Chevy Silverado",
        color: "Red",
        status: :used
      },
      %{
        make_model: "Chevy Malibu",
        color: "Blue",
        status: :used
      },
      %{
        make_model: "Chevy Blazer EV",
        color: "Green",
        status: :new
      },
      %{
        make_model: "Buick Enclave",
        color: "Silver",
        status: :used
      },
      %{
        make_model: "Buick Regal",
        color: "Gold",
        status: :new
      },
      %{
        make_model: "Dodge Durango",
        color: "Blue",
        status: :new
      },
      %{
        make_model: "Dodge Ram",
        color: "Black",
        status: :used
      },
      %{
        make_model: "Dodge Charger",
        color: "Orange",
        status: :new
      },
      %{
        make_model: "Honda CR-V",
        color: "Red",
        status: :new
      },
      %{
        make_model: "Honda Accord",
        color: "Blue",
        status: :new
      },
      %{
        make_model: "Honda Civic",
        color: "Silver",
        status: :used
      },
      %{
        make_model: "Honda Pilot",
        color: "White",
        status: :used
      }
    ]
  end
end
