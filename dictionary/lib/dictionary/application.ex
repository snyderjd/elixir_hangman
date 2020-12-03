defmodule Dictionary.Application do

  use Application

  # Don't want to link application to overall runtime, so just use start(), not start_link()
  def start(_type, _args) do
    Dictionary.WordList.start_link()
  end

end
