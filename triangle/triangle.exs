defmodule Triangle do
  @type kind :: :equilateral | :isosceles | :scalene

  @doc """
  Return the kind of triangle of a triangle with 'a', 'b' and 'c' as lengths.
  """
  @spec kind(number, number, number) :: { :ok, kind } | { :error, String.t }
  def kind(a,b,c) do
    [a,b,c] = sorted = Enum.sort([a,b,c])
    cond do
      Enum.any?(sorted, fn x -> x <= 0 end) -> {:error, "all side lengths must be positive"}
      a + b <= c                            -> {:error, "side lengths violate triangle inequality"}
      a == b and b == c                     -> {:ok, :equilateral}
      a == b                                -> {:ok, :isosceles}
      b == c                                -> {:ok, :isosceles}
      true                                  -> {:ok, :scalene}
    end
  end
end
