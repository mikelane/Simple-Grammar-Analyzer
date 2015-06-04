###
#
# Mike Lane, CS311, Project 2
#
# Input class. This adds pop and peek functionality to the input string of a PDA.
#

class Input
  attr_accessor :input, :length

  # Initialize the input tape.
  def initialize(*args)
     if args.length == 0
       print 'Input a string to evaluate: '
       @input = gets.chomp
     else
       @input = args[0]
     end
  end

  # return the substring starting at the 2nd element and onwards. Does not modify the actual string.
  def pop
    @input[1..-1]
  end

  # modify the actual string and return the popped element. Return nil if the string is empty
  def pop!
    if @input == nil
      nil
    else
      top = input[0]
      @input = input[1..-1]
      top
    end
  end

  # Return the value of the first element in the string.
  def peek
    @input[0]
  end

  # If the length of the input string is 0, return true; otherwise return false.
  def is_empty
    @input.length == 0
  end
end

# test = Input.new
# p test
#
# puts "testing peek(). Should see #{test.input[0]}"
# top = test.peek
# puts "top is #{top}"
# puts
#
# puts 'testing is_empty(). Should be false'
# puts "is_empty returns #{test.is_empty}"
# puts
#
# puts 'testing pop! Should continue to pop, displaying each value until empty'
# until test.is_empty
#   top = test.pop!
#   p test
#   puts top
# end
# puts
#
# puts 'now is_empty() should return true'
# puts "is_empty returns #{test.is_empty}"
# puts