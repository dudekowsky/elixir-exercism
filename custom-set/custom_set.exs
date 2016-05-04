defmodule CustomSet do
  # This lets the compiler check that all Set callback functions have been
  # implemented.
  @behaviour Set

  def new(list) do
    list = list
    |> Enum.sort
    |> Enum.uniq
    |> Enum.to_list
    {CustomSet, list}
  end

  def delete({CustomSet,list}, val) do
    list = list
    |> List.delete(val)
    {CustomSet, list}
  end

  def equal?(list1, list1) do
    true
  end
  def equal?(_), do: false
end
