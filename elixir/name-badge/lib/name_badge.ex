defmodule NameBadge do
  def print(id, name, department) do
    id = if id do "[#{id}] - " else "" end
    department = if department do "#{department}" else "owner" end

    "#{id}#{name} - #{String.upcase department}"
  end
end
