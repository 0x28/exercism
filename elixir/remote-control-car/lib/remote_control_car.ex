defmodule RemoteControlCar do
  @enforce_keys [:nickname]
  defstruct [:nickname, battery_percentage: 100, distance_driven_in_meters: 0]

  def new(nickname \\ "none"), do: %RemoteControlCar{nickname: nickname}

  def display_distance(%RemoteControlCar{} = remote_car) do
    "#{remote_car.distance_driven_in_meters} meters"
  end

  def display_battery(%RemoteControlCar{} = remote_car) do
    if remote_car.battery_percentage === 0 do
      "Battery empty"
    else
      "Battery at #{remote_car.battery_percentage}%"
    end
  end

  def drive(%RemoteControlCar{} = remote_car) when remote_car.battery_percentage > 0 do
    remote_car
    |> Map.update(:battery_percentage, 0, &(&1 - 1))
    |> Map.update(:distance_driven_in_meters, 0, &(&1 + 20))
  end
  def drive(%RemoteControlCar{} = remote_car), do: remote_car
end
