defmodule TextClient.Interact do

  alias TextClient.{Player, State}

  def start() do
    Hangman.new_game()
    |> setup_state()
    |> Player.play()
  end

  defp setup_state(game) do
    %State{
      game_service: game,
      tally: Hangman.tally(game)
    }
  end

  # Recursion example
  # def countdown(0), do: IO.puts "Liftoff!"
  # def countdown(n) do
  #   IO.puts n
  #   countdown(n - 1)
  # end


end
