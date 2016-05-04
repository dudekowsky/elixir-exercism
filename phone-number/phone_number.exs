defmodule Phone do
  @allowed_chars '0123456789().-+# '
  @doc """
  Remove formatting from a phone number.

  Returns "0000000000" if phone number is not valid
  (10 digits or "1" followed by 10 digits)

  ## Examples

  iex> Phone.number("123-456-7890")
  "1234567890"

  iex> Phone.number("+1 (303) 555-1212")
  "3035551212"

  iex> Phone.number("867.5309")
  "0000000000"
  """
  @spec number(String.t) :: String.t
  def number(raw) do
    raw
    |> to_char_list
    |> is_valid_before_filter
    |> Enum.filter(fn char -> char in ?0..?9 end)
    |> is_valid_after_filter
    |> to_string
  end
  defp failed, do: '0000000000'

  defp is_valid_before_filter(char_list) do
    if Enum.all?(char_list, fn char -> char in @allowed_chars end) do
      char_list
    else
      failed
    end
  end

  defp is_valid_after_filter(raw) when length(raw) < 10, do: failed
  defp is_valid_after_filter([?1 | tail] = raw) when length(raw) > 10 do
    is_valid_after_filter(tail)
  end
  defp is_valid_after_filter(raw) when length(raw) > 10, do: failed
  defp is_valid_after_filter(raw) do
    raw
  end
  @doc """
  Extract the area code from a phone number

  Returns the first three digits from a phone number,
  ignoring long distance indicator

  ## Examples

  iex> Phone.area_code("123-456-7890")
  "123"

  iex> Phone.area_code("+1 (303) 555-1212")
  "303"

  iex> Phone.area_code("867.5309")
  "000"
  """
  @spec area_code(String.t) :: String.t
  def area_code(raw) do
    {code, _} = raw
    |> number
    |> String.split_at(3)
    code
  end

  @doc """
  Pretty print a phone number

  Wraps the area code in parentheses and separates
  exchange and subscriber number with a dash.

  ## Examples

  iex> Phone.pretty("123-456-7890")
  "(123) 456-7890"

  iex> Phone.pretty("+1 (303) 555-1212")
  "(303) 555-1212"

  iex> Phone.pretty("867.5309")
  "(000) 000-0000"
  """
  @spec pretty(String.t) :: String.t
  def pretty(raw) do
    [a,b,c,d,e,f,g,h,i,j] = raw
    |> number
    |> to_char_list
    "(#{[a,b,c]}) #{[d,e,f]}-#{[g,h,i,j]}"
  end
end
