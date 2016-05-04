defmodule Series do

  @doc """
  Finds the largest product of a given number of consecutive numbers in a given string of numbers.
  """
  @spec largest_product(String.t, non_neg_integer) :: non_neg_integer
  def largest_product(_, 0), do: 1
  def largest_product(number_string, size) when byte_size(number_string) >= size and size > 0 do
    number_string
    |> String.split("")
    |> Enum.filter(fn x -> x != "" end)
    |> Enum.map(&String.to_integer/1)
    |> do_find_largest_product(size, 0)
  end
  def largest_product(_, _) do
    raise ArgumentError
  end
  defp do_find_largest_product([_head | tail] = numlist, size, current_max) when length(numlist) >= size do
    prod = Enum.take(numlist, size)
    |> Enum.reduce(1, fn x, acc -> x * acc end)
    do_find_largest_product(tail, size, max(current_max, prod))
  end
  defp do_find_largest_product(_, _, acc), do: acc
end
