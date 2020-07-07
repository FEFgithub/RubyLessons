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

def print_list_actions
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
$global_list_all_stations = [Station.new('first_st'), Station.new('lust_st')]
$global_list_all_trains = [Train.new(1, 'cargo'), Train.new(2, 'passenger')]
$global_list_all_routes = [Route.new(Station.new('first_st'), Station.new('lust_st'))]

def print_global_list_all_stations
  cout_stations = 1
      $global_list_all_stations.each do |station|
        puts "#{cout_stations} -- #{station.title}" 
        cout_stations += 1
      end
end

def prin_global_list_all_trains
  cout_trains = 1
      $global_list_all_trains.each do |train|
        puts "#{cout_trains} -- #{train.train_type} train N#{train.number}" 
        cout_trains += 1
      end
end

def prin_global_list_all_routes
  cout_routes = 1
      $global_list_all_routes.each do |route|
        puts "#{cout_routes} -- #{route.stations.each { |s| print s.title }}" 
        cout_routes += 1
      end
end

print_list_actions
action = get_action
while !action.zero?
  case action
    when 1 
      puts 'Enter title for station'
      title = gets.chomp
      $global_list_all_stations << Station.new(title)
      print_global_list_all_stations
    when 2 
      puts 'Enter number for train'
      number = Integer(gets) 
      puts 'Enter train_type ("passenger" or "cargo") for train'
      train_type = gets.chomp 
      if train_type == "passenger" || train_type == "cargo"
        train = Train.new(number, train_type)
        $global_list_all_trains << train
        prin_global_list_all_trains
      else
        puts 'Enter correct type!'
      end
    when 3  
      print_global_list_all_stations
      puts "Select from this list first station for your route"
      first_index = gets.to_i
      puts "Select from this list last station for your route"
      last_index = gets.to_i
      route = Route.new($global_list_all_stations[first_index - 1], $global_list_all_stations[last_index - 1])
      $global_list_all_routes << route
      puts "successfully created route: #{$global_list_all_routes.last.stations.each { |station| station.title }}"
    when 31
      prin_global_list_all_routes
      puts "Select from this list route for add station"
      route_index = gets.to_i
      print_global_list_all_stations
      puts "Select from this list station for include in route N#{route_index}"
      station_index = gets.to_i
      $global_list_all_routes[route_index - 1].add_station($global_list_all_stations[station_index - 1])
      puts $global_list_all_routes[route_index - 1].stations
    when 32
      prin_global_list_all_routes
      puts "Select from this list route for delete station"
      route_index = gets.to_i
      print_global_list_all_stations
      puts "Select from this list station for delete in route N#{route_index}"
      station_index = gets.to_i
      $global_list_all_routes[route_index - 1].delete_station($global_list_all_stations[station_index - 1])
      puts $global_list_all_routes[route_index - 1].stations
    when 0 
      break
    else
      puts 'Wrong! Enter correct number for action!'
  end
  print_list_actions
  action = get_action
end
