class CargoWagon < Wagon
  def initialize(volume)
    @type = 'cargo'
    super(volume)
  end
end
