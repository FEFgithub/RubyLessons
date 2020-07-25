class CargoTrain < Train
  def initialize(number, train_type = 'cargo', wagon = nil)
    super(number, train_type, wagon)
  end
end
