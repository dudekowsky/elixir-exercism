defmodule Bob do
  def hey(input) do
    input = String.strip input
    upcased = String.upcase(input)
    downcased = String.downcase(input)
    last_char = input |> String.last
    cond do
      last_char == "?"      -> "Sure."
      input == ""           -> "Fine. Be that way!"
      input == upcased and input != downcased    -> "Whoa, chill out!"
      true                  -> "Whatever."
    end
  end
end
