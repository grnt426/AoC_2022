defmodule Cleanup do
  @moduledoc false

  def find_total_overlapping(input) do
    pairs = String.split(input, "\n") |> Enum.map(fn s -> String.trim(s) end)
    overlaps = Enum.map(pairs, fn p -> get_ranges(p) end) |> Enum.filter(fn r -> r != nil end)
    supersets = Enum.filter(overlaps, fn o -> is_superset(o) end)
    length(supersets)
  end

  def find_overlapping(input) do
    pairs = String.split(input, "\n") |> Enum.map(fn s -> String.trim(s) end)
    overlaps = Enum.map(pairs, fn p -> get_ranges(p) end) |> Enum.filter(fn r -> r != nil end)
    length(overlaps)
  end

  defp is_superset(o) do
    l1 = Enum.to_list(Enum.at(o, 0)) |> MapSet.new
    l2 = Enum.to_list(Enum.at(o, 1)) |> MapSet.new
    inter = MapSet.intersection(l1, l2)
    inter == l1 or inter == l2
  end

  defp get_ranges(pairing) do
    pair = String.split(pairing, ",")
    ranges = Enum.map(pair, fn p -> get_range(p) end)
    r1 = Enum.at(ranges, 0)
    r2 = Enum.at(ranges, 1)
    case !Range.disjoint?(r1, r2) do
      true -> [r1, r2]
      false -> nil
    end
  end

  defp get_range(pair) do
    range = String.split(pair, "-")
    left = Enum.at(range, 0) |> String.to_integer
    right = Enum.at(range, 1) |> String.to_integer
    left..right//1
  end

end

IO.puts("Example Puzzle. Expect: 2")
case File.read("input/Day4/example.txt") do
  {:ok, body} -> IO.puts("Result: #{Cleanup.find_total_overlapping(body)}")
  {:error, reason} -> IO.puts(reason)
end

IO.puts("Input 1 Puzzle. Expect: 444")
case File.read("input/Day4/input1.txt") do
  {:ok, body} -> IO.puts("Result: #{Cleanup.find_total_overlapping(body)}")
  {:error, reason} -> IO.puts(reason)
end

IO.puts("Input 2 Puzzle. Expect: 801")
case File.read("input/Day4/input1.txt") do
  {:ok, body} -> IO.puts("Result: #{Cleanup.find_overlapping(body)}")
  {:error, reason} -> IO.puts(reason)
end

