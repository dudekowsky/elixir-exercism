defmodule Diamond do
  @doc """
  Given a letter, it prints a diamond starting with 'A',
  with the supplied letter at the widest point.
  """
  @spec build_shape(char) :: String.t
  def build_shape(letter) do
    build_shape(letter, 0)
    |> Enum.reduce(fn line, acc ->
      line <> acc <> line
    end)
  end
  def build_shape(?A, white_acc) do
    [white(white_acc) <> "A\n"]
  end
  def build_shape(letter, white_acc) do
    width = 2*(letter - ?A) - 1
    white(width)
    line = white(white_acc) <> << letter >> <> white(width) <> << letter >> <> "\n"
    [line] ++ build_shape(letter - 1, white_acc + 1)
  end
  defp white(0), do: ""
  defp white(width) do
    1..width
    |> Enum.reduce("", fn _, acc ->
      acc <> " "
    end)
  end
end
