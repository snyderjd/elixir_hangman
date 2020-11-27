defmodule GameTest do
  use ExUnit.Case

  alias Hangman.Game

  test "new_game returns structure" do
    game = Game.new_game()

    assert game.turns_left == 7
    assert game.game_state == :initializing
    assert length(game.letters) > 0
  end

  test "game.letters includes only lowercase ASCII characters ('a' to 'z')" do
    game = Game.new_game()

    assert game.letters
      |> Enum.all?(fn char -> ~r/[a-z]/ |> Regex.match?(char) end)
  end

  test "state isn't changed for :won or :lost game" do
    for state <- [ :won, :lost ] do
      game = Game.new_game() |> Map.put(:game_state, state)
      assert ^game = Game.make_move(game, "x")
    end
  end

  test "first occurence of letter is not already used" do
    game = Game.new_game()
    game = Game.make_move(game, "x")
    assert game.game_state != :already_used
  end

  test "second occurence of letter is not already used" do
    game = Game.new_game()
    game = Game.make_move(game, "x")
    assert game.game_state != :already_used
    game = Game.make_move(game, "x")
    assert game.game_state == :already_used
  end

  test "a good guess is recognized" do
    game = Game.new_game("wibble")
    game = Game.make_move(game, "w")
    assert game.game_state == :good_guess
    assert game.turns_left == 7
  end

  test "a guessed word is a won game" do
    moves = [
      { "w", :good_guess },
      { "i", :good_guess },
      { "b", :good_guess },
      { "l", :good_guess },
      { "e", :won }
    ]

    game = Game.new_game("wibble")

    # Takes in the moves collection and iterates over it
    # Specifies the game as the initial accumulator
    # Defines a function that takes in a guess and state from the moves collection
    # along with the updated accumulator
    # The function calls Game.make_move, asserts, and returns the game that now has a different state

    Enum.reduce(moves, game, fn ({guess, state}, updated_game) ->
      updated_game = Game.make_move(updated_game, guess)
      assert updated_game.game_state == state
      updated_game
    end)

  end

  test "bad guess is recognized" do
    game = Game.new_game("wibble")
    game = Game.make_move(game, "x")
    assert game.game_state == :bad_guess
    assert game.turns_left == 6
  end

  test "lost game is recognized" do
    game = Game.new_game("w")

    game = Game.make_move(game, "a")
    assert game.game_state == :bad_guess
    assert game.turns_left == 6

    game = Game.make_move(game, "b")
    assert game.game_state == :bad_guess
    assert game.turns_left == 5

    game = Game.make_move(game, "c")
    assert game.game_state == :bad_guess
    assert game.turns_left == 4

    game = Game.make_move(game, "d")
    assert game.game_state == :bad_guess
    assert game.turns_left == 3

    game = Game.make_move(game, "e")
    assert game.game_state == :bad_guess
    assert game.turns_left == 2

    game = Game.make_move(game, "f")
    assert game.game_state == :bad_guess
    assert game.turns_left == 1

    game = Game.make_move(game, "g")
    assert game.game_state == :lost
  end

  test "Game returns :invalid_move state if guess is not a lowercase a-z" do
    game = Game.new_game("wibble")
    game = Game.make_move(game, "W")
    assert game.game_state == :invalid_guess
  end

end
