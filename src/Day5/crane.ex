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
  end

  defp build_stacks(stacks, total_stacks) do
    reg = ~r/(\s{3}|\[\w\])(?:$|\s)/
    stack_lists = Enum.map(0..(total_stacks - 1), fn r -> [] end)
    crates = Enum.map(stacks, fn s -> Regex.scan(reg, s, capture: :first) end)
             |> Enum.map(fn c -> Enum.map(c, fn v -> Enum.at(v, 0) |> String.at(1)  end)  end)
    IO.puts("Line 1 #{length(Enum.at(crates, 0))}")
    Enum.each(crates, fn line -> Enum.with_index(line) |> Enum.each(fn({c, i}) -> insert_crate(Enum.at(stack_lists, i), c) end) end)
    IO.puts("Whats in stack 1")
    IO.puts(Enum.at(stack_lists, 1))
  end

  defp insert_crate(stack, c) when length(stack) > 0 do
    IO.puts("Inserting crate #{c} into stack #{stack}")
    case String.trim(c) do
      "" -> [stack]
      _ -> [c | stack]
    end
  end

  defp insert_crate(stack, c) when length(stack) == 0 do
    IO.puts("Newly inserting crate #{c}")
    case String.trim(c) do
      "" -> [stack]
      _ -> [c | stack]
    end
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
