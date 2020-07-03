class Train
  attr_accessor :speed
  attr_reader :number, :train_type, :wagon_count

  def initialize(number, train_type, wagon_count)
    @number = number
    @train_type = train_type
    @wagon_count = wagon_count
    @index_position = 0
  end  

  def train_stop
    self.speed = 0
  end

  def add_wagon
    @wagon_count += 1 if @speed == 0
  end

  def delete_wagon
    @wagon_count -= 1 if @wagon_count > 0 && @speed == 0
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
end

