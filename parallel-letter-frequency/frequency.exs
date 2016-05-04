defmodule Frequency do
  @doc """
  Count letter frequency in parallel.

  Returns a dict of characters to frequencies.

  The number of worker processes to use can be set with 'workers'.
  """

  # I guess this task is actually not so good elixir, as it doesn't seem
  # to come with that concept of a worker pool, so I need get a little hacky.
  # Well actually I think there probably IS exact this kind of functionality,
  # but I wanna get a little hacky anyways :)
  # Also: It is not stated how granular the workers are supposed to share the work:
  # Possible scenarios:
  # 1) Every worker does look for one letter in the alphabet, so first worker looks for a
  # and another one looks for b in all the texts
  # 2) Say you have 4 workers. first then does letter number 1,5,9.. and the second
  # does 2,6,10..
  # 3) every worker does one text. I choose this :)
  @spec frequency([String.t], pos_integer) :: map
  def frequency([],_), do: %{}
  def frequency(texts, workers) do
    me = self()
    texts
    |> Enum.take(workers)
    |> Enum.map(fn text ->
      spawn_link fn -> (send me, {self, find_freq(text) }) end
    end)
    |> Enum.map(fn _pid ->
      receive do {_pid, result} -> result end
    end)
    |> Enum.reduce(fn x, acc ->
      Map.merge(x, acc, fn _k, v1, v2 -> v1 + v2 end)
    end)
    |> Map.merge(frequency(Enum.drop(texts, workers), workers), fn _k, v1, v2 ->
      v1 + v2
    end)
  end

  def find_freq(string) do
    string
    |> to_char_list
    |> Enum.filter(fn x -> !(x in ' 123456789.,-?!/\'') end)
    |> Enum.reduce(%{}, fn x, acc ->
      x = [x] |> to_string |> String.downcase
      Map.update(acc, x, 1, fn count -> count + 1 end)
    end)
  end

end
