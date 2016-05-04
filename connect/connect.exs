defmodule Connect do
  @doc """
  Calculates the winner (if any) of a board
  using "O" as the white player
  and "X" as the black player
  """
  @spec result_for([String.t]) :: :none | :black | :white

  def result_for(board) do
    board = board |> Enum.map( fn row ->
    row
    |> String.strip
    |> String.replace(" ", "")
    |> to_char_list end)
    last_y_index = length(board) - 1
    last_x_index = Enum.at(board, 0) |> length |> Kernel.-(1)
    board_map = for x <- 0..last_x_index, y <- 0..last_y_index do
      val = board |> Enum.at(y) |> Enum.at(x)
      {{y,x}, val}
    end
    |> Enum.reduce(Map.new, fn {key, val}, acc ->
      Map.put(acc, key, val)
    end)
    cond do
      black_won?(board_map, last_y_index, last_x_index)  == true -> :black
      white_won?(board_map, last_y_index, last_x_index) == true -> :white
      true                  -> :none
    end
  end
  # for each starting point:
  # look if there is a connected black field. if there is, from the connected field
  # look at a board, where the newly left field is blanked out (to prevent infinite loops)
  # and so on, to see if any connects to the right
  def black_won?(board, last_y_index, last_x_index) do
    for y <- 0..last_y_index, Map.get(board, {y,0}) == ?X do
      connected_to_right(board, { y, 0} , last_x_index, last_y_index)
    end
    |> Enum.any?(fn bool -> bool == true end)
  end
  def connected_to_right(_, {_, x}, last_x_index, _) when last_x_index == x do
    true
  end
  def connected_to_right(board, {y, x}, last_x_index, last_y_index) do
    board = Map.put(board, {y,x}, ?.)
    next_coords = adjacent_fields({y,x})
    |> Enum.filter(fn {y_co, x_co} ->
      x_co in 0..last_x_index and y_co in 0..last_y_index and
      Map.get(board, {y_co,x_co}) == ?X
    end)
    case next_coords do
      [] -> false
      _  ->
        Enum.map(next_coords, fn entry ->
          connected_to_right(board, entry, last_x_index, last_y_index)
        end)
        |> Enum.any?(fn entry -> entry == true end)
    end
  end
  def white_won?(board, last_y_index, last_x_index) do
    for x <- 0..last_x_index, Map.get(board, {0,x}) == ?O do
      connected_to_bottom(board, { 0, x} , last_x_index, last_y_index)
    end
    |> Enum.any?(fn bool -> bool == true end)
  end

  def connected_to_bottom(board, {y,x}, last_x_index, last_y_index) when last_y_index == y do
    true
  end
  def connected_to_bottom(board, {y, x}, last_x_index, last_y_index) do
    board = Map.put(board, {y,x}, ?.)
    next_coords = adjacent_fields({y,x})
    |> Enum.filter(fn {y_co, x_co} ->
      x_co in 0..last_x_index and y_co in 0..last_y_index and
      Map.get(board, {y_co,x_co}) == ?O
    end)
    case next_coords do
      [] -> false
      _  ->
        Enum.map(next_coords, fn entry ->
          connected_to_bottom(board, entry, last_x_index, last_y_index)
        end)
        |> Enum.any?(fn entry -> entry == true end)
    end
  end

  def adjacent_fields({y,x}) do
    [ {y - 1, x},     {y - 1, x + 1},
      {y, x - 1},     {y, x + 1},
      {y + 1, x - 1}, {y + 1, x}]
  end
end
