defmodule Hangman.Server do

  alias Hangman.Game

  # Says this is a GenServer and pre-defines several default callbacks
  use GenServer

  def start_link() do
    # Creates a new process and calls init
    GenServer.start_link(__MODULE__, nil)
  end

  def init(_) do
    # Returns the state of the GenServer, which in this case is a new game
    { :ok, Game.new_game() }
  end

  def handle_call({ :make_move, guess }, _from, game) do
    { game, tally } = Game.make_move(game, guess)
    { :reply, tally, game }
  end

end
