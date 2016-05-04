defmodule ETL do
  @doc """
  Transform an index into an inverted index.

  ## Examples

  iex> ETL.transform(%{"a" => ["ABILITY", "AARDVARK"], "b" => ["BALLAST", "BEAUTY"]})
  %{"ability" => "a", "aardvark" => "a", "ballast" => "b", "beauty" =>"b"}
  """
  @spec transform(map) :: map
  def transform(input) do
    input
    |> Map.keys
    |> Enum.reduce(Map.new, fn(oldkey, newmap) ->
      Map.get(input, oldkey)
      |> Enum.reduce(newmap, fn(newkey, intermediate_map) ->
        Map.put(intermediate_map, String.downcase(newkey), oldkey)
      end)
    end)
  end
end
