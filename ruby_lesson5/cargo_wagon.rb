class CargoWagon
  require_relative 'all_modules'
  
  include NameCompany
  
  attr_reader :type
  
  def initialize
    @type = 'cargo'
  end
end
