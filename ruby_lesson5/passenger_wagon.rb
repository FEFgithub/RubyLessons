class PassengerWagon
  require_relative 'all_modules'
  
  include NameCompany
  
  attr_reader :type
  
  def initialize
    @type = 'passenger'
  end
end
