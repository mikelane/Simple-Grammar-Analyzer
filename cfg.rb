require 'yaml'
require_relative 'menu.rb'
require 'pp'

###
#
# Mike Lane, CS311, Project 2, 3 June 2015
#
# This file contains the Class implementation for the Context Free Grammar. It includes a constructor, 4 functions
# to set the relevant items of the 4-tuple, a function to dump a CFG out to a YAML file, a function to read in a
# CFG from a YAML file, and a function to display the CFG.
#

class CFG
  attr_accessor :variables, :sigma, :relations, :start_variable, :cfg, :description

  ###
  # CFG class constructor. This is overloaded (in a Ruby kind of way)
  #
  def initialize(*args)
    # If the number of args passed in is 1, then call the load_cfg function passing the first
    # argument in the array. The intent is for the user to pass in a filename.
    if args.length >= 1
      load_cfg(args[0])
    else # If the number of args is 0, allow the user to set up a new CFG
      opts = ['CFG Menu',
              'Build a new CFG and dump it to a YAML file',
              'Parse a CFG from a YAML file']

      build_menu = Menu.new(opts)
      choice = build_menu.display
      if choice == 1
        set_desc
        set_v
        set_sigma
        set_r
        set_s
        dump
      elsif choice == 2
        filename = get_filename
        puts (
             if filename != nil
               load_cfg("CFG/#{filename}")
               puts "\n\n\n#{'-' * 100}"
               puts "#{"  Loading CFG from file #{filename}".center(100, '-')}"
               puts "#{'-' * 100}\n\n"
             else
               puts 'No CFG loaded'
             end)
      elsif choice == 3
        puts 'No CFG loaded'
        false
      else
        puts "I didn't understand that input!"
        false
      end
    end
  end

  ###
  # Set the description of the CFG
  #
  def set_desc
    print 'Enter CFG description: '
    @description = gets.chomp
  end

  ###
  # Set the Variables of the CFG
  #
  def set_v
    print 'Enter variables separated by spaces: '
    s = gets.chomp
    @variables = s.split(' ')
  end

  ###
  # Set the alphabet of the CFG
  #
  def set_sigma
    print 'Enter alphabet characters separated by spaces: '
    s = gets.chomp
    @sigma = s.split(' ')
  end

  ###
  # Set the relations of the CFG
  #
  def set_r
    print 'Enter relation rules separated by spaces: '
    s = gets.chomp
    @relations = s.split(' ')
  end

  ###
  # Set the start state of the CFG
  #
  def set_s
    print 'Enter start state variable: '
    @start_variable = gets.chomp
  end

  ###
  # Dump the CFG to a YAML file.
  #
  def dump(*args)
    # If we received at least one argument, take the first argument and use it as a file name
    if args.length >= 1
      file = args[0]
      obj = YAML::dump(self)
      File.open(file, 'w') {|f| f.write obj.to_yaml}
    else # Otherwise, ask the user where to save the file
      print "\n\nFilename: "
      file = gets.chomp
      dump("CFG/#{file}") # And then call the dump function again with that filename.
    end
  end

  ###
  # Look in the CFG sub-directory and get the filenames for the encoded grammars
  #
  def get_filename
    files = Dir.entries('CFG')[1..-1]
    files[0] = 'Available CFGs'
    files_menu = Menu.new(files)
    choice = files_menu.display
    files[choice]
  end

  ###
  # Load a CFG into an object from a YAML file.
  #
  def load_cfg(file)
    @cfg = Psych.load_file(file) # Loads the YAML into a string stored in cfg
    @cfg = Psych.load(@cfg)         # Psych parses the string into an object that I can assign to the current object
    @description      = @cfg.description.chomp
    @variables        = @cfg.variables
    @sigma            = @cfg.sigma
    @relations        = @cfg.relations
    @start_variable   = @cfg.start_variable.chomp
  end

  ###
  # Output a human-readable CFG
  #
  def output
    width = @description.length + 10
    var_string = '      Variables: '
    if variables.length == 1
      var_string << variables[0]
    else
      var_string << '{'
      variables.each_with_index do |val, index|
        if index == variables.length-1
          var_string << "#{val}}"
        else
          var_string << "#{val}, "
        end
      end
    end


    width = max(width, var_string.length+4)

    sig_string = '       Alphabet: {'
    sigma.each_with_index do |val, index |
      if index == sigma.length-1
        sig_string << "#{val}}"
      else
        sig_string << "#{val}, "
      end
    end

    width = max(width, sig_string.length+4)

    puts "\t\t┌#{''.center(width, '─')}┐"
    puts "\t\t│#{@description.center(width, ' ')}│"
    puts "\t\t╞#{''.center(width, '═')}╡"
    puts "\t\t│#{''.center(width)}│"
    puts "\t\t│#{var_string.ljust(width)}│"
    puts "\t\t│#{sig_string.ljust(width)}│"
    puts "\t\t│#{('      Relations: '<<relations[0]).ljust(width)}│"
    relations.each_with_index do |val, index|
      if index != 0
        puts "\t\t│#{("                 #{val}").ljust(width)}│"
      end
    end

    start_string = '    Start State: ' << start_variable
    puts "\t\t│#{start_string.ljust(width)}│"
    puts "\t\t│#{''.center(width)}│"
    puts "\t\t└#{''.center(width, '─')}┘"
  end

  ###
  # Print out a verbose version of the object in memory
  def output_verbose
    PP.pp self
  end

  ###
  # Return the maximum numeric value of an arbitrary number of inputs
  def max(*lengths)
    lengths.max
  end
end

