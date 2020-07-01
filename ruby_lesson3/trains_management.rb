=begin
Класс Station (Станция):
  Имеет название, которое указывается при ее создании
  Может принимать поезда (по одному за раз)
  Может возвращать список всех поездов на станции, находящиеся в текущий момент
  Может возвращать список поездов на станции по типу (см. ниже): кол-во грузовых, пассажирских
  Может отправлять поезда (по одному за раз, при этом, поезд удаляется из списка поездов, находящихся на станции).

Класс Route (Маршрут):
  Имеет начальную и конечную станцию, а также список промежуточных станций. Начальная и конечная станции указываютсся при создании маршрута, а промежуточные могут добавляться между ними.
  Может добавлять промежуточную станцию в список
  Может удалять промежуточную станцию из списка
  Может выводить список всех станций по-порядку от начальной до конечной

Класс Train (Поезд):
  Имеет номер (произвольная строка) и тип (грузовой, пассажирский) и количество вагонов, эти данные указываются при создании экземпляра класса
  Может набирать скорость
  Может возвращать текущую скорость
  Может тормозить (сбрасывать скорость до нуля)
  Может возвращать количество вагонов
  Может прицеплять/отцеплять вагоны (по одному вагону за операцию, метод просто увеличивает или уменьшает количество вагонов). Прицепка/отцепка вагонов может осуществляться только если поезд не движется.
  Может принимать маршрут следования (объект класса Route). 
  При назначении маршрута поезду, поезд автоматически помещается на первую станцию в маршруте.
  Может перемещаться между станциями, указанными в маршруте. Перемещение возможно вперед и назад, но только на 1 станцию за раз.
  Возвращать предыдущую станцию, текущую, следующую, на основе маршрута
=end


class Station
  attr_reader :title_station

  def initialize(title_station)
    @title_station = title_station
    @trains_list_on_station = []
    @var_for_time = Time.new
  end
  
  def train_in(some_train)
    @trains_list_on_station << some_train
    puts "Поезд номер #{some_train.train_number} прибыл на станцию #{@title_station} в #{@var_for_time.inspect}"
  end

  def train_out(some_train)
    @trains_list_on_station - [some_train]
    puts "Поезд номер #{some_train.train_number} отправился со станции #{@title_station} в #{@var_for_time.inspect}"
  end

  def print_list_of_all_trains
    @trains_list_on_station.each { |train| puts "На станции #{@title_station} поезд номер #{train.train_number}" }
    puts "Всего поездов на станции #{@title_station} - #{@trains_list_on_station.size}"
  end

  def print_list_of_special_trains
    count_train1 = 0
    count_train2 = 0
    @trains_list_on_station.each do |train|
      if train.train_type == 'грузовой'
        puts "На станции #{@title_station} грузовой поезд номер #{train.train_number}"
        count_train1 += 1 
      elsif train.train_type == 'пассажирский'  
        puts "На станции #{@title_station} пассажирский поезд номер #{train.train_number}"
        count_train2 += 1
      end 
    end
    puts "На станции #{@title_station} #{count_train1} грузовых поездов"
    puts "На станции #{@title_station} #{count_train2} пассажирских поездов"
  end
end


class Route
  attr_reader :first_station
  attr_reader :last_station
  attr_reader :list_inner_stations

  def initialize(first_station, last_station)
    @first_station = first_station
    @last_station = last_station
    @list_inner_stations = []
  end  

  def add_inner_station(station)
    @list_inner_stations << station
    puts "Станция #{station.title_station} добавлена в маршрут"
  end

  def delete_inner_station(station)
    @list_inner_stations - [station]
    puts "Станция #{station.title_station} удалена из маршрута"
  end

  def print_all_stations
    puts "Начальная станция: #{@first_station.title_station}"
    @list_inner_stations.each { |station| puts "Промежуточная станция: #{station.title_station}" }
    puts "Конечная станция: #{@last_station.title_station}"
  end
end


class Train
  attr_accessor :speed
  attr_reader :train_number
  attr_reader :train_type
  attr_reader :wagon_count

  def initialize(train_number, train_type, wagon_count)
    @train_number = train_number
    @train_type = train_type
    @wagon_count = wagon_count
    @route = nil
  end  

  def train_stop
    speed = 0
  end

  def add_wagon
    @wagon_count += 1
  end

  def delete_wagon
    @wagon_count -= 1
  end

  def set_route(route)
    @route = route
  end

  def move_forward
  end

  def move_back
  end

  def get_information
    puts "Предыдущая станция - #{}"
    puts "Текущая станция - #{}"
    puts "Следующая станция - #{}"
  end
end

train1 = Train.new(1, 'пассажирский', 10)
train2 = Train.new(2, 'пассажирский', 11)
train3 = Train.new(3, 'грузовой', 20)
train4 = Train.new(4, 'грузовой', 21)

route = Route.new('Начальная', 'Конечная')

station1 = Station.new('Станция1')
station2 = Station.new('Станция2')
station3 = Station.new('Станция3')

station1.train_in(train1)
station1.train_in(train2)
station1.train_in(train3)
station1.train_in(train4)

station1.train_out(train2)

station1.print_list_of_all_trains
station1.print_list_of_special_trains


