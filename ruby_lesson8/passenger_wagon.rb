class PassengerWagon < Wagon
  def initialize(capacity)
    @type = 'passenger'
    super(capacity)
  end

  def close_capacity
    super(1)
  end
end
