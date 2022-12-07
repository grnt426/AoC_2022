defmodule Crane do
  @moduledoc false

  def find_top_crates(input) do
    puzzle = String.split(input, "\n")
    stack_height = Enum.at(puzzle, 0) |> String.trim |> String.to_integer
    stacks = Enum.slice(puzzle, 1, stack_height - 1)
    numbered = Enum.at(puzzle, stack_height) |> String.split
    total_stacks = List.last(numbered) |> String.trim |> String.to_integer
    commands = Enum.slice(puzzle, stack_height + 1, length(puzzle) - stack_height - 1)
    crate_stacks = build_stacks(stacks, total_stacks)
    Enum.map(crate_stacks, fn s -> hd(s) end) |> Enum.to_list
  end

  defp build_stacks(stacks, total_stacks) do
    reg = ~r/(\s{3}|\[\w\])(?:$|\s)/
    crates = Enum.map(stacks, fn s -> Regex.scan(reg, s, capture: :first) end)
             |> Enum.map(fn c -> Enum.map(c, fn v -> Enum.at(v, 0) |> String.at(1)  end)  end)
    Enum.map(0..(total_stacks - 1), fn i -> read_crates_for_column(i, crates, 0) end) |> Enum.to_list
  end
  
  defp read_crates_for_column(i, crates, line) when line < length(crates) do
    crate = Enum.at(crates, line) |> Enum.at(i)
    case crate do
      " " -> read_crates_for_column(i, crates, line + 1)
      _ -> [crate | read_crates_for_column(i, crates, line + 1)]
    end
  end
  
  defp read_crates_for_column(_, crates, line) when line == length(crates) do
    []
  end
end

# I have modified the input file *slightly*. The first line indicates how high the stacks are
# plus the row of numbers

IO.puts("Example Puzzle. Expect: CMZ")
case File.read("input/Day5/example.txt") do
  {:ok, body} -> IO.puts("Result: #{Crane.find_top_crates(body)}")
  {:error, reason} -> IO.puts(reason)
end

#IO.puts("Input 1 Puzzle. Expect: ")
#case File.read("input/Day5/input1.txt") do
#  {:ok, body} -> IO.puts("Result: #{Crane.find_top_crates(body)}")
#  {:error, reason} -> IO.puts(reason)
#end
