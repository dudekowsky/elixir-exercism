defmodule Minesweeper do

  @doc """
  Annotate empty spots next to mines with the number of mines next to them.
  """
  @spec annotate([String.t]) :: [String.t]
  # Go through board with indices, and for every mine count up a value
  #  in a map with a tuple of coordinates as keys. Then write everywhere the
  # corresponding number, if it is no mine and above zero.
  def annotate([]), do: []
  def annotate(board) do
    board = board |> Enum.map(&to_char_list/1)
    height = length(board)
    width = board |> hd |> length
    counter_map = for x <- 0..(width - 1), y <- 0..(height - 1) do
      field = board
      |> Enum.at(y)
      |> Enum.at(x)
      case field do
        ?* ->
          [ {x + 1, y + 1},{x, y + 1}, {x - 1, y + 1},
            {x + 1, y},                {x - 1, y},
            {x + 1, y - 1},{x, y - 1}, {x - 1, y - 1}
          ]
        _ -> []
      end
    end
    |> List.flatten
    |> Enum.reduce(Map.new, fn coord, map ->
      Map.update(map, coord, 1, &(&1 + 1))
    end)
    |> Map.to_list
    |> Enum.filter(fn {{x,y},_} -> 0 <= x and x < width && 0 <= y and y < height end)
    |> Enum.reduce(board, fn {{x,y}, val}, board ->
      field = board |> Enum.at(y) |> Enum.at(x)
      cond do
        field == ?* -> board
        val   == 0  -> board
        true  ->
          row = Enum.at(board, y)
          row = List.replace_at(row, x, to_char_list(val))
          List.replace_at(board, y, row)
      end
    end)
    |> Enum.map(&to_string/1)
  end
end
