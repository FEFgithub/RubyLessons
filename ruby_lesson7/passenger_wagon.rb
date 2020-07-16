class PassengerWagon
  require_relative 'all_modules'
  
  include NameCompany
  include InstanceCounter
  
  attr_reader :type
  
  def initialize
    @type = 'passenger'
    register_instance
  end
end
