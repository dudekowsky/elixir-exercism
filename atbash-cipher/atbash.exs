defmodule Atbash do
  @doc """
  Encode a given plaintext to the corresponding ciphertext

  ## Examples

  iex> Atbash.encode("completely insecure")
  "xlnko vgvob rmhvx fiv"
  """
  @spec encode(String.t) :: String.t
  def encode(plaintext) do
    plaintext
    |> String.downcase
    |> to_char_list
    |> Enum.filter(fn x -> !(x in '?!,. ') end)
    |> Enum.map(fn x ->
      cond do
        x < ?9 and x > ?0 -> x
        true              -> ?z - x + ?a
      end
    end)
    |> Enum.reduce(["", 1], fn(char, [string, counter]) ->
      case rem(counter,5) do
      0 -> [string <> to_string([char]) <> " ", counter + 1]
      _ -> [string <> to_string([char]), counter + 1]
      end

    end)
    |> hd
    |> String.strip
  end
end
Atbash.encode("Test")
|> IO.inspect
