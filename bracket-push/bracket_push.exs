defmodule BracketPush do
  @doc """
  Checks that all the brackets and braces in the string are matched correctly, and nested correctly
  """
  @spec check_brackets(String.t) :: boolean
  def check_brackets(str) do
    str
    |> to_char_list
    # |> do_check_brackets(0,0,0)
    |> do_check_brackets([])
  end
  defp do_check_brackets([],[]), do: true
  defp do_check_brackets([],_),  do: false

  defp do_check_brackets([head | tail], heap) when head in '{([' do
    do_check_brackets(tail, [head|heap])
  end
  defp do_check_brackets([head | tail], [headheap | tailheap]) when head in '})]' do
    case [headheap, head] do
      '[]' -> do_check_brackets(tail, tailheap)
      '{}' -> do_check_brackets(tail, tailheap)
      '()' -> do_check_brackets(tail, tailheap)
      _    -> false
    end
  end
  defp do_check_brackets([_head | tail], heap), do: do_check_brackets(tail, heap)
end
