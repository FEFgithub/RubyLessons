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
  
def get_action
  gets.to_i
end
# default values
$stations = [Station.new('first_st'), Station.new('lust_st')]
$trains = [Train.new(1, 'cargo'), Train.new(2, 'passenger')]
$routes = [Route.new(Station.new('first_st'), Station.new('lust_st'))]

def print_stations
  cout_stations = 1
      $stations.each do |station|
        puts "#{cout_stations} -- #{station.title}" 
        cout_stations += 1
      end
end

def prin_trains
  cout_trains = 1
      $trains.each do |train|
        puts "#{cout_trains} -- #{train.train_type} train N#{train.number}" 
        cout_trains += 1
      end
end

def prin_routes
  cout_routes = 1
      $routes.each do |route|
        puts "#{cout_routes} -- #{route}" 
        cout_routes += 1
      end
end

print_actions
action = get_action
while !action.zero?
  case action
    when 1 
      puts 'Enter title for station'
      title = gets.chomp
      $stations << Station.new(title)
      print_stations
    when 2 
      puts 'Enter number for train'
      number = Integer(gets) 
      puts 'Enter train_type ("passenger" or "cargo") for train'
      train_type = gets.chomp 
      if train_type == "passenger" || train_type == "cargo"
        train = Train.new(number, train_type)
        $trains << train
        prin_trains
      else
        puts 'Enter correct train_type!'
      end
    when 3  
      print_stations
      puts "Select from this list first station for your route"
      first_index = Integer(gets)
      puts "Select from this list last station for your route"
      last_index = Integer(gets)
      route = Route.new($stations[first_index - 1], $stations[last_index - 1])
      $routes << route
      puts "successfully created route: #{$routes.last.stations.each { |station| station.title }}"
    when 31
      prin_routes
      puts "Select from this list route for add station"
      route_index = Integer(gets)
      print_stations
      puts "Select from this list station for include in route N#{route_index}"
      station_index = Integer(gets)
      $routes[route_index - 1].add_station($stations[station_index - 1])
      puts $routes[route_index - 1].print_stations
    when 32
      prin_routes
      puts "Select from this list route for delete station"
      route_index = Integer(gets)
      print_stations
      puts "Select from this list station for delete in route N#{route_index}"
      station_index = Integer(gets)
      $routes[route_index - 1].delete_station($stations[station_index - 1])
      puts $routes[route_index - 1].print_stations
    when 4
      prin_routes
      puts "Select from this list route for set route on train"
      route_index = Integer(gets)
      prin_trains
      puts "Select from this list train, each will be given route"
      train_index = Integer(gets)
      $trains[train_index - 1].set_route($routes[route_index - 1])
      puts "route #{$routes[route_index - 1]} set on train N#{$trains[train_index - 1].number}"  
    when 51
      puts "Write type wagon ('cargo' or 'passenger') for add"
      type_wagon = gets.chomp
      prin_trains
      puts "Select from this list train"
      train_index = Integer(gets)
      if type_wagon == $trains[train_index - 1].train_type
        if type_wagon == 'cargo'
          cargo_w = CargoWagon.new
          $trains[train_index - 1].train_stop
          $trains[train_index - 1].add_wagon(cargo_w)
          puts $trains[train_index - 1].list_wagons
        elsif type_wagon == 'passenger'
          passenger_w = PassengerWagon.new
          $trains[train_index - 1].train_stop
          $trains[train_index - 1].add_wagon(passenger_w)
          puts $trains[train_index - 1].list_wagons
        else
          puts "Enter correct type for wagon!"
        end
      else
        puts "type wagon and train is different!"
      end
    when 52
      prin_trains
      puts "Select from this list train for delete wagon"
      train_index = Integer(gets)
      i_wag = 1
      $trains[train_index - 1].list_wagons.each do |wag|
        puts "#{i_wag} -- #{wag} -- #{wag.type}"
        i_wag += 1
      end
      puts "Select from this list wagon for delete"
      list_wagons_index = Integer(gets)
      if $trains[train_index - 1].list_wagons[list_wagons_index - 1].type == $trains[train_index - 1].train_type
        $trains[train_index - 1].train_stop
        $trains[train_index - 1].delete_wagon($trains[train_index - 1].list_wagons[list_wagons_index - 1])
        puts $trains[train_index - 1].list_wagons
      else
        puts "type wagon and train is different!"
      end
    when 61
      prin_trains
      puts "Select from this list train"
      train_index = Integer(gets)
      prin_routes
      puts "Select from this list route"
      route_index = Integer(gets)
      $trains[train_index - 1].set_route($routes[route_index - 1])
      forward = 1
      while !forward.zero? 
        puts "Prev station - #{$trains[train_index - 1].current_station.title}"
        $trains[train_index - 1].move_forward
        puts "Current station - #{$trains[train_index - 1].current_station.title}"
        puts "move forward again? (yes - 1, no - 0)"
        forward = Integer(gets)
      end
    when 62
      prin_trains
      puts "Select from this list train"
      train_index = Integer(gets)
      prin_routes
      puts "Select from this list route"
      route_index = Integer(gets)
      $trains[train_index - 1].set_route($routes[route_index - 1])
      $trains[train_index - 1].index_position = $routes[route_index - 1].stations.size - 1
      forward = 1
      while !forward.zero? 
        puts "Prev station - #{$trains[train_index - 1].current_station.title}"
        $trains[train_index - 1].move_back
        puts "Current station - #{$trains[train_index - 1].current_station.title}"
        puts "move back again? (yes - 1, no - 0)"
        forward = Integer(gets)
      end
    when 7
      print_stations
      puts 'Select from this list station for watch all train on her, add or delete train'
      station_index = Integer(gets)
      forward = 1
      while !forward.zero?
        if forward == 1 
          prin_trains
          puts "Select from this list train for add"
          train_index = Integer(gets)
          $stations[station_index - 1].train_in($trains[train_index - 1])
          $stations[station_index - 1].print_list_of_all_trains
          puts "again? (yes, add train - 1, yes, delete train - 2, no - 0)"
          forward = Integer(gets)
        elsif forward == 2
          prin_trains
          puts "Select from this list train for delete"
          train_index = Integer(gets)
          $stations[station_index - 1].train_out($trains[train_index - 1])
          $stations[station_index - 1].print_list_of_all_trains
          puts "again? (yes, add train - 1, yes, delete train - 2, no - 0)"
          forward = Integer(gets)
        else 
          break
        end
      end
    when 0 
      break
    else
      puts 'Wrong! Enter correct number for action!'
  end
  print_actions
  action = get_action
end
