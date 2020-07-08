class Train
  # Нет private/protected методов, так как все методы 
  # входят в интерфейс пользователя 
  attr_accessor :speed, :index_position
  attr_reader :number, :train_type, :list_wagons

  def initialize(number, train_type)
    @number = number
    @train_type = train_type
    @index_position = 0
    @list_wagons = []
  end

  def train_stop
    @speed = 0
  end

  def set_route(route)
    @route = route
    @index_position = 0
  end

  def move_forward
    if next_station
      current_station.train_out(self)
      @index_position += 1 if @index_position < @route.stations.size
      current_station.train_in(self)
    end
  end

  def move_back
    if prev_station
      current_station.train_out(self)
      @index_position -= 1 if @index_position > 0
      current_station.train_in(self)
    end                  
  end

  def prev_station
    @route.stations[@index_position - 1] if @index_position > 0
  end

  def current_station
    @route.stations[@index_position]
  end

  def next_station
    @route.stations[@index_position + 1] 
  end

  def add_wagon (wagon)
    @list_wagons << wagon if @train_type == wagon.type && @speed.zero? 
  end
  
  def delete_wagon (wagon)
    @list_wagons.delete(wagon) if @train_type == wagon.type && @speed.zero? 
  end
end
