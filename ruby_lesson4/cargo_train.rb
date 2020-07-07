class CargoTrain < Train
  def initialize
    super(number, train_type)
    @train_type = 'cargo'
  end
end
