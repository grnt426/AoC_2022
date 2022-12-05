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

  def find_badges(input) do
    priority = (?a..?z |> Enum.to_list) ++ (?A..?Z |> Enum.to_list)
    sacks = String.split(input, "\n")
    find_badges_in_sacks(sacks, priority)
  end

  defp find_badges_in_sacks(sacks, priority) when length(sacks) > 0 do
    [first | [second | [third | remaining]]] = sacks
    first = String.trim(first) |> String.graphemes |> Enum.sort |> Enum.dedup |> MapSet.new
    second = String.trim(second) |> String.graphemes |> Enum.sort |> Enum.dedup |> MapSet.new
    third = String.trim(third) |> String.graphemes |> Enum.sort |> Enum.dedup |> MapSet.new

    shared = MapSet.intersection(first, second)
    shared = MapSet.intersection(shared, third)
    badge =  MapSet.to_list(shared) |> Enum.at(0) |> String.to_charlist |> Enum.at(0)
    Enum.find_index(priority, fn x -> x == badge end) + 1 + find_badges_in_sacks(remaining, priority)
  end

  defp find_badges_in_sacks(sacks, _priority) when length(sacks) == 0 do
    0
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

IO.puts("Input 2 Example Puzzle. Expect: 70")
case File.read("input/Day3/example2.txt") do
  {:ok, body} -> IO.puts("Result: #{Rucksack.find_badges(body)}")
  {:error, reason} -> IO.puts(reason)
end