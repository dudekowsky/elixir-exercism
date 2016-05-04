defmodule Accumulate do
  @doc """
    Given a list and a function, apply the function to each list item and
    replace it with the function's return value.

    Returns a list.

    ## Examples

      iex> Accumulate.accumulate([], fn(x) -> x * 2 end)
      []

      iex> Accumulate.accumulate([1, 2, 3], fn(x) -> x * 2 end)
      [2, 4, 6]

  """

  @spec accumulate(Enumerable.t, (any -> any)) :: list
  def accumulate(list, fun) do
    do_accumulate(list, fun, [])
  end
  def do_accumulate([], _fun, acc_list) do
    Enum.reverse acc_list
  end

  def do_accumulate([head | tail], fun, acc_list) do
    do_accumulate(tail, fun, [fun.(head) | acc_list])
  end
end
