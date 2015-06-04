###
#
# Mike Lane, CS311, Project 2, June 3 2015
#
# This is the class that actually implements the evaluation of the string over the grammar.
#

class PDA
  attr_accessor :input, :cfg, :stack

  ###
  # Build up the PDA with the CFG, the Stack, and the Input
  def initialize(cfg, stack, input)
    @cfg    = cfg
    @input  = input
    @stack  = stack
  end

  ###
  # Output the initial state of the stack and input and call the recursive helper function
  def evaluate_input
    puts "\tInitial Stack and Input values:\n\n"
    puts "\tStack: #{stack.inspect}"
    puts "\tInput: #{input.inspect}"
    puts "\t#{'_' * 80}\n\n"
    _evaluate_input(@stack, @input)
  end

  ###
  # This is where the magic happens. Evaluate the stack and the input objects, ACCEPT, REJECT, or modify
  # based on what is found in those objects as required.
  def _evaluate_input(stack, input)
    # Print out the state of the stack and input every time the recursive function is called.
    puts "\tStack: #{stack.inspect}"
    puts "\tInput: #{input.inspect}"
    puts "\t#{'_' * 80}\n\n"

    # If both the stack and the input are both empty, then ACCEPT
    if stack.is_empty and input.is_empty
      puts "\n\n\tACCEPTED: Stack and input are empty.\n"
      return 'ACCEPT'
    end

    # If either the stack or the input is empty and the other one is not, REJECT
    if stack.is_empty and !input.is_empty
      puts "\n\n\tREJECTED: Stack is empty while the input is not!\n"
      return 'REJECT'
    end

    # Pop an element off the stack
    element = stack.pop!

    # If the popped element is a variable, peek at the next character in the input, then search for
    # element→next_character. The next rule found lives at that index. Push the right hand side of
    # that rule to the stack. If no rule is found, reject the string.
    if is_variable(element)
      # peek at the next character in the input
      next_character = input.peek

      # find the rule that has the next character in the input as the first character
      # on the right hand side of the relation.
      index = matching_rule("#{element}→#{next_character}", cfg.relations)

      # If no rule was found, REJECT
      if index == nil
        puts "\n\n\tREJECTED: No matching rule was found\n"
        return 'REJECT'
      end

      # If the rule was found, then push the right hand side of that rule to the stack
      stack.push(cfg.relations[index][2..-1])

      # Call the function again on the CFG with the new stack.
      return _evaluate_input(stack, input)
    end

    # If a terminal was popped off the stack, first pop the next character from the input. If the
    # character popped off the stack does not match the character popped off the input, then REJECT.
    # Otherwise, call the function again on the modified CFG
    if is_terminal(element)

      #first pop the next character off the input
      next_character = input.pop!

      #if the next character is not the same as the terminal popped off the stack, REJECT
      if next_character != element
        puts "\n\n\tREJECTED: Next character in input does not match top of stack\n"
        return 'REJECT'
      end

      return _evaluate_input(stack, input)
    end

    puts "\n\n\tREJECTED: Item popped off stack is not in alphabet!\n"
    puts '          (CFG was malformed)'
    'REJECT'
  end

  ###
  # If the element was a variable, return true; otherwise return false.
  def is_variable(element)
    !(@cfg.variables.index(element) == nil)
  end

  ###
  # If the element is a terminal, return true; otherwise return false.
  def is_terminal(element)
    !(@cfg.sigma.index(element) == nil)
  end

  ###
  # Look through the relations array for the rule that begins with the same variable and has
  # the same terminal on the right of the arrow.
  def matching_rule(string, relations)
    relations.each_with_index { |val, i| return i if val[0..2] == string }
    nil
  end
end