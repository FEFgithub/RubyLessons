class Wagon
  require_relative 'all_modules'

  include NameCompany
  include InstanceCounter

  attr_accessor :type, :capacity

  def initialize(capacity)
    @capacity0 = capacity
    @capacity = capacity
    register_instance
  end

  def close_capacity(capacity)
    @capacity -= capacity if @capacity >= capacity
  end

  def closed_capacity
    @capacity0 - @capacity
  end
end
