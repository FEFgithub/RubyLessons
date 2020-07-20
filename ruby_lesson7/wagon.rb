class Wagon
  require_relative 'all_modules'
  
  include NameCompany
  include InstanceCounter
  
  attr_accessor :type, :some_place
  
  def initialize(some_place)
    @some_place0 = some_place
    @some_place = some_place
    register_instance
  end

  def close_some_place(some_place)
    @some_place -= some_place if @some_place >= some_place  
  end

  def closed_some_place
    @some_place0 - @some_place 
  end
end
