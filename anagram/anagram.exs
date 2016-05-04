defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t, [String.t]) :: [String.t]
  def match(base, candidates) do
    candidates
    |> Enum.filter(fn candidate ->
      if String.upcase(candidate) == String.upcase(base) do
        false
      else
      candidate
        |> String.upcase
        |> to_char_list
        |> Enum.sort
        ==
        base
        |> String.upcase
        |> to_char_list
        |> Enum.sort
      end
    end)
    |> Enum.uniq
  end
end
