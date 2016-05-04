defmodule Sieve do

  @doc """
  Generates a list of primes up to a given limit.
  """
  @spec primes_to(non_neg_integer) :: [non_neg_integer]
  def primes_to(limit) do
    2..limit
    |> Enum.to_list
    |> do_primes([])
  end
  defp do_primes([], acc), do: Enum.reverse(acc)
  defp do_primes([head | tail], acc) do
    tail
    |> Enum.filter(fn x -> rem(x, head) != 0 end)
    |> do_primes([head | acc])
  end
end
