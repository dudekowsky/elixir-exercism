defmodule Allergies do
  @all_bins %{1 => "eggs", 2 => "peanuts", 4 => "shellfish", 8 => "strawberries", 16 => "tomatoes", 32 => "chocolate",
    64 => "pollen", 128 => "cats"}
  @doc """
  List the allergies for which the corresponding flag bit is true.
  """
  @spec list(non_neg_integer) :: [String.t]
  def list(flags) do
    flags = rem(flags, 256)
    {output, _} =
    (7..0)
    |> Enum.map(fn x -> :math.pow(2,x) |> trunc end)
    |> Enum.reduce({[], flags}, fn x, {acc, temp_flags} ->
      new_flags = rem(temp_flags, x)
      case div(temp_flags, x) do
        1 -> {[Map.get(@all_bins, x) | acc], new_flags}
        0 -> {acc, new_flags}
      end
    end)
    output
  end

  @doc """
  Returns whether the corresponding flag bit in 'flags' is set for the item.
  """
  @spec allergic_to?(non_neg_integer, String.t) :: boolean
  def allergic_to?(flags, item) do
    item in list(flags)
  end
end
Allergies.list(1)
|> IO.inspect
