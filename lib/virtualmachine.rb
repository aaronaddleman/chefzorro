require 'json'
# require 'openstack'

class VirtualMachine
  @@filepath = nil

  attr_accessor :hostname, :description, :flavor
  
  def initialize(args={})
    @hostname    = args[:hostname]    || ""
    @description = args[:description] || ""
    @flavor   = args[:flavor]   || ""
  end  

  def self.filepath=(path=nil)
    @@filepath = File.join(APP_ROOT, path)
  end
  
  def self.file_exists?
    # class should know if the virtualmachines file exists
    if @@filepath && File.exists?(@@filepath)
      return true
    else
      return false
    end
  end
  
  def self.file_usable?
    return false unless @@filepath
    return false unless File.exists?(@@filepath)
    return false unless File.readable?(@@filepath)
    return false unless File.writable?(@@filepath)
    return true
  end
  
  def self.create_file
    # create the virtualmachines file
    File.open(@@filepath, 'w') unless file_exists?
    return file_usable?
  end
  
  def self.list_hosts
    hosts = []
    if file_usable?
      # open file file as read only
      file = File.new(@@filepath, 'r')
      # look at the section called hosts
      imported_hosts = JSON.parse(file.read)["hosts"]
      # convert hosts into VirtualMachine objects
      imported_hosts.each do |name, attributes|
        puts "vm = #{attributes["hostname"]}"
        parsed_vm = self.new
        parsed_vm.hostname = attributes["hostname"]
        parsed_vm.description = attributes["description"]
        parsed_vm.flavor = attributes["flavor"]
        hosts << parsed_vm
      end
    end
    file.close
    puts "hosts = #{hosts}"
    return hosts
  end
      
  def self.build_using_questions
    args = {}
    print "Hostname: "
    args[:hostname] = gets.chomp.strip

    print "Description: "
    args[:description] = gets.chomp.strip
    
    print "Flavor: "
    args[:flavor] = gets.chomp.strip
    
    return self.new(args)
  end
  
end