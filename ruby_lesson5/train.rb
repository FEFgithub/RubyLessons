class Train
  # Нет private/protected методов, так как все методы 
  # входят в интерфейс пользователя 
  require_relative 'all_modules'


  include NameCompany
  include InstanceCounter


  attr_accessor :speed, :index_position, :wagon
  attr_reader :number, :train_type, :list_wagons

  @@hash_number_object = {}

  def initialize(number, train_type, wagon)
    @number = number
    @train_type = train_type
    @index_position = 0
    @wagon = wagon
    if @wagon.nil?
      @list_wagons = []
    else
      @list_wagons = []
      @list_wagons << @wagon
    end
    @@hash_number_object[number] = self 
    register_instance
  end

  def self.find(number)
    if @@hash_number_object.key?(number)
      @@hash_number_object[number]
    else
      nil
    end
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
    self.train_stop
    @list_wagons << wagon if @train_type == wagon.type && @speed.zero? 
  end
  
  def delete_wagon (wagon)
    self.train_stop
    @list_wagons.delete(wagon) if @train_type == wagon.type && @speed.zero? 
  end
end
