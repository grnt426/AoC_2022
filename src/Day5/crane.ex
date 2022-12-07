defmodule Crane do
  @moduledoc false

  def find_top_crates(input, retain_order) do
    puzzle = String.split(input, "\n")
    stack_height = Enum.at(puzzle, 0) |> String.trim |> String.to_integer
    stacks = Enum.slice(puzzle, 1, stack_height - 1)
    numbered = Enum.at(puzzle, stack_height) |> String.split
    total_stacks = List.last(numbered) |> String.trim |> String.to_integer
    commands = Enum.slice(puzzle, stack_height + 2, length(puzzle) - stack_height - 1)
    crate_stacks = build_stacks(stacks, total_stacks) |> process_moves(commands, retain_order)
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
  
  defp process_moves(stacks, commands, retain_order) when length(commands) > 0 do
    [cur | rest] = commands
    [amt | [src | [dst]]] = Regex.scan(~r/(\d+)/, cur, capture: :first) |> List.flatten |> Enum.map(fn c -> String.to_integer(c) end)
    src = src - 1
    dst = dst - 1
    src_stack = Enum.at(stacks, src)
    dst_stack = Enum.at(stacks, dst)
    
    moved = Enum.slice(src_stack, 0, amt)
    moved = case retain_order do
      true -> moved
      false -> Enum.reverse(moved)
    end
    src_stack = Enum.drop(src_stack, amt)
    dst_stack = Enum.concat(moved, dst_stack)
    
    stacks = List.replace_at(stacks, src, src_stack)
    stacks = List.replace_at(stacks, dst, dst_stack)
    process_moves(stacks, rest, retain_order)
  end
  
  defp process_moves(stacks, commands, _) when length(commands) == 0 do
    stacks
  end
end

# I have modified the input file *slightly*. The first line indicates how high the stacks are
# plus the row of numbers

IO.puts("Example Puzzle. Expect: CMZ")
case File.read("input/Day5/example.txt") do
  {:ok, body} -> IO.puts("Result: #{Crane.find_top_crates(body, false)}")
  {:error, reason} -> IO.puts(reason)
end

IO.puts("Input 1 Puzzle. Expect: QNHWJVJZW")
case File.read("input/Day5/input1.txt") do
  {:ok, body} -> IO.puts("Result: #{Crane.find_top_crates(body, false)}")
  {:error, reason} -> IO.puts(reason)
end

IO.puts("Input 2 Puzzle. Expect: BPCZJLFJW")
case File.read("input/Day5/input1.txt") do
  {:ok, body} -> IO.puts("Result: #{Crane.find_top_crates(body, true)}")
  {:error, reason} -> IO.puts(reason)
end
