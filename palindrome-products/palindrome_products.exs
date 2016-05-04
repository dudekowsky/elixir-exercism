defmodule Palindromes do

  @doc """
  Generates all palindrome products from an optionally given min factor (or 1) to a given max factor.
  """
  @spec generate(non_neg_integer, non_neg_integer) :: map
  def generate(max_factor, min_factor \\ 1) do
    (for a <- min_factor..max_factor,
        b <- min_factor..max_factor,
        b <= a,
        is_pali?(a*b),
        do: [a*b, [b,a]])
    |> Enum.reduce(%{}, fn [key, val], map ->
      Map.update(map, key, [val], fn x -> [val | x] end)
    end)
  end

  defp is_pali?(num) do
    to_string(num) == num |> to_string |> String.reverse
  end
end
