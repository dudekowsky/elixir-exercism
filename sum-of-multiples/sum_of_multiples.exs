defmodule SumOfMultiples do
  @doc """
  Adds up all numbers from 1 to a given end number that are multiples of the factors provided.
  """
  @spec to(non_neg_integer, [non_neg_integer]) :: non_neg_integer
  def to(_limit, factors \\ [3,5], _acc \\ nil)
  def to(0, _, acc), do: acc
  def to(limit, factors, nil) do
    to(limit - 1, factors, 0)
  end
  def to(limit, factors, acc) do
    if Enum.any?(factors, fn factor -> rem(limit, factor) == 0 end) do
      to(limit - 1, factors, acc + limit)
    else
      to(limit - 1, factors, acc)
    end
  end
end
