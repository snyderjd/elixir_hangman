defmodule Lists do

  # Get the length of a list
  def len([]),              do: 0
  def len([_head | tail]),  do: 1 + len(tail)

  # sum the elements in a list
  def sum([]),            do: 0
  def sum([head | tail]), do: head + sum(tail)

  # double the elements in a list
  def double([]),             do: []
  def double([head | tail]),  do: [ 2 * head | double(tail)]

  # square the elements in a list
  def square([]),             do: []
  def square([head | tail]),  do: [ head * head | square(tail)]

  # map over the list and call a function on each element
  def map([], _function), do: []
  def map([head | tail], function) do
    [ function.(head) | map(tail, function)]
  end

  # Takes a list and returns a list which is half the length. Each element in the result
  # is the sum of two elements in the input
  def sum_pairs([]), do: []
  def sum_pairs([head1, head2 | tail]), do: [head1 + head2 | sum_pairs(tail) ]

  # Write a function even_length? that uses pattern matching only to return false
  # if the list you pass it has an odd number of elements, true otherwise
  def even_length?([]), do: true
  def even_length?([_head | []]), do: false
  def even_length?([_head1, _head2 | tail]), do: even_length?(tail)

end
