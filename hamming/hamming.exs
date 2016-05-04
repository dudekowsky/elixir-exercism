defmodule DNA do
  @doc """
  Returns number of differences between two strands of DNA, known as the Hamming Distance.

  ## Examples

  iex> DNA.hamming_distance('AAGTCATA', 'TAGCGATC')
  4
  """
  @spec hamming_distance([char], [char]) :: non_neg_integer
  def hamming_distance(strand1, strand2) do
    do_hamming(strand1, strand2, 0)
  end

  defp do_hamming(a, b, _) when length(a) != length(b), do: nil
  defp do_hamming(strand, strand, acc), do: acc

  defp do_hamming([head |tail1], [head | tail2], acc) do
    do_hamming(tail1, tail2, acc)
  end
  defp do_hamming([_ | tail1], [_ | tail2], acc) do
    do_hamming(tail1, tail2, acc + 1)
  end
end
