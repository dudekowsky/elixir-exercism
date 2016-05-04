defmodule Roman do
  @doc """
  Convert the number to a roman number.
  """
  @num_map %{1 => ?I, 5 => ?V, 10 => ?X, 50 => ?L, 100 => ?C, 500 => ?D, 1000 => ?M}
  @spec numerals(pos_integer) :: String.t

  def numerals(number) do
    do_numerals(number)
  end
  defp do_numerals(0), do: ""
  defp do_numerals(number) do
    cond do
      number < 4    -> n_chars(number, "I")
      number == 4   -> "IV"
      number < 9    -> "V" <> n_chars(rem(number,5), "I")
      number == 9   -> "IX"
      number < 40   -> n_chars(div(number, 10), "X") <> do_numerals(rem(number,10))
      number < 50   -> "XL" <> do_numerals(rem(number,10))
      number < 90   -> "L" <> do_numerals(rem(number, 50))
      number < 100  -> "XC" <> do_numerals(rem(number, 10))
      number < 400  -> n_chars(div(number, 100), "C") <> do_numerals(rem(number, 100))
      number < 500  -> "CD" <> do_numerals(rem(number,100))
      number < 900  -> n_chars(div(number, 500), "D") <> do_numerals(rem(number, 500))
      number < 1000 -> "CM" <> do_numerals(rem(number, 100))
      true          -> n_chars(div(number, 1000), "M") <> do_numerals(rem(number, 1000)) 
    end
  end



  defp n_chars(n, char) do
    Enum.reduce(0..n, "", fn(counter, acc) ->
      cond do
        counter > 0 -> char <> acc
        true        -> acc
      end
    end)
  end
end
