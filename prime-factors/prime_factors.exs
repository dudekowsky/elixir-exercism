defmodule PrimeFactors do
  @doc """
  Compute the prime factors for 'number'.

  The prime factors are prime numbers that when multiplied give the desired
  number.

  The prime factors of 'number' will be ordered lowest to highest.
  """
  @spec factors_for(pos_integer) :: [pos_integer]
  def factors_for(number) do
    do_factors_for(number, 2)
  end

  def do_factors_for(1,_), do: []
  def do_factors_for(num, testnumber) do
    case rem(num, testnumber) do
      0 -> [testnumber | do_factors_for(div(num, testnumber), 2)]
      _ -> do_factors_for(num, testnumber + 1)
    end
  end
end
