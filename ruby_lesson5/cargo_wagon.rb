class CargoWagon
  require_relative 'all_modules'
  
  include NameCompany
  include InstanceCounter
  
  attr_reader :type
  
  def initialize
    @type = 'cargo'
    register_instance
  end
end
