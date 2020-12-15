defmodule GallowsWeb.HangmanView do
  use GallowsWeb, :view

  def display_word(tally) do
    tally.letters |> Enum.join(" ")
  end
end
