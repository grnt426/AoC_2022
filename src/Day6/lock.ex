defmodule Lock do
  @moduledoc false
  
  def find_lock(input) do
    check = String.slice(input, 0, 4)
    count = String.to_charlist(check) |> Enum.sort |> Enum.dedup |> List.to_string |> String.length
    case count do
      4 -> 4
      x when x < 4 -> 1 + find_lock(String.slice(input, 1, String.length(input)))
    end
  end
end

IO.puts("Example Puzzle. Expect: 7")
IO.puts("Result: #{Lock.find_lock("mjqjpqmgbljsphdztnvjfqwrcgsmlb")}")

IO.puts("Input 1 Puzzle. Expect: 1,804")
case File.read("input/Day6/input1.txt") do
  {:ok, body} -> IO.puts("Result: #{Lock.find_lock(String.trim(body))}")
  {:error, reason} -> IO.puts(reason)
end