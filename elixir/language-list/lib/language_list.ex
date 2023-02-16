defmodule LanguageList do
  def new(), do: []
  def add(list, language), do: [language | list]
  def remove([_ | rest]), do: rest
  def first([first | _]), do: first
  def count(list), do: length list
  def functional_list?(list), do: "Elixir" in list
end
