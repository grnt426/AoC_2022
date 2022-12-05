defmodule Rucksack do
  @moduledoc false

  def find_shared(input) do
    priority = (?a..?z |> Enum.to_list) ++ (?A..?Z |> Enum.to_list)
    String.split(input, "\n") |> Enum.map(fn s -> find_shared_within(String.trim(s), priority) end)
    |> Enum.sum
  end

  defp find_shared_within(input, priority) do
    half = trunc(String.length(input) / 2)
    left = prepare_sack(input, 0, half)
    right = prepare_sack(input, half, half)
    dupe = MapSet.intersection(left, right) |> MapSet.to_list |> Enum.at(0) |> String.to_charlist
           |> Enum.at(0)
    Enum.find_index(priority, fn x -> x == dupe end) + 1
  end

  defp prepare_sack(input, start, len) do
    String.slice(input, start, len) |> String.graphemes |> Enum.sort |> Enum.dedup
    |> MapSet.new
  end
end

IO.puts("Example Puzzle. Expect: 157")
case File.read("input/Day3/example.txt") do
  {:ok, body} -> IO.puts(Rucksack.find_shared(body))
  {:error, reason} -> IO.puts(reason)
end

IO.puts("Input 1 Puzzle. Expect: 7,428")
case File.read("input/Day3/input1.txt") do
  {:ok, body} -> IO.puts(Rucksack.find_shared(body))
  {:error, reason} -> IO.puts(reason)
end