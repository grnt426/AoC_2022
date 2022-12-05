defmodule CalorieCounting do
  @moduledoc false

  def sum_elf_food(input, top_count) do
    elves = String.split(input)
    elves_food = Enum.map(elves, fn f -> String.split(f, ",") end)
    Enum.map(elves_food, fn l -> Enum.map(l, fn f -> String.to_integer(f) end)
      |> Enum.sum end) |> Enum.sort |> Enum.reverse
      |> Enum.slice(0, top_count) |> Enum.sum
  end
end

IO.puts("Example Puzzle. Expect: 24,000")
case File.read("input/Day1/example.txt") do
  {:ok, body} -> IO.puts(CalorieCounting.sum_elf_food(body, 1))
  {:error, reason} -> IO.puts(reason)
end

IO.puts("Input 1 Puzzle. Expect 69,912")
case File.read("input/Day1/input1.txt") do
  {:ok, body} -> IO.puts(CalorieCounting.sum_elf_food(body, 1))
  {:error, reason} -> IO.puts(reason)
end

IO.puts("Input 2 Puzzle. Expect 208,180")
case File.read("input/Day1/input1.txt") do
  {:ok, body} -> IO.puts(CalorieCounting.sum_elf_food(body, 3))
  {:error, reason} -> IO.puts(reason)
end