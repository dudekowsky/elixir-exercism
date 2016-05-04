defmodule Queens do
  @type t :: %Queens{ black: {integer, integer}, white: {integer, integer} }
  defstruct black: nil, white: nil

  @doc """
  Creates a new set of Queens
  """
  @spec new(nil | list) :: Queens.t()
  def new(white \\ {0,3}, black \\ {7,3})
  def new(same, same), do: raise ArgumentError, message: "cannot occupy same space"
  def new(white, black) do
    %Queens{black: black, white: white}
  end

  @doc """
  Gives a string reprentation of the board with
  white and black queen locations shown
  """
  @spec to_string(Queens.t()) :: String.t()
  def to_string(queens) do
    black = Map.get(queens, :black)
    white = Map.get(queens, :white)
    0..63
    |> Enum.map(fn square ->
      base =
      case coord(square) do
        ^black -> "B"
        ^white -> "W"
        _          -> "_"
      end
      whitespace =
      case coord(square) do
        {7,7} -> ""
        {_,7} -> "\n"
        _     -> " "
      end
      base <> whitespace
    end)
    |>Enum.join
  end

  defp coord(int) do
    {div(int, 8), rem(int, 8)}
  end

  @doc """
  Checks if the queens can attack each other
  """
  @spec can_attack?(Queens.t()) :: boolean
  def can_attack?(queens) do
   {by, bx} = Map.get(queens, :black)
   {wy, wx} = Map.get(queens, :white)
   case {abs(wy - by), abs(wx - bx)} do
     {0,_}  -> true
     {_,0}  -> true
     {a,a}  -> true
     _      -> false
   end
  end
end
