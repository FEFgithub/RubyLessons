class CargoWagon < Wagon
  def initialize(capacity)
    @type = 'cargo'
    super(capacity)
  end
end
