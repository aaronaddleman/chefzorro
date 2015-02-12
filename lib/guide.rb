require 'virtualmachine'

class Guide
  class Config
    @@actions = ['list', 'make', 'upload', 'converge', 'destroy', 'quit']
    def self.actions; @@actions; end
  end
  
  def initialize(arg)
    # make sure we get a hash
    raise Exception.new('Argument not a Hash...') unless arg.is_a? Hash

    # locate the virtual machines file
    VirtualMachine.filepath = arg[:virtualmachines]

    if VirtualMachine.file_usable?
      puts "Found hosts file."
    else
      puts "Exiting.\n\n"
      exit!
    end
  end

  def launch!
    introduction
    # action loop
    result = nil
    until result == :quit
      action, args = get_action
      result = do_action(action, args)
    end
    conclusion
  end
  
  def get_action
    action = nil
    # Keep asking for user input until we get a valid action
    until Guide::Config.actions.include?(action)
      puts "Actions: " + Guide::Config.actions.join(", ")
      print "> "
      user_response = gets.chomp
      args = user_response.downcase.strip.split(' ')
      action = args.shift
    end
    return action, args
  end
  
  def do_action(action, args=[])
    # list
    # make
    # upload
    # converge
    # destory
    # quit
    case action
    when 'list'
      list(args)
    when 'make'
      # run nova boot
    when 'upload'
      # a chef zero environment
    when 'converge'
      # ssh into host and run chef-client
    when 'destroy'
      # run nova destroy
    when 'quit'
      return :quit
    else
      puts "\nI don't understand that command.\n"
    end
  end

  def list(args=[])

    # hosts = VirtualMachine.list_hosts

    sort_order = args.shift
    sort_order = args.shift if sort_order == 'by'
    sort_order = "hostname" unless ['hostname', 'description', 'flavor'].include?(sort_order)
    
    output_action_header("Listing Virtual Machines")
    
    virtualmachines = VirtualMachine.list_hosts
    virtualmachines.sort! do |r1, r2|
      case sort_order
      when 'hostname'
        r1.hostname.downcase <=> r2.hostname.downcase
      when 'description'
        r1.description.downcase <=> r2.description.downcase
      when 'flavor'
        r1.flavor.downcase <=> r2.flavor.downcase
      end
    end

    output_virtualmachines_table(virtualmachines)

    puts "Sort using: 'list hosts' or 'list by hosts'\n\n"
  end
    
  def introduction
    puts "\n\n<<< Welcome to Chef Zorro >>>\n\n"
    puts "This guide will help you create your Virtual Machines for testing with chef zero (aka zorro).\n\n"
  end

  def conclusion
    puts "\n<<< Goodbye and Bon Appetit! >>>\n\n\n"
    puts "                   -- Zorro \n\n"
  end
  
  private
  
  def output_action_header(text)
    puts "\n#{text.upcase.center(60)}\n\n"
  end
  
  def output_virtualmachines_table(virtualmachines)
    print " " + "Name".ljust(10)
    print " " + "Description".ljust(30)
    print " " + "Flavor".rjust(6) + "\n"
    puts "-" * 60
    
    virtualmachines.each do |virtualmachine|
      line = " " + virtualmachine.hostname.ljust(10)
      line << " " + virtualmachine.description.ljust(30)
      line << " " + virtualmachine.flavor.rjust(6)
      puts line
    end
    puts "No listings found" if virtualmachines.empty?
    puts "-" * 60
  end
  
end
