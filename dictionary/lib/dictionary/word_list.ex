defmodule Dictionary.WordList do

  @process_name __MODULE__

  def start_link() do
    Agent.start_link(fn -> word_list() end, name: @process_name)
  end

  def random_word() do
    Agent.get(@process_name, &Enum.random/1)
  end

  def word_list do
    "../../assets/words.txt"
    |> Path.expand(__DIR__)
    |> File.read!()
    |> String.split(~r/\n/)
  end

end
