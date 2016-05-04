defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """
  def compare(a, b) do
    #these tell you if a is included in b or is equal to b.
    # if it is equal, it will be caught in the cond statement
    a_is_sub = is_sublist_or_equal(a, b)
    b_is_sub = is_sublist_or_equal(b, a)
    cond do
    a == b   -> :equal
    a_is_sub -> :sublist
    b_is_sub -> :superlist
    true     -> :unequal
    end
  end

  defp is_sublist_or_equal(a, b) when length(a) > length(b), do: false
  defp is_sublist_or_equal(a, b) when a == b, do: true
  defp is_sublist_or_equal([head | taila] = a, [head | tailb]) do
    if check_series(taila, tailb) do
      true
    else
      is_sublist_or_equal(a, tailb)
    end
  end
  defp is_sublist_or_equal(a, [_head | tail]) do
    is_sublist_or_equal(a, tail)
  end
  defp check_series([], _), do: true
  defp check_series(_, []), do: false
  defp check_series([head | taila], [head | tailb]) do
    check_series(taila, tailb)
  end
  defp check_series(_,_), do: false

end
