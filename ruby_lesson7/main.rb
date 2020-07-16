=begin
1) Реализовать проверку (валидацию) данных для всех классов. 
Проверять основные атрибуты (название, номер, тип и т.п.) на 
наличие, длину и т.п. (в зависимости от атрибута):
  - Валидация должна вызываться при создании объекта, если 
  объект невалидный, то должно выбрасываться исключение
  - Должен быть метод valid? который возвращает true, если 
  объект валидный и false - в противном случае.
2) Релизовать проверку на формат номера поезда. Допустимый 
формат: три буквы или цифры в любом порядке, необязательный 
дефис (может быть, а может нет) и еще 2 буквы или цифры после 
дефиса.
3) Убрать из классов все puts (кроме методов, которые и должны 
что-то выводить на экран), методы просто возвращают значения. 
(Начинаем бороться за чистоту кода).
4) Релизовать простой текстовый интерфейс для создания поездов 
(если у вас уже реализован интерфейс, то дополнить его):
  - Программа запрашивает у пользователя данные для создания 
  поезда (номер и другие необходимые атрибуты)
  - Если атрибуты валидные, то выводим информацию о том, что 
  создан такой-то поезд
  - Если введенные данные невалидные, то программа должна 
  вывести сообщение о возникших ошибках и заново запросить 
  данные у пользователя. Реализовать это через механизм 
  обработки исключений
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
          4 - for add station in route,
          5 - for delete station in route, 
          6 - for set route on train, 
          7 - for add wagon in train, 
          8 - for delete wagon in train, 
          9 - for move train in forward on the route, 
          10 - for move train in back on the route, 
          11 - for watch list all station and trains on the station,
          12 - for set name company (train, wagon), 
          13 - for get all stations,
          14 - for get train by number,
          15 - for get all trains and wagons,
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
      begin
        station = Station.new(title)
        puts "Station with title #{title} created!"
        @stations << station
      rescue RuntimeError => e
        puts e.message 
      end
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
      begin
        puts 'Enter number for train'
        number = gets.chomp 
        puts 'Enter train_type ("passenger" or "cargo") for train'
        train_type = gets.chomp 
        puts 'Add wagon in train? (yes - 1, no - 0)'
        add_wagon10 = Integer(gets)
        if train_type == 'passenger'
          if add_wagon10 == 1
            train = PassengerTrain.new(number, 'passenger', PassengerWagon.new)
            @trains << train
          elsif add_wagon10 == 0
            train = PassengerTrain.new(number)
            @trains << train
          else
            puts 'Enter 1 or 0'
          end 
        elsif train_type == 'cargo'
          if add_wagon10 == 1
            train = CargoTrain.new(number, 'cargo', CargoWagon.new)
            @trains << train
          elsif add_wagon10 == 0
            train = CargoTrain.new(number)
            @trains << train
          else
            puts 'Enter 1 or 0'
          end
        else
          puts 'Enter correct train_type!'
        end
        puts "#{train.train_type} train number #{train.number} created"
      rescue RuntimeError => e
        puts e.message
        retry
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

  def action_set_get_name_company
    go_again = 1
    while !go_again.zero?
      puts 'Select from this list train'
      train = select_train
      puts 'If set name company - 1, if get name company - 0'
      set_get = Integer(gets)
      if set_get == 1 
        puts 'Set name company for this train'
        name = gets.chomp
        train.name_company= name
        puts "Train N#{train.number} created in company #{train.name_company}"
      elsif set_get.zero?
        puts "Train N#{train.number} created in company #{train.name_company}"
      else
        puts 'Enter 1 or 0!'  
      end
      puts 'Set/get name company again? (yes - 1, no - 0)'
      go_again = Integer(gets)
    end
  end

  def action_get_all_stations
    puts "Was created #{Station.all} stations"
  end

  def action_get_train_by_number
    go_again = 1
    while !go_again.zero?
      puts 'Enter train number'
      number = Integer(gets)
      puts "Train - #{Train.find(number)}"
      puts 'Get train by number again? (yes - 1, no - 0)'
      go_again = Integer(gets)
    end
  end

  def action_get_all_trains_and_wagons
    puts "Created cargo trains: #{CargoTrain.instances}, passenger trains: #{PassengerTrain.instances},
        cargo wagons: #{CargoWagon.instances}, passenger wagons #{PassengerWagon.instances}."
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
      train1 = PassengerTrain.new('111-11', 'passenger', PassengerWagon.new)
      train2 = CargoTrain.new('222-22', 'cargo', CargoWagon.new)
      train3 = PassengerTrain.new('333-33', 'passenger', PassengerWagon.new)
      train4 = CargoTrain.new('444-44', 'cargo', CargoWagon.new)
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
