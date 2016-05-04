defmodule Matrix do
  @doc """
  Parses a string representation of a matrix
  to a list of rows
  """
  @spec rows(String.t()) :: [[integer]]
  def rows(str) do
    String.split(str, "\n")
    |> Enum.map(fn string ->
      string
      |> String.split
      |> Enum.map(&String.to_integer/1)
    end)
  end

  @doc """
  Parses a string representation of a matrix
  to a list of columns
  """
  @spec columns(String.t()) :: [[integer]]
  def columns(str) do
    row_count = Enum.count(rows(str))
    splitted = str |> String.split
    total_count = splitted |> Enum.count
    col_count = div(total_count, row_count)
    1..div(total_count, row_count)
    |> Enum.map(fn n ->
      extract_nth_column(n, splitted, col_count)
    end)
  end

  defp extract_nth_column(1, splitted, row_count) do
    Enum.take_every(splitted, row_count )
    |> Enum.map(&String.to_integer/1)
  end
  defp extract_nth_column(n, [_head | tail], row_count) do
    extract_nth_column(n - 1, tail, row_count)
  end

  @doc """
  Calculates all the saddle points from a string
  representation of a matrix
  """
  @spec saddle_points(String.t()) :: [{integer, integer}]
  def saddle_points(str) do
    cols = columns(str)
    rows  = rows(str)
    for x <- 0..(length(rows) - 1), y <- 0..(length(cols) -1 ), is_saddle?(x,y,cols, rows) do
      {x,y}
    end
  end
  defp is_saddle?(x,y,cols,rows) do
    val = Enum.at(cols, y) |> Enum.at(x)
    max_of_row = Enum.at(rows, x) |> Enum.max
    min_of_col = Enum.at(cols, y) |> Enum.min
    val == max_of_row && val == min_of_col
  end
end
