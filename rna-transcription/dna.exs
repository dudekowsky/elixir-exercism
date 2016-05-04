defmodule DNA do
  @doc """
  Transcribes a character list representing DNA nucleotides to RNA

  ## Examples

  iex> DNA.to_rna('ACTG')
  'UGAC'
  """
  @spec to_rna([char]) :: [char]
  def to_rna(dna) do
    dna
    |> Enum.map(fn char ->
      case char do
        ?G -> ?C
        ?C -> ?G
        ?T -> ?A
        ?A -> ?U
        _  -> raise "not a dna char"
      end
    end)
  end
end
