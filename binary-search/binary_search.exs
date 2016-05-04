defmodule BinarySearch do
  @doc """
    Searches for a key in the list using the binary search algorithm.
    It returns :not_found if the key is not in the list.
    Otherwise returns the tuple {:ok, index}.

    ## Examples

      iex> BinarySearch.search([], 2)
      :not_found

      iex> BinarySearch.search([1, 3, 5], 2)
      :not_found

      iex> BinarySearch.search([1, 3, 5], 5)
      {:ok, 2}

  """

  @spec search(Enumerable.t, integer) :: {:ok, integer} | :not_found
  def search(list, key) do
    if list != Enum.sort(list), do: raise ArgumentError, "expected list to be sorted"
    half = list |> length |> div(2)
    do_search(list, key, half )
  end
  defp do_search([], _,_), do: :not_found
  defp do_search(list, key, pos_acc) do
    half = div(length(list), 2)
    {lower, [head | higher] } = Enum.split(list, half)
    step_downwards = lower |> length |> Kernel./(2) |> Float.ceil |> trunc
    step_upwards = higher |> length |> Kernel./(2) |> Float.ceil |> trunc |> Kernel.+(1)
    cond do
      head == key -> {:ok, pos_acc}
      head > key  -> do_search(lower, key, pos_acc - step_downwards)
      head < key  -> do_search(higher, key, pos_acc + step_upwards)
    end

  end
end
