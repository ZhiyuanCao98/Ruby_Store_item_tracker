require "item"

class Interact
  class Query
    @@command_list = ['list', 'find', 'add', 'quit']
    def self.command_list; @@command_list; end
  end

  def initialize(path = nil)
      Item.filepath = path

      if Item.file_usable?
        count = Item.get_acc_count
        puts "\n>>>>>>>>>> Loading File........."
        puts ">>>>>>>>>> Your log in time(s): #{count}"
        puts ">>>>>>>>>> Welcome!"
      elsif Item.create_file
        puts "\n>>>>>>>>>>> Initialize"
        puts ">>>>>>>>>>> This is your first time use the system!"
        puts ">>>>>>>>>>> Create Item list!"
      else
        puts "Error: Item file"
        exit!
      end
  end

  def launch!
    greeting

    result = nil
    until result == :quit
      command = get_command
      result = do_command(command)
    end

    conclusion
  end

#
  def get_command
    print "Input query>>"
    command = gets.chomp
    until Interact::Query.command_list.include?(command)
      puts "Failed!!     query_directory: " + Interact::Query.command_list.join(", ")
      print "Input query>>"
      command = gets.chomp.downcase.strip
    end
    return command
  end

# Need more options
  def do_command(command)
    case command
    when 'add'
      add
    when 'list'
      list
    when 'find'
      find
    when 'quit'
      return :quit
    else
      puts "\nI don't understand that command.\n"
    end
  end

  def add
    item = Item.add_new_item
    item.save_item
  end

  def list

    Item.list
  end

  def find
    puts "\nTips: find name; find price; find category"
    print "Keyword Find >>>"
    name = gets.chomp.strip
    Item.find(name)
  end

  def greeting
    puts "\n" + "#" * 15 + " <<<Welcome to Info tracker>>> " + "#" * 15
    puts "#" * 15 + "   This is a query system for your item   " + "#" * 4 + "\n"
  end

  def conclusion
    puts "\n           <<<<<<<<<Good Bye!>>>>>>>>>>>"
  end


end
