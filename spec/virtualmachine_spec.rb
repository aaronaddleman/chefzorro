require 'spec_helper'
 
describe VirtualMachine do
  before :each do

    

    @basic_vm = VirtualMachine.new(:hostname => "Hostname",
                                   :description => "This is about the host",
                                   :flavor => "m1.small")
    
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
    it "should exist as a VirtualMachine class" do
      expect(@basic_vm.class).to eq(VirtualMachine)
    end
  end

  describe "#paramaters" do
    it "returns the correct paramaters" do
      expect(@basic_vm.hostname).to eq("Hostname")
      expect(@basic_vm.description).to eq("This is about the host")
      expect(@basic_vm.flavor).to eq("m1.small")
    end
  end

  describe "#filepath" do
    it "should accept a filepath" do
      expect(VirtualMachine.class_variable_get(:@@filepath)).to eq(nil)
    end
  end
end