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