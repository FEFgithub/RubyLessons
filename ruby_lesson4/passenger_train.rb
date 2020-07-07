class PassengerTrain < Train 
  def initialize
    super(number, train_type)
    @train_type = 'passenger'
  end
  
  def add_wagon (wagon)
    @list_wagons << wagon if @train_type == wagon.type && @speed.zero? 
  end
  
  def delete_wagon (wagon)
    @list_wagons - [wagon] if @train_type == wagon.type && @speed.zero? 
  end
end
