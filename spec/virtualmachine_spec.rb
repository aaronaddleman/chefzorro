require 'spec_helper'
 
describe VirtualMachine do
  before :each do
      @basic_vm = VirtualMachine.new(:hostname => "Hostname",
                                     :description => "This is about the host",
                                     :flavor => "m1.small")

      # @ = VirtualMachine.new
      
      @hosts = [
        VirtualMachine.new(:hostname => "Hostname1",
                               :description => "This is about the host",
                               :flavor => "m1.small"),
        VirtualMachine.new(:hostname => "Hostname2",
                               :description => "This is about the host",
                               :flavor => "m1.small"),
        VirtualMachine.new(:hostname => "Hostname3",
                               :description => "This is about the host",
                               :flavor => "m1.small")
      ]

  end

  describe "#new" do
    it "take three paramaters to create a VirtualMachine" do
      expect(@basic_vm.class).to eq(VirtualMachine)
    end
  end

  describe "#hostname" do
    it "returns the correct hostname" do
      expect(@basic_vm.hostname).to eq("Hostname")
    end
  end

  describe "#description" do
    it "returns the correct description" do
      expect(@basic_vm.description).to eq("This is about the host")
    end
  end

  describe "#flavor" do
    it "returns the correct flavor" do
      expect(@basic_vm.flavor).to eq("m1.small")
    end
  end

end

