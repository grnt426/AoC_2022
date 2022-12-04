defmodule CalorieCounting do
  @moduledoc false

  def find_highest(input) do
    IO.puts(input)
    elves = String.split(input)
    IO.puts("Each Elf: #{elves}")
    elves_food = Enum.map(elves, fn f -> String.split(f, ",") end)
    IO.puts("Their Food in a list: #{elves_food}, items #{length(elves_food)}")
    summed = Enum.map(elves_food, fn l -> Enum.map(l, fn f -> String.to_integer(f) end) |> Enum.sum() end)
#    Enum.sort(summed) |> Enum.reverse() |> IO.inspect(charlists: :as_lists)
    IO.puts("Maximum food on an elf #{Enum.max(summed)}")
  end
end

IO.puts("Example Puzzle")
case File.read("input/Day1/input1.txt") do
  {:ok, body} -> IO.puts(CalorieCounting.find_highest(body))
  {:error, reason} -> IO.puts(reason)
end