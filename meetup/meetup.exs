defmodule Meetup do
  @moduledoc """
  Calculate meetup dates.
  """

  @type weekday ::
      :monday | :tuesday | :wednesday
    | :thursday | :friday | :saturday | :sunday

  @type schedule :: :first | :second | :third | :fourth | :last | :teenth

  @doc """
  Calculate a meetup date.

  The schedule is in which week (1..4, last or "teenth") the meetup date should
  fall.
  """
  @dayname_map %{:monday => 1, :tuesday => 2, :wednesday => 3, :thursday => 4, :friday => 5, :saturday => 6, :sunday => 7}
  @spec meetup(pos_integer, pos_integer, weekday, schedule) :: :calendar.date
  def meetup(year, month, weekday, schedule) do
    range =
    case schedule do
      :teenth -> 13..19
      :first  -> 1..7
      :second -> 8..14
      :third  -> 15..21
      :fourth -> 22..28
      :last   -> (:calendar.last_day_of_the_month(year, month) - 6)..:calendar.last_day_of_the_month(year, month)
      _       -> raise ArgumentError
    end
    [only_possible_day] = range
    |> Enum.filter(fn day ->
      Map.get(@dayname_map, weekday) == :calendar.day_of_the_week({year, month, day})
    end)
    {year, month, only_possible_day}
  end
end
