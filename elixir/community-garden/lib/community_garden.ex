defmodule Plot do
  @enforce_keys [:plot_id, :registered_to]
  defstruct [:plot_id, :registered_to]
end

defmodule CommunityGarden do
  def start(opts \\ []) do
    Agent.start(fn -> {1, opts} end)
  end

  def list_registrations(pid) do
    Agent.get(pid, fn {_, plots} -> plots end)
  end

  def register(pid, register_to) do
    count = Agent.get(pid, fn {count, _} -> count end)
    plot = %Plot{plot_id: count, registered_to: register_to}
    Agent.update(pid, fn {count, plots} -> {count + 1, [plot | plots]} end)
    plot
  end

  def release(pid, plot_id) do
    Agent.update(pid, fn {count, plots} ->
      {count, Enum.filter(plots, fn plot -> plot.plot_id != plot_id end)}
    end)
  end

  def get_registration(pid, plot_id) do
    not_found = {:not_found, "plot is unregistered"}
    Agent.get(pid, fn {_, plots} ->
      Enum.find(plots, not_found, fn plot -> plot.plot_id == plot_id end)
    end)
  end
end
