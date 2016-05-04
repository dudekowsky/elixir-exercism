defmodule Scrabble do
  @doc """
  Calculate the scrabble score for the word.
  """
  @spec score(String.t) :: non_neg_integer
  def score(word) do
    points_map = parse_points("A, E, I, O, U, L, N, R, S, T       1
    D, G                               2
    B, C, M, P                         3
    F, H, V, W, Y                      4
    K                                  5
    J, X                               8
    Q, Z                               10")
    word
    |> String.upcase
    |> String.split("")
    |> Enum.map(fn letter -> Map.get(points_map, letter, 0) end)
    |> Enum.sum
  end
  defp parse_points(string) do
    {map, _} = string
    |> String.replace(",","")
    |> String.split()
    |> Enum.reduce({Map.new, []}, fn(char, {map, char_acc}) ->
      cond do
        Regex.match?(~r/\D/, char) ->
          {map, [char | char_acc]}
        true -> {Enum.reduce(char_acc, map, fn x, acc -> Map.put(acc, x, String.to_integer(char)) end), []}
      end
    end)

    map
  end
end
