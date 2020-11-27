defmodule Exercise do

  # Write a function that takes a two-element tuple as a parameter, and uses pattern
  # matching to return a two-element tuple with the values swapped (so pass it {2, 5} 
  # and you'll get {5, 2} back)
  # def swap_tuple({a, b}), do: {b, a}

  def swap_tuple({a, b}) do
    {b, a}
  end

  # Write a function that take two parameters. It should return true if the parameters
  # are the same, false otherwise. You aren't allowed to use any conditional logic, so you'll
  # have to rely on pattern matching
  def same_params(a, a) do
    true
  end

  def same_params(_, _) do
    false
  end

end
