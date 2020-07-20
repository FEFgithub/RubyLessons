=begin
Для пассажирских вагонов:
1) Добавить атрибут общего кол-ва мест (задается при создании 
  вагона)
2) Добавить метод, который "занимает места" в вагоне (по 
  одному за раз)
3) Добавить метод, который возвращает кол-во занятых мест в 
вагоне
4) Добавить метод, возвращающий кол-во свободных мест в вагоне.

Для грузовых вагонов:
1) Добавить атрибут общего объема (задается при создании вагона)
2) Добавить метод, которые "занимает объем" в вагоне (объем 
  указывается в качестве параметра метода)
3) Добавить метод, который возвращает занятый объем
4) Добавить метод, который возвращает оставшийся (доступный) 
объем

У класса Station:
1) написать метод, который принимает блок и проходит по всем 
поездам на станции, передавая каждый поезд в блок.

У класса Train:
1) написать метод, который принимает блок и проходит по всем 
вагонам поезда (вагоны должны быть во внутреннем массиве), 
передавая каждый объект вагона в блок.

 Если у вас есть интерфейс, то добавить возможности:
1) При создании вагона указывать кол-во мест или общий объем, 
в зависимости от типа вагона
2) Выводить список вагонов у поезда (в указанном выше формате), 
используя созданные методы
3) Выводить список поездов на станции (в указанном выше 
  формате), используя  созданные методы
4) Занимать место или объем в вагоне
=end

require_relative 'station'
require_relative 'route'
require_relative 'train'
require_relative 'wagon'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'passenger_wagon'
require_relative 'cargo_wagon'
require_relative 'all_modules'

include AllMainMethods

class Interface
  def initialize
    @stations = []
    @trains = []
    @routes = []
  end

  def menu
    puts 'Use templates for stations, trains and routes? (1 - yes, 0 - no)'
    use_template = Integer(gets)
    if use_template.zero?
      puts 'All lists is empty'
    else
      station1 = Station.new('Station_test1')
      station2 = Station.new('Station_test2')
      station3 = Station.new('Station_test3')
      @stations += [station1, station2, station3]
      train1 = PassengerTrain.new('111-11', 'passenger', PassengerWagon.new(20))
      train2 = CargoTrain.new('222-22', 'cargo', CargoWagon.new(10))
      train3 = PassengerTrain.new('333-33', 'passenger', PassengerWagon.new(20))
      train4 = CargoTrain.new('444-44', 'cargo', CargoWagon.new(10))
      @trains += [train1, train2, train3, train4]
      route1 = Route.new(station1, station2)
      route2 = Route.new(station1, station3)
      @routes += [route1, route2]
      puts 'Templates successfully created:'
      print_stations
      print_trains
      print_routes
    end
    print_actions
    action = Integer(gets)
    while !action.zero?
      case action
        when 1
          action_create_station
        when 2
          action_create_train
        when 3
          action_create_route
        when 4
          action_add_station_in_route
        when 5
          action_delete_station_in_route
        when 6
          action_set_route_on_train
        when 7
          action_add_wagon_in_train
        when 8
          action_delete_wagon_in_train
        when 9
          action_move_train_in_forward
        when 10
          action_move_train_in_back
        when 11
          action_add_delete_train_on_station
        when 12
          action_set_get_name_company
        when 13
          action_get_all_stations
        when 14
          action_get_train_by_number
        when 15 
          action_get_all_trains_and_wagons
        when 16
          action_get_list_wagons_in_train
        when 17
          action_get_list_trains_in_station
        when 18
          action_add_delete_place_volume_in_wagon
        when 0
          break
        else
          puts 'Wrong! Enter correct number for action!'   
      end
      print_actions
      action = Integer(gets)
    end
  end 
end

interface = Interface.new
interface.menu
