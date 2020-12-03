defmodule Dictionary.Application do

  use Application

  # Don't want to link application to overall runtime, so just use start(), not start_link()
  def start(_type, _args) do

    import Supervisor.Spec

    children = [
      worker(Dictionary.WordList, [])
    ]

    options = [
      name: Dictionary.Supervisor,
      strategy: :one_for_one
    ]

    Supervisor.start_link(children, options)
  end

end
