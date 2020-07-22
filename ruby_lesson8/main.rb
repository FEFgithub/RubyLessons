require_relative 'station'
require_relative 'route'
require_relative 'train'
require_relative 'wagon'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'passenger_wagon'
require_relative 'cargo_wagon'
require_relative 'all_modules'

class Interface
  include AllMainMethods

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
    until action.zero?
      case action
      when 1
        create_station
      when 2
        create_train
      when 3
        create_route
      when 4
        add_station_in_route
      when 5
        delete_station_in_route
      when 6
        set_route_on_train
      when 7
        add_wagon_in_train
      when 8
        delete_wagon_in_train
      when 9
        move_train_in_forward
      when 10
        move_train_in_back
      when 11
        add_delete_train_on_station
      when 12
        set_get_name_company
      when 13
        get_all_stations
      when 14
        get_train_by_number
      when 15
        get_all_trains_and_wagons
      when 16
        get_list_wagons_in_train
      when 17
        get_list_trains_in_station
      when 18
        add_delete_place_volume_in_wagon
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
