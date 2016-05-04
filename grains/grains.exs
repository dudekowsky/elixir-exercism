defmodule Grains do
  @doc """
  Calculate two to the power of the input minus one.
  """
  @spec square(pos_integer) :: pos_integer
  def square(number) do
    1..number
    |> Enum.reduce(1, fn _, acc ->
      2*acc
    end)
    |> div(2)
  end

  @doc """
  Adds square of each number from 1 to 64.
  """
  @spec total :: pos_integer
  def total do
    1..64
    |> Enum.reduce(0, fn x, acc ->
      square(x) + acc
    end)
  end
end
