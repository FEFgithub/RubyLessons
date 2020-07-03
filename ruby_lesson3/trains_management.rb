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

require_relative 'station'
require_relative 'route'
require_relative 'train'


train1 = Train.new(1, 'пассажирский', 10)
train2 = Train.new(2, 'пассажирский', 11)
train3 = Train.new(3, 'грузовой', 20)
train4 = Train.new(4, 'грузовой', 21)

station1 = Station.new('Станция1')
station2 = Station.new('Станция2')
station3 = Station.new('Станция3')
station4 = Station.new('Станция4')
station5 = Station.new('Станция5')
station6 = Station.new('Станция6')

route = Route.new(station1, station6)

station1.train_in(train1)
station1.train_in(train2)
station1.train_in(train3)
station1.train_in(train4)

station1.train_out(train2)

station1.print_list_of_all_trains
station1.print_list_of_special_trains("грузовой")

route.print_all_stations
route.add_station(station2)
route.add_station(station3)
route.add_station(station4)
route.add_station(station5)
route.print_all_stations
route.delete_station(station2)
route.delete_station(station4)
route.print_all_stations

train2.speed = 13
puts train2.speed
train2.train_stop
puts train2.speed
puts train2.wagon_count
train2.add_wagon
train2.add_wagon
train2.add_wagon
puts train2.wagon_count
train2.delete_wagon
puts train2.wagon_count
train2.set_route(route)
puts train2.current_station
train2.move_forward
puts train2.current_station
train2.move_forward
puts train2.current_station
train2.move_back
puts train2.current_station
train2.move_back
puts train2.current_station

route.stations.each { |st| p st.title }

