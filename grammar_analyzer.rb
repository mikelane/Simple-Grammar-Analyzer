#!/usr/bin/env ruby

require_relative 'cfg.rb'
require_relative 'stack.rb'
require_relative 'input.rb'
require_relative 'pda.rb'
require 'pp'

###
#
# Mike Lane, CS311, Project 2, 3 June 2014
#
# This file acts as the system controller calling the relevant functions as required.
#

def res_is_yes(prompt='try again?')
  print prompt << ' (y/n) '
  response = gets.chomp
  response.to_s.downcase!
  response[0] == 'y'
end

###
# Create a new CFG which displays a menu for building or loading it. If a CFG was loaded, then pretty print
# the details of the CFG. Create a stack object and an input object and then create a new PDA passing in the
# CFG, stack, and input objects. Print out the details of the PDA as it is loaded into memory, then evaluate
# the input string over the CFG using the PDA's evaluate_input method. Display the ACCEPT or REJECT results
# and ask the user if they want to try again.
begin
  # Create a new CFG (by hand or from a file)
  cfg = CFG.new

  # If a CFG was successfully created,
  if cfg.description
    puts "\nThe CFG is: "
    cfg.output
    puts

    # then make the stack and input objects.
    stack = Stack.new(cfg.start_variable)
    input = Input.new

    # Then pass the CFG, stack, and input objects to the PDA object's initializer.
    pda = PDA.new(cfg, stack, input)

    # Output the details of the PDA in memory
    puts "\n\n\n#{'-' * 100}"
    puts "#{'  The PDA (including the stack and input tape) in memory is  '.center(100, '-')}"
    puts "#{'-' * 100}\n\n"
    PP.pp pda

    # Evaluate the input over the CFG using the PDA's evaluate_input method.
    puts "\n\n\n#{'-' * 100}"
    puts "#{'  Evaluating input over CFG  '.center(100, '-')}"
    puts "#{'-' * 100}\n\n"
    result = pda.evaluate_input
    puts "\n#{'-' * 100}"
    puts "#{'  Evaluation of input over CFG complete  '.center(100, '-')}"
    puts "#{"  Return value was #{result}  ".center(100, '-')}"
    puts "#{'-' * 100}\n\n\n\n"
  end

  # Do it all over again if the user wants to.
end while cfg.description and res_is_yes 'Enter another PDA?'

puts "#{"\n" * 100}\t\t#{'  Goodbye!  '.center(100,'#')}#{"\n" * 25}"
