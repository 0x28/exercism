defmodule KitchenCalculator do
  def get_volume({_, volume}), do: volume

  def to_milliliter(volume_pair) do
    vol = case volume_pair do
            {:cup, vol} -> vol * 240
            {:fluid_ounce, vol} -> vol * 30
            {:milliliter, vol} -> vol
            {:teaspoon, vol} -> vol * 5
            {:tablespoon, vol} -> vol * 15
          end

    {:milliliter, vol}
  end

  def from_milliliter(volume_pair, unit) do
    {_, ml} = to_milliliter(volume_pair)
    {_, factor} = to_milliliter({unit, 1})
    {unit, ml / factor}
  end

  def convert(volume_pair, unit) do
    volume_pair |> to_milliliter |> from_milliliter(unit)
  end
end
