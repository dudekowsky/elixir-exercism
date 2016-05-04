defmodule Roman do
  @doc """
  Convert the number to a roman number.
  """
  @num_map %{?I => 1, ?V => 5, ?X => 10, ?L => 50, ?C => 100, ?D => 500, ?M => 1000}
  @spec numerals(pos_integer) :: String.t
  def denumerals(number) do
    number
    |> to_char_list
    |> Enum.reduce({0, tl(to_char_list(number) ++ [0]), 0}, fn(char, {total, [next | tail], temporal_acc}) ->
      IO.inspect char
      temporal_acc = temporal_acc + Map.get(@num_map, char)
      cond do
        next == 0 -> total
      end
    end)

  end
end

Roman.numerals("I")
|> IO.inspect
