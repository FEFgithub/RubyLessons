=begin
1) Разбить программу на отдельные классы (каждый класс в отдельном файле)
2) Разделить поезда на два типа PassengerTrain и CargoTrain, сделать родителя для классов, 
который будет содержать общие методы и свойства
3) Определить, какие методы могут быть помещены в private/protected и вынести их в такую 
секцию. В комментарии к методу обосновать, почему он был вынесен в private/protected
4) Вагоны теперь делятся на грузовые и пассажирские (отдельные классы). К пассажирскому 
поезду можно прицепить только пассажирские, к грузовому - грузовые. 
5) При добавлении вагона к поезду, объект вагона должен передаваться как аргумент метода 
и сохраняться во внутреннем массиве поезда, в отличие от предыдущего задания, где мы 
считали только кол-во вагонов. Параметр конструктора "кол-во вагонов" при этом можно удалить.
Добавить текстовый интерфейс:
Создать программу в файле main.rb, которая будет позволять пользователю через текстовый интерфейс делать следующее:
     - Создавать станции
     - Создавать поезда
     - Создавать маршруты и управлять станциями в нем (добавлять, удалять)
     - Назначать маршрут поезду
     - Добавлять вагоны к поезду
     - Отцеплять вагоны от поезда
     - Перемещать поезд по маршруту вперед и назад
     - Просматривать список станций и список поездов на станции
=end
require_relative 'station'
require_relative 'route'
require_relative 'train'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'passenger_wagon'
require_relative 'cargo_wagon'


class Interface
  def initialize
    @stations = []
    @trains = []
    @routes = []
  end

  def print_actions
    puts 'Press: 
          1 - for create station, 
          2 - for create train, 
          3 - for create route, 
          31 - for add station in route,
          32 - for delete station in route, 
          4 - for set route on train, 
          51 - for add wagon in train, 
          52 - for delete wagon in train, 
          61 - for move train in forward on the route, 
          62 - for move train in back on the route, 
          7 - for watch list all station and trains on the station,
          0 - for exit.' 
  end

  def print_stations
    @stations.each.with_index(1) do |station, index|
      puts "#{index} -- #{station.title}" 
    end
  end
  
  def print_trains 
    @trains.each.with_index(1) do |train, index|
      puts "#{index} -- #{train.train_type} train N#{train.number}" 
    end
  end
  
  def print_routes
    @routes.each.with_index(1) do |route, index|
      puts "#{index} -- #{route}: #{route.first_station.title} - #{route.last_station.title}" 
    end
  end

  def select_station
    print_stations
    index = Integer(gets) - 1
    @stations[index]
  end

  def select_train
    print_trains
    index = Integer(gets) - 1
    @trains[index]
  end

  def select_route
    print_routes
    index = Integer(gets) - 1
    @routes[index]
  end

  def action_create_station
    go_again = 1
    while !go_again.zero?
      puts 'List stations before change:'
      print_stations
      puts 'Enter title for station'
      title = gets.chomp
      @stations << Station.new(title)
      puts 'List stations after change:'
      print_stations
      puts 'Create station again? (yes - 1, no - 0)'
      go_again = Integer(gets)
    end
  end

  def action_create_train
    go_again = 1
    while !go_again.zero?
      puts 'List trains before change:'
      print_trains
      puts 'Enter number for train'
      number = Integer(gets) 
      puts 'Enter train_type ("passenger" or "cargo") for train'
      train_type = gets.chomp 
      if train_type == 'passenger' || train_type == 'cargo'
        train = Train.new(number, train_type)
        @trains << train
      else
        puts 'Enter correct train_type!'
      end
      puts 'List trains after change:'
      print_trains
      puts 'Create train again? (yes - 1, no - 0)'
      go_again = Integer(gets)
    end
  end

  def action_create_route
    go_again = 1
    while !go_again.zero?
      puts 'List routes before change:'
      print_routes
      if @stations.size.zero?
        puts 'Create minimum 2 stations!'
      else
        puts 'Select from this list first station'
        first_station = select_station
        puts 'Select from this list last station'
        last_station = select_station
        route = Route.new(first_station, last_station)
        @routes << route
      end
      puts 'List routes after change:'
      print_routes
      puts 'Create route again? (yes - 1, no - 0)'
      go_again = Integer(gets)
    end
  end

  def action_add_station_in_route
    go_again = 1
    while !go_again.zero?
      puts 'Select route for add station'
      route = select_route
      puts 'Stations in this route before:'
      route.print_all_stations
      puts 'Select station'
      station = select_station
      if route.stations.include?(station)
        puts 'Station already included in the route'
      else 
        route.add_station(station)
      end
      puts 'Stations in this route after:'
      route.print_all_stations
      puts 'Add station in route again? (yes - 1, no - 0)'
      go_again = Integer(gets)
    end
  end

  def action_delete_station_in_route
    go_again = 1
    while !go_again.zero?
      puts 'Select route for delete station'
      route = select_route
      puts 'Stations in this route before:'
      route.print_all_stations
      puts 'Select station'
      station = select_station
      if route.stations.size.zero?
        puts 'Route do not have stations'
        break
      else 
        route.delete_station(station)
      end
      puts 'Stations in this route after:'
      route.print_all_stations
      puts 'Delete station in route again? (yes - 1, no - 0)'
      go_again = Integer(gets)
    end
  end

  def action_set_route_on_train
    go_again = 1
    while !go_again.zero?
      puts 'Select from this list route for set route on train'
      route = select_route
      puts 'Select from this list train, each will be given route'
      train = select_train
      train.set_route(route)
      puts "route #{route} set on train N#{train.number}"  
      puts 'Set route on train again? (yes - 1, no - 0)'
      go_again = Integer(gets)
    end
  end

  def action_add_wagon_in_train
    go_again = 1
    while !go_again.zero?
      puts "Write type wagon ('cargo' or 'passenger') for add"
      type_wagon = gets.chomp
      puts 'Select from this list train'
      train = select_train
      if train.train_type == type_wagon
        puts "List wagons before: #{train.list_wagons}"
        train.train_stop
        if type_wagon == 'cargo'
          cargo_w = CargoWagon.new
          train.add_wagon(cargo_w)
        elsif type_wagon == 'passenger'
          passenger_w = PassengerWagon.new
          train.add_wagon(passenger_w)
        end  
        puts "List wagons after: #{train.list_wagons}"
      else
        puts 'Type wagon and train is different!'
      end
      puts 'Add wagon in train again? (yes - 1, no - 0)'
      go_again = Integer(gets)
    end
  end

  def action_delete_wagon_in_train
    go_again = 1
    while !go_again.zero?
      puts 'Select from this list train'
      train = select_train
      if train.list_wagons.size.zero?
        puts 'Train do not have wagons!'
        break
      else
        puts 'Select wagon for delete'
        train.list_wagons.each.with_index(1) do |wag, index|
          puts "#{index} -- #{wag} -- #{wag.type}"
        end
        index_wagon = Integer(gets) - 1 
        train.delete_wagon(train.list_wagons[index_wagon]) 
        puts 'List wagons after deleted:'
        train.list_wagons.each.with_index(1) do |wag, index|
          puts "#{index} -- #{wag} -- #{wag.type}"
        end
        puts 'Delete wagon in train again? (yes - 1, no - 0)'
        go_again = Integer(gets)
      end
    end
  end

  def action_move_train_in_forward
    go_again = 1
    while !go_again.zero?
      puts 'Select from this list train'
      train = select_train
      puts 'Select from this list route'
      route = select_route
      train.set_route(route)
      forward = 1
      while !forward.zero? 
        puts "Prev station - #{train.current_station.title}"
        train.move_forward
        puts "Current station - #{train.current_station.title}"
        puts "move forward again? (yes - 1, no - 0)"
        forward = Integer(gets)
      end
      puts 'Move other train again? (yes - 1, no - 0)'
      go_again = Integer(gets)
    end
  end

  def action_move_train_in_back
    go_again = 1
    while !go_again.zero?
      puts 'Select from this list train'
      train = select_train
      puts 'Select from this list route'
      route = select_route
      train.set_route(route)
      train.index_position = route.stations.size - 1
      back = 1
      while !back.zero? 
        puts "Prev station - #{train.current_station.title}"
        train.move_back
        puts "Current station - #{train.current_station.title}"
        puts "move back again? (yes - 1, no - 0)"
        back = Integer(gets)
      end  
      puts 'Move other train again? (yes - 1, no - 0)'
      go_again = Integer(gets)
    end
  end

  def action_add_delete_train_on_station
    puts 'Select from this list station for watch all train on her, add or delete train'
    station = select_station
    go_again = 1
    while !go_again.zero?
      if go_again == 1
        puts 'Select from this list train for add'
        train = select_train
        station.train_in(train)
        station.print_list_of_all_trains
        puts 'Again? (yes, add train - 1, yes, delete train - 2, no - 0)'
        go_again = Integer(gets)
      elsif go_again == 2
        puts 'Select from this list train for delete'
        train = select_train
        station.train_out(train)
        station.print_list_of_all_trains
        puts 'Again? (yes, add train - 1, yes, delete train - 2, no - 0)'
        go_again = Integer(gets)
      end
    end
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
      train1 = Train.new(1, 'passenger')
      train2 = Train.new(2, 'cargo')
      train3 = Train.new(3, 'passenger')
      train4 = Train.new(4, 'cargo')
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
        when 31
          action_add_station_in_route
        when 32
          action_delete_station_in_route
        when 4
          action_set_route_on_train
        when 51
          action_add_wagon_in_train
        when 52
          action_delete_wagon_in_train
        when 61
          action_move_train_in_forward
        when 62
          action_move_train_in_back
        when 7
          action_add_delete_train_on_station
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
