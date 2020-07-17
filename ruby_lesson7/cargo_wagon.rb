class CargoWagon
  require_relative 'all_modules'
  
  include NameCompany
  include InstanceCounter
  
  attr_reader :type
  attr_accessor :volume
  
  def initialize(volume)
    @type = 'cargo'
    @volume0 = volume
    @volume = volume
    register_instance
  end

  def close_volume(volume)
    @volume -= volume if @volume >= volume
  end

  def closed_volume
    @volume0 - @volume 
  end

  def free_volume
    @volume
  end
end
