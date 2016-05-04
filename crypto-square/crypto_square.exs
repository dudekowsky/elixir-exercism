defmodule CryptoSquare do
  @doc """
  Encode string square methods
  ## Examples

    iex> CryptoSquare.encode("abcd")
    "ac bd"
  """
  @spec encode(String.t) :: String.t
  def encode(str) do
    str = str
    |> String.downcase
    |> to_char_list
    |> Enum.filter(fn char_num -> char_num in ?a..?z or char_num in ?0..?9 end)
    square_length = :math.sqrt(length(str)) |> Float.ceil |> round
    square(str,0,square_length)
    |> to_string
    |> String.strip
  end

  def square(char_list, counter, square_length) when counter < square_length do
    row =
    char_list
    |> Enum.drop(counter)
    |> Enum.take_every(square_length)
    row ++ [32] ++ square(char_list, counter + 1, square_length)
  end

  def square(_,_,_) do
    []
  end
end

CryptoSquare.encode("This is easy")
|> IO.inspect
