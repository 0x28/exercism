defmodule GuessingGame do
  def compare(_number, guess \\ :no_guess)
  def compare(number, number), do: "Correct"
  def compare(number, guess) when abs(number - guess) === 1, do: "So close"
  def compare(_number, :no_guess), do: "Make a guess"
  def compare(number, guess) when number > guess, do: "Too low"
  def compare(number, guess) when number < guess, do: "Too high"
end
