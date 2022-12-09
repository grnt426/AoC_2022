defmodule Sizer do
  @moduledoc false
  
  def sum_dirs_of_max_size(input, max_size) do
    fs = process_cmd_list(input)
    5
  end
  
  defp process_cmd_list(input) do
    lines = String.split(input, "\n") |> Enum.map(fn l -> String.trim(l) end)
    fs = %{:name => "/"}
    fs = process_cmds(tl(lines), fs, [])
    IO.puts("Results of processing")
    IO.inspect(fs)
    fs
  end
  
  defp process_cmds(lines, fs, cur) when length(lines) > 0 do
    exec = String.split(hd(lines), " ") |> Enum.at(1)
    IO.puts("Next command: #{exec}")
    case exec do
      "ls" -> process_ls(tl(lines), fs, cur)
      "cd" -> process_cd(lines, fs, cur)
    end
  end
  
  defp process_cmds(lines, fs, _) when length(lines) == 0 do
    fs
  end
  
  defp process_cd(lines, fs, cur) do
    dir = String.split(hd(lines), " ") |> List.last
    IO.puts("cd into #{dir}")
    cur = case dir do
      ".." -> Enum.drop(cur, -1)
      d -> cur ++ [d]
    end
    IO.inspect(cur)
    process_cmds(tl(lines), fs, cur)
  end
  
  defp process_ls(lines, fs, cur) when length(lines) > 0 do
    [left | right] = String.split(hd(lines), " ")
    IO.puts("Processing ls")
    IO.puts("#{left}")
    IO.inspect(right)
    
    res = case left do
      "$" ->
        IO.puts("Matched start of terminal, done ls processing")
        :done
      "dir" ->
        name = Enum.at(right, 0)
        write_dir(fs, cur, name)
      x -> # assume its an integer, which means a file size
        name = Enum.at(right, 0)
        write_file(fs, cur, name, x)
    end
    
    case res do
      :done ->
        IO.puts("Done with ls returning")
        process_cmds(lines, fs, cur)
      _ ->
        IO.puts("Checking for more ls")
        process_ls(tl(lines), res, cur)
    end
  end

  defp process_ls(lines, fs, _) when length(lines) == 0 do
    fs
  end
  
  defp write_file(fs, cur, name, size) when length(cur) == 0 do
    Map.put(fs, name, String.to_integer(size))  
  end
  
  defp write_file(fs, cur, name, size) when length(cur) > 0 do
    Kernel.put_in(fs, cur ++ [name], String.to_integer(size))
  end
  
  defp write_dir(fs, cur, name) when length(cur) == 0 do
    Map.put(fs, name, %{:name => name})
  end

  defp write_dir(fs, cur, name) when length(cur) > 0 do
    Kernel.put_in(fs, cur ++ [name], %{:name => name})
  end
end

IO.puts("Example Puzzle. Expect: 95437")
case File.read("input/Day7/example.txt") do
  {:ok, body} -> IO.puts("Result: #{Sizer.sum_dirs_of_max_size(body, 100_000)}")
  {:error, reason} -> IO.puts(reason)
end

#IO.puts("Input 1 Puzzle. Expect: ")
#case File.read("input/Day7/input1.txt") do
#  {:ok, body} -> IO.puts("Result: #{Sizer.sum_dirs_of_max_size(body, 100_000)}")
#  {:error, reason} -> IO.puts(reason)
#end