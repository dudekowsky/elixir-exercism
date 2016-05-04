defmodule RailFenceCipher do
  @doc """
  Encode a given plaintext to the corresponding rail fence ciphertext
  """
  @spec encode(String.t, pos_integer) :: String.t
  # I start counting the rails at 0, so if I have 4 rails, i have rail0 to rail3
  # for every rail the letters you take are: starting at (rail)th letter
  # then current position + rails - rail, then current position plus rail.
  # You take nothing if either of those values is zero.

  def encode(str, rails) do
    period = max((rails - 1) * 2, 1)
    ch_list = to_char_list(str)
    0..(rails - 1)
    |> Enum.map(fn rail ->
      list1 = ch_list
      |> Enum.drop(rail)
      |> Enum.take_every(period)
      list2 = ch_list
      |> Enum.drop(period - rail)
      |> Enum.take_every(period)
      rail_merger(list1, list2)
      |> to_string
    end)
    |> List.to_string
  end
  def rail_merger(list, list), do: list
  def rail_merger([head | list], list), do: [head |list]
  def rail_merger(list1, list2) do
    case [list1, list2] do
      [[head1 | tail1], [head2 | tail2]] -> [head1,head2 | rail_merger(tail1,tail2)]
      [[],list]                          -> list
      [list,[]]                          -> list
    end
  end

  @doc """
  Decode a given rail fence ciphertext to the corresponding plaintext
  """
  @spec decode(String.t, pos_integer) :: String.t
  def decode(str, rails) do
    str_length = String.length(str)
    period = max(1, (rails - 1) * 2)
    ch_list = to_char_list(str)
    0..(rails - 1)
    |> Enum.reduce({Map.new, ch_list}, fn x, {map, rem_ch_list} ->
      cond do
        x == 0 ->
          take_count = trunc((str_length + period - 1)/period)
          {output_map,_} = rem_ch_list
          |> Enum.take(take_count)
          |> Enum.reduce({map, 0}, fn char, {temp_map, counter} ->
            {Map.put(temp_map, counter * period, [char]), counter + 1}
          end)
          {output_map, Enum.drop(rem_ch_list, take_count)}

        x < rails - 1 ->
          take_count = trunc(2 *( str_length  + (x / 2) - 1 ) / period +
          cond do
            (rem(str_length - period, period)) > (2*x - 1) -> 1
            true                               -> 0
          end)
          {output_map1,_} = rem_ch_list
          |> Enum.take(take_count)
          |> Enum.take_every(2)
          |> Enum.reduce({map, 0}, fn char, {temp_map, counter} ->
            {Map.put(temp_map, counter * period + x, [char]), counter + 1}
          end)
          {output_map2,_} = rem_ch_list
          |> Enum.take(take_count)
          |> Enum.drop(1)
          |> Enum.take_every(2)
          |> Enum.reduce({map, 1}, fn char, {temp_map, counter} ->
            {Map.put(temp_map, counter * period - x, [char]), counter + 1}
          end)
          {Map.merge(output_map2, output_map1), Enum.drop(rem_ch_list, take_count)}

        x == rails - 1 ->
          {output_map, _} = rem_ch_list
          |> Enum.reduce({map, 0}, fn char, {temp_map, counter} ->
            {Map.put(temp_map, counter * period + x, [char]), counter + 1}
          end)
          {output_map, []}
        true ->
          raise RuntimeError, "somewhere, something went horribly wrong"
      end
    end)
    |> elem(0)
    |> Map.to_list
    |> Enum.sort
    |> Enum.map(fn x -> elem(x,1) end)
    |> List.to_string
  end
end
