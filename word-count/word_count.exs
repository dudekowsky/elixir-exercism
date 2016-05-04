defmodule Words do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t) :: map
  def count(sentence) do
    sentence
    |> String.downcase
    |> String.split("_")
    |> Enum.flat_map(fn string -> string |> String.split end )
    |> Enum.map(fn string ->
      string
      |> String.strip
      |> to_char_list
      |> Enum.filter(fn x -> !(x in '!&@$%^&:,.;\\/#\"\'$\s\n\t') end)
      |> to_string
      |> String.strip
    end)
    |> Enum.filter(fn x -> x != "" end)
    |> Enum.reduce(Map.new, fn(word, map) ->
      Map.update(map, word, 1, fn x -> x + 1 end)
    end)
  end
end
