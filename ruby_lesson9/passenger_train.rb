class PassengerTrain < Train
  def initialize(number, train_type = 'passenger', wagon = nil)
    super(number, train_type, wagon)
  end
end
