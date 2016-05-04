defmodule ListOps do
  # Please don't use any external modules (especially List) in your
  # implementation. The point of this exercise is to create these basic functions
  # yourself.
  #
  # Note that `++` is a function from an external module (Kernel, which is
  # automatically imported) and so shouldn't be used either.

  @spec count(list) :: non_neg_integer
  def count(l) do
    do_count(l, 0)
  end
  defp do_count([], acc) do
    acc
  end
  defp do_count([_head | tail], acc) do
    do_count(tail, acc + 1)
  end

  @spec reverse(list) :: list
  def reverse(l) do
    do_reverse(l, [])
  end

  defp do_reverse([], acc) do
    acc
  end

  defp do_reverse([head | tail], acc) do
    do_reverse(tail, [head | acc])
  end

  @spec map(list, (any -> any)) :: list
  def map(l, f) do
    do_map(l, f, [])
    |> reverse
  end

  def do_map([], _, acc), do: acc

  def do_map([head | tail], func, acc) do
    do_map(tail, func, [func.(head) | acc] )
  end


  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter(l, f) do
    do_filter(l, f, [])
    |> reverse
  end
  def do_filter([],_,acc), do: acc
  def do_filter([head | tail], func, acc) do
    case func.(head) do
      true  -> do_filter(tail, func, [head | acc])
      false -> do_filter(tail, func, acc)
    end
  end

  @type acc :: any
  @spec reduce(list, acc, ((any, acc) -> acc)) :: acc
  def reduce(l, acc, f) do
    do_reduce(l, acc, f)
  end

  defp do_reduce([],acc,_) do
    acc
  end
  defp do_reduce([head | tail], acc, func) do
    do_reduce(tail, func.(head, acc) , func)
  end

  @spec append(list, list) :: list
  def append(a, b) do
    a ++ b
  end

  @spec concat([[any]]) :: [any]
  def concat(ll) do
    ll
    |> reverse
    |> reduce([], &append/2)
  end
end
