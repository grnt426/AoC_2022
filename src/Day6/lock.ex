defmodule Lock do
  @moduledoc false
  
  def find_lock(input, look_ahead) do
    check = String.slice(input, 0, look_ahead)
    count = String.to_charlist(check) |> Enum.sort |> Enum.dedup |> List.to_string |> String.length
    case count do
      ^look_ahead -> look_ahead
      x when x < look_ahead -> 1 + find_lock(String.slice(input, 1, String.length(input)), look_ahead)
    end
  end
end

IO.puts("Example Puzzle. Expect: 7")
IO.puts("Result: #{Lock.find_lock("mjqjpqmgbljsphdztnvjfqwrcgsmlb", 4)}")

IO.puts("Input 1 Puzzle. Expect: 1,804")
case File.read("input/Day6/input1.txt") do
  {:ok, body} -> IO.puts("Result: #{Lock.find_lock(String.trim(body), 4)}")
  {:error, reason} -> IO.puts(reason)
end

IO.puts("Input 1 Puzzle. Expect: ")
case File.read("input/Day6/input1.txt") do
  {:ok, body} -> IO.puts("Result: #{Lock.find_lock(String.trim(body), 14)}")
  {:error, reason} -> IO.puts(reason)
end