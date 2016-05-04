defmodule SpaceAge do
  @type planet :: :mercury | :venus | :earth | :mars | :jupiter
                | :saturn | :neptune | :uranus

  @doc """
  Return the number of years a person that has lived for 'seconds' seconds is
  aged on 'planet'.
  """
  @spec age_on(planet, pos_integer) :: float
  # I don't like this exercise. This is not so much
  # a coding exercise as it is an exercise in copy-pasting
  # stuff from wikipedia. Correct if I am wrong and Erlang has got
  # some kind of space-year library, though.
  def age_on(planet, seconds) do
    days = seconds/ (60 * 60 * 24)
    days_in_year =
    case planet do
      :mercury -> 87.969
      :venus   -> 224.701
      :earth   -> 365.25
      :mars    -> 686.98
      :jupiter -> 11*365.25 + 315
      :saturn  -> 29.457*365.25
      :uranus  -> 84.011 * 365.25
      :neptune -> 164.79 * 365.25
    end
    days / days_in_year
  end
end
