defmodule Triplet do

  @doc """
  Calculates sum of a given triplet of integers.
  """
  @spec sum([non_neg_integer]) :: non_neg_integer
  def sum(triplet) do
    Enum.sum(triplet)
  end

  @doc """
  Calculates product of a given triplet of integers.
  """
  @spec product([non_neg_integer]) :: non_neg_integer
  def product(triplet) do
    triplet
    |> Enum.reduce(fn x, acc -> x * acc end)
  end

  @doc """
  Determines if a given triplet is pythagorean. That is, do the squares of a and b add up to the square of c?
  """
  @spec pythagorean?([non_neg_integer]) :: boolean
  def pythagorean?(triplet ) do
    [a,b,c] = Enum.sort(triplet)
    (a*a + b*b) == c*c
  end

  @doc """
  Generates a list of pythagorean triplets from a given min (or 1 if no min) to a given max.
  """
  @spec generate(non_neg_integer, non_neg_integer) :: [list(non_neg_integer)]
  def generate(min, max) do
    for a <- min..max,
        b <- min..max,
        c <- min..max,
        a > b, b > c,
        pythagorean?([a,b,c]),
        do: [a,b,c]
  end

  @doc """
  Generates a list of pythagorean triplets from a given min to a given max, whose values add up to a given sum.
  """
  @spec generate(non_neg_integer, non_neg_integer, non_neg_integer) :: [list(non_neg_integer)]
  def generate(min, max, sum) do
    for a <- min..max,
        b <- min..max,
        c <- min..max,
        c > b, b > a,
        pythagorean?([a,b,c]),
        a + b + c == sum,
        do: [a,b,c]
  end
end
