defmodule Acronym do
  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  @spec abbreviate(string) :: String.t()
  def abbreviate(string) do
    string
    |> String.split
    |> Enum.map(&do_filter/1)
    |> Enum.map(fn char -> String.upcase(to_string([char])) end)
    |> Enum.join
  end
  def do_filter(string) do
    [head | tail ] = string |> to_char_list
    rest = tail
    |> Enum.filter(fn char ->
      :string.to_lower([char]) != [char] && :string.to_upper([char]) == [char]
    end)
    [head | rest]
  end
