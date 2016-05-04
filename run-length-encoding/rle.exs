defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "HORSE" => "1H1O1R1S1E"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "1H1O1R1S1E" => "HORSE"
  """
  @spec encode(String.t) :: String.t
  def encode(string) do
    string
    |> to_char_list
    |> do_encode(1, [])
    |> Enum.join
  end

  defp do_encode([],_,acc) do
    acc
  end
  defp do_encode([head1,head1 | tail], counter, acc) do
    do_encode([head1 | tail], counter + 1, acc)
  end
  defp do_encode([head | tail], counter, acc) do
    acc = acc ++ [to_string(counter), to_string([head])]
    do_encode(tail, 1, acc)
  end

  @spec decode(String.t) :: String.t
  def decode(string) do
    string
    |> to_char_list
    |> do_decode([],"")
  end
  defp do_decode([],_,string_acc) do
    string_acc
  end
  defp do_decode([head | tail], num_acc, string_acc) when head in ?1..?9 do
    do_decode(tail, num_acc ++ [head], string_acc)
  end
  defp do_decode([head | tail], num_acc, string_acc) do
    times = num_acc
    |> to_string
    |> String.to_integer
    IO.puts times
    string_acc = Enum.reduce(1..times, string_acc, fn(_num, acc) ->
      acc <> to_string([head])
    end)

    do_decode(tail, [], string_acc)
  end
end
