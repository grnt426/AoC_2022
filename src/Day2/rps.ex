defmodule Rps do
  @moduledoc false

  def predict_score(input) do
    scoring = [
      "B X", "C Y", "A Z",
      "A X", "B Y", "C Z",
      "C X", "A Y", "B Z"
    ]
    games = String.split(input, "\n")
    IO.puts("Games to play #{length(games)}")
    Enum.map(games,
      fn g -> Enum.find_index(scoring, fn x -> x == String.trim(g) end) + 1 end
    ) |> Enum.sum()
  end

  def play_to_strategy(input) do
    play_guide = %{
      "B X"=>"B X", "C Y"=>"C Z", "A Z"=>"A Y",
      "A X"=>"A Z", "B Y"=>"B Y", "C Z"=>"C X",
      "C X"=>"C Y", "A Y"=>"A X", "B Z"=>"B Z"
    }
    games = String.split(input, "\n")
    Enum.map(games, fn g -> play_guide[String.trim(g)] end) |> Enum.join("\n") |> predict_score
  end
end

# A = Rock
# B = Paper
# C = Scissors

# X = Rock
# Y = Paper
# Z = Scissors

IO.puts("Example Puzzle. Expect: 15")
case File.read("input/Day2/example.txt") do
  {:ok, body} -> IO.puts(Rps.predict_score(body))
  {:error, reason} -> IO.puts(reason)
end

IO.puts("Input 1 Puzzle. Expect: 11,063")
case File.read("input/Day2/input1.txt") do
  {:ok, body} -> IO.puts(Rps.predict_score(body))
  {:error, reason} -> IO.puts(reason)
end

# A = Rock
# B = Paper
# C = Scissors

# X = lose
# Y = draw
# Z = win

IO.puts("Input 2 Puzzle. Expect: 10349")
case File.read("input/Day2/input1.txt") do
  {:ok, body} -> IO.puts(Rps.play_to_strategy(body))
  {:error, reason} -> IO.puts(reason)
end