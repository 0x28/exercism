defmodule LogLevel do
  def to_label(level, legacy?) do
    if legacy? and (level < 1 or level > 4) do
      :unknown
    else
      case level do
        0 -> :trace
        1 -> :debug
        2 -> :info
        3 -> :warning
        4 -> :error
        5 -> :fatal
        _ -> :unknown
      end
    end
  end

  def alert_recipient(level, legacy?) do
    label = to_label(level, legacy?)

    cond do
      label == :error or label == :fatal -> :ops
      label == :unknown and legacy? -> :dev1
      label == :unknown -> :dev2
      true -> false
    end
  end
end
