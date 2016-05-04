defmodule Binary do
  @doc """
  Convert a string containing a binary number to an integer.

  On errors returns 0.
  """
  @spec to_decimal(String.t) :: non_neg_integer


  def to_decimal(string) do
    if string |> to_char_list |> Enum.all?(fn x -> x in [?1,?0] end) do
      {result, _} = string
      |> String.reverse
      |> String.split("")
      |> Enum.take(String.length(string))
      |> Enum.reduce({0,0}, fn(x, {acc, pot}) ->
        {acc + String.to_integer(x) * exp(pot), pot + 1}
      end)
      result
    else
      0
    end
  end

  defp exp(0), do: 1
  defp exp(pot) do
    1..pot
    |> Enum.reduce(1, fn(_, acc) -> 2 * acc end)

  end
end
