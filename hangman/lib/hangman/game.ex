defmodule Hangman.Game do

  defstruct(
    turns_left: 7,
    game_state: :initializing,
    letters: [],
    used: MapSet.new()
  )

  def new_game(word) do
    %Hangman.Game{
      letters: word |> String.codepoints
    }
  end

  def new_game() do
    new_game(Dictionary.random_word)
  end

  def make_move(game = %{ game_state: state }, _guess) when state in [:won, :lost] do
    game
    |> return_with_tally()
  end

  def make_move(game, guess) do
    validate_move(game, guess, Regex.match?(~r/[a-z]/, guess))
    |> return_with_tally()
  end

  def tally(game) do
    %{
      game_state: game.game_state,
      turns_left: game.turns_left,
      letters: game.letters |> reveal_guessed(game.used),
      used: game.used
    }
  end

  # *******************
  # ***** PRIVATE *****
  # *******************

  defp validate_move(game, guess, _valid_guess = true) do
    accept_move(game, guess, MapSet.member?(game.used, guess))
  end

  defp validate_move(game, _guess, _invalid_move) do
    Map.put(game, :game_state, :invalid_guess)
  end

  defp accept_move(game, _guess, _already_guessed = true) do
    Map.put(game, :game_state, :already_used)
  end

  defp accept_move(game, guess, _already_guessed) do
    Map.put(game, :used, MapSet.put(game.used, guess))
    |> score_guess(Enum.member?(game.letters, guess))
  end

  defp score_guess(game, _good_guess = true) do
    new_state = MapSet.new(game.letters)
    |> MapSet.subset?(game.used)
    |> maybe_won()
    Map.put(game, :game_state, new_state)
  end

  defp score_guess(game = %{ turns_left: 1 }, _not_good_guess) do
    Map.put(game, :game_state, :lost)
  end

  defp score_guess(game = %{ turns_left: turns_left }, _not_good_guess) do
    %{ game | game_state: :bad_guess, turns_left: turns_left - 1 }
  end

  defp maybe_won(true), do: :won
  defp maybe_won(_), do: :good_guess

  defp reveal_guessed(letters, used) do
    letters
    |> Enum.map(fn letter -> reveal_letter(letter, MapSet.member?(used, letter)) end)
  end

  defp reveal_letter(letter, _in_word = true), do: letter
  defp reveal_letter(_letter, _not_in_word), do: "_"

  defp return_with_tally(game), do: { game, tally(game) }

  # Write a list comprehension that finds all the Pythagorean triples for right triangles
  # with sides shorter than 100. A Pythagorean triple is three integers a, b, an c,
  # wher a^2 + b^2 = c^2

  # def pythag_triples() do
  #   # 55629 - runs 1,000,000 times (100 * 100 * 100)
  #   # :timer.tc(fn ->
  #   #   for a <- 1..100, b <- 1..100, c <- 1..100, a*a + b*b == c*c, do: [a, b, c]
  #   # end) |> IO.inspect()

  #   # 16524 - over 3 times faster than above version
  #   :timer.tc(fn ->
  #     for a <- 1..100,
  #         b <- (a+1)..100,
  #         c <- (b+1)..100,
  #         a*a + b*b == c*c,
  #     do: [a, b, c]
  #   end) |> IO.inspect()
  # end

end
