class PassengerWagon
  require_relative 'all_modules'
  
  include NameCompany
  include InstanceCounter
  
  attr_reader :type
  attr_accessor :places
  
  def initialize(places)
    @type = 'passenger'
    @places0 = places
    @places = places
    register_instance
  end

  def close_place
    @places -= 1
  end

  def closed_places
    @places0 - @places if @places0 >= @places
  end

  def free_places
    @places
  end
end
