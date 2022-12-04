defmodule CalorieCounting do
  @moduledoc false

  def find_highest(input) do
    IO.puts(input)
    elves = String.split(input)
    IO.puts("Each Elf: #{elves}")
    elves_food = Enum.map(elves, fn f -> String.split(f, ",") end)
    IO.puts("Their Food in a list: #{elves_food}, items #{length(elves_food)}")
#    elf_food_total = Enum.map(elves_food, fn l -> Enum.map(l, fn f -> String.to_integer(f) end) end)
    max = Enum.map(elves_food, fn l -> Enum.sum(Enum.map(l, fn f -> String.to_integer(f) end)) end) |> Enum.max()
    IO.puts(max)
  end
end

IO.puts("Example Puzzle")
case File.read("input/Day1/example.txt") do
  {:ok, body} -> IO.puts(CalorieCounting.find_highest(body))
  {:error, reason} -> IO.puts(reason)
end

