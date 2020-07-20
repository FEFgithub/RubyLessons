class Train
  # Нет private/protected методов, так как все методы 
  # входят в интерфейс пользователя 
  require_relative 'all_modules'


  include NameCompany
  include InstanceCounter


  attr_accessor :speed, :index_position, :wagon, :train_type
  attr_reader :number, :list_wagons

  @@hash_number_object = {}

  NUMBER_FORMAT = /^([a-zа-я]|\d){3}([-]|)([a-zа-я]|\d){2}$/i

  def initialize(number, train_type, wagon)
    @number = number
    @train_type = train_type
    @index_position = 0
    @wagon = wagon
    if @wagon.nil?
      @list_wagons = []
    else
      @list_wagons = []
      @list_wagons.push(@wagon)
    end
    @@hash_number_object[number] = self 
    register_instance
    validate!
  end

  def each_wagon(&block)
    list_wagons.each { |wagon| block.call(wagon) }
  end

  def valid?
    validate!
    true
  rescue
    false
  end

  def self.find(number)
    @@hash_number_object[number]
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

  protected
  def validate!
    raise 'Number can not be nil!' if number.nil?
    raise 'Number should be > 4 symbols!' if number.length < 5
    raise "Train type should be 'cargo' or 'passenger'!" if train_type != 'cargo' && train_type != 'passenger'
    raise 'Number uncorrect format! Enter 3 letters or numbers, - or empty and 2letters or numbers' if number !~ NUMBER_FORMAT 
  end
end
