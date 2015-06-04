###
#
# Mike Lane, CS311, Project 2
#
# This class adds stack-like functionality to a string of characters by adding a push, pop at the
# top of the input (rather than the back as is built-in with Ruby)
#

class Stack
  attr_accessor :items

  ###
  # Initialize the stack with the start variable
  def initialize(start_var)
    @items = start_var
  end

  ###
  # Push a value (a string, as in the right hand side of the relation rule) on to the top of the stack.
  def push(value)
    @items = value << @items
  end

  ###
  # Return the array minus the first element in the stack
  def pop
    return nil if @items[0] == nil
    @items[1..-1]
  end

  ###
  # Ruby-style in-place destroying of the first item in the stack. Return the popped item.
  def pop!
    a = @items[0]
    return a if a == nil
    @items = @items[1..-1]
    a
  end

  ###
  # Peek at the top of the stack
  def peek
    @items[0]
  end

  ###
  # Determine if the stack is empty
  def is_empty
    @items[0] == nil
  end
end

# start_var = 'S'
# puts "creating stack and pushing #{start_var} on to it\n"
# test = Stack.new(start_var)
# puts
#
# print "stack is: "
# p test
# puts
#
# puts "testing is_empty()"
# puts "is_empty() returns #{test.is_empty}"
# puts
#
# puts "testing push. Pushing '0S0' onto the stack"
# test.push('0S0')
# print "@items should be \"OSOS\": "
# p test
# puts
#
# puts "testing .peek(), should see '0'"
# top = test.peek
# puts "top: #{top}"
# puts
#
# puts "testing popping the stack until it is empty"
# until test.is_empty
#   top = test.pop!
#   puts "top: #{top}"
#   p test
# end
# puts
#
# puts "Calling is_empty(), should return true"
# puts "test is empty: #{test.is_empty}"
