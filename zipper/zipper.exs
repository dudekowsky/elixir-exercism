defmodule BinTree do
  @moduledoc """
  A node in a binary tree.

  `value` is the value of a node.
  `left` is the left subtree (nil if no subtree).
  `right` is the right subtree (nil if no subtree).
  """
  @type t :: %BinTree{ value: any, left: BinTree.t | nil, right: BinTree.t | nil }
  defstruct value: nil, left: nil, right: nil
end
# I admit: I did not come up with this, but had to look up much of the solution.
# The zipper structure is actually not
# that hard once you get the hang of it, but it is pretty hard to understand
# by just reading the task. Guess here you see that I do not have a CS degree.
defmodule Zipper do
  @type t :: %Zipper{ focus: BinTree.t, history: List.t }
  defstruct focus: nil, history: []
  @doc """
  Get a zipper focused on the root node.
  """

  alias Zipper, as: Z

  @spec from_tree(BT.t) :: Z.t
  def from_tree(bt) do
    %Z{ focus: bt }
  end

  @doc """
  Get the complete tree from a zipper.
  """
  @spec to_tree(Z.t) :: BT.t
  def to_tree(%Z{ focus: bt, history: [] }), do: bt
  def to_tree(zipper) do
    zipper
    |> up
    |> to_tree
  end

  @doc """
  Get the value of the focus node.
  """
  @spec value(Z.t) :: any
  def value(%Z{ focus: %{ value: v }}), do: v
  def value(_), do: nil

  @doc """
  Get the left child of the focus node, if any.
  """
  @spec left(Z.t) :: Z.t | nil
  def left(z), do: get(z, :left)

  @doc """
  Get the right child of the focus node, if any.
  """
  @spec right(Z.t) :: Z.t | nil
  def right(z), do: get(z, :right)

  @doc """
  Get the parent of the focus node, if any.
  """
  @spec up(Z.t) :: Z.t
  def up(%Z{ focus: bt, history: [] }) do
    nil
  end
  def up(%Z{ focus: bt, history: [{direction, h}|hs] }) do
    %Z{ history: hs, focus: Map.put(h, direction, bt) }
  end

  @doc """
  Set the value of the focus node.
  """
  @spec set_value(Z.t, any) :: Z.t
  def set_value(z, v), do: put(z, v, :value)

  @doc """
  Replace the left child tree of the focus node.
  """
  @spec set_left(Z.t, BT.t) :: Z.t
  def set_left(z, l), do: put(z, l, :left)

  @doc """
  Replace the right child tree of the focus node.
  """
  @spec set_right(Z.t, BT.t) :: Z.t
  def set_right(z, r), do: put(z, r, :right)

  defp put(%Z{ focus: bt } = z, value, position) do
    %{ z | focus: Map.put(bt, position, value) }
  end

  defp get(%Z{ focus: bt, history: h }, direction) do
    case Map.pop(bt, direction) do
      { nil, _ } -> nil
      { v, new } -> %Z{ focus: v, history: [{ direction, new } | h ] }
    end
  end
end
