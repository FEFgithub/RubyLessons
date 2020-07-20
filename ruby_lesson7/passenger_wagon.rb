class PassengerWagon < Wagon
  
  def initialize(places)
    @type = 'passenger'
    super(places)
  end

  def close_some_place
    super(1)
  end
end
