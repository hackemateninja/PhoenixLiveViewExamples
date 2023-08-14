defmodule LiveViewStudio.Sandbox do
  def calculate_weight(l, w, d) do
    (to_float(l) * to_float(w) * to_float(d) * 7.3) |> Float.round(1)
  end

  def calculate_price(weight) do
    weight * 0.15
  end

  defp to_float(value) when is_binary(value) do
    case Float.parse(value) do
      {float, _} -> float
      :error -> 0.0
    end
  end

  defp to_float(value), do: value
end
