###
#
# Mike Lane, CS311, Project 2, 3 June 2015
#
# This file contains the menu class implementation. This merely provides an easy way of dealing with menus.
#

class Menu
  attr_accessor :num_items, :max_width, :choices, :exit, :title

  # Menu class constructor.
  def initialize(menu)
    @title      = menu[0]           # Store the title
    @choices    = menu[1..-1]       # Store the array of options
    @num_items  = @choices.length   # Store the number of items in the list
    @exit       = @choices.length   # Store the number of the Exit item
    width       = title.length      # Set an initial value of the list to the title length

    # Walk through the array and if you find a string longer than the title, set the width to that value
    (0..@num_items-1).each { |x|
      if choices[x].length > width
        width = choices[x].length
      end
    }

    # Finally, set the max width of the array to that value.
    @max_width  = width + 30
  end

  #Pretty displaying of the user's menu
  def display
    again = false
    message = ''
    puts "\n" * 100
    # Ruby is magic in this respect. The ljust() (left justify), rjust (right justify), and center() methods
    # are fantastical. It's so easy to build a nice looking menu that there really isn't any reason not to.
    begin
      # This section deals with the top line, title, and separator line
      puts "\t\t╔".ljust(@max_width, '═') + '╗'
      puts "\t\t║#{@title.center(@max_width-3)}║"
      puts "#{"\t\t╠".ljust(@max_width, '═')}╣"
      puts "#{"\t\t║".ljust(@max_width)}║"

      # This section prints out the strings in the array and enumerates them and then puts an exit option
      # as the last item.
      (0..@num_items).each { |i|
        if i < @num_items
          puts "\t\t║    #{(i+1).to_s} #{'.' * 10} #{@choices[i]}".ljust(@max_width) + '║'
        else
          puts "#{"\t\t║    #{(i+1).to_s} #{'.' * 10} Exit".ljust(@max_width)}║"
        end
      }

      # This section pads the bottom and puts in the bottom line and corners.
      puts "#{"\t\t║".ljust(@max_width)}║"
      puts "#{"\t\t╚".ljust(@max_width, '═')}╝"
      print "#{"\n" * 20}"

      # If the user entered an invalid response (previously), print out a message
      if again
        puts message
        again = false
      end

      # Get the user response and convert it to an integer.
      print 'Your choice: '
      choice = gets.to_i

      # Validate the response. If invalid, set a message, clear the screen, and make it so the menu
      # displays again by setting the again bool flag to true.
      if choice < 1 or choice > @num_items + 1
        message = "Invalid choice. Please enter a value between 1 and #{@num_items+1}"
        puts "\n" * 100
        again = true
      end

      # If the again flag is set to true, display the menu again.
    end while again

    # Return choice to the caller
    choice
  end
end


# menu = ['CFG Menu',
#          'Read a CFG from a file',
#          'Write a CFG to a file',
#          'Parse a string using a CFG',
#          'Do a little dance',
#          'Make a little love']
# test = Menu.new(menu)
# choice = test.display
# puts "You entered: #{choice}"