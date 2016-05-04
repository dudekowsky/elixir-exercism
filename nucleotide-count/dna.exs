defmodule DNA do
  @nucleotides [?A, ?C, ?G, ?T]

  @doc """
  Counts individual nucleotides in a DNA strand.

  ## Examples

  iex> DNA.count('AATAA', ?A)
  4

  iex> DNA.count('AATAA', ?T)
  1
  """
  @spec count([char], char) :: non_neg_integer
  def count(strand, nucleotide) when nucleotide in @nucleotides do
    if is_strand(strand) do
      strand
      |> Enum.filter(fn char -> char == nucleotide end)
      |> Enum.count
    end
  end
  def count(_,_) do
    raise ArgumentError, message: "not nucleotide"
  end

  @doc """
  Returns a summary of counts by nucleotide.

  ## Examples

  iex> DNA.histogram('AATAA')
  %{?A => 4, ?T => 1, ?C => 0, ?G => 0}
  """
  @spec histogram([char]) :: map
  def histogram(strand) do
    if is_strand(strand) do
      do_histogram(strand, %{?A => 0, ?C => 0, ?G => 0, ?T => 0})
    end
  end
  defp do_histogram([],map) do
    map
  end
  defp do_histogram([head | tail], map) do
    do_histogram(tail, Map.update(map, head, 1, &(&1 + 1)))
  end
end

defp is_strand(strand) do
  if ((strand |> Enum.filter(fn char -> char in @nucleotides end)) != strand ) do
    raise ArgumentError, message: "no valid strand"
  else
    true
  end
end
