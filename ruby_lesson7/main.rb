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
          11 - for add/delete train on station,
          12 - for set name company (train, wagon), 
          13 - for get all stations,
          14 - for get train by number,
          15 - for get all trains and wagons,
          16 - for get list wagons in train,
          17 - for get list trains in station,
          18 - for add/delete place/volume in wagon,
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
          begin
          puts 'Enter volume for wagon'
          volume = Float(gets)
          rescue Exception => e
            puts e.message
            retry
          end
          cargo_w = CargoWagon.new(volume)
          train.add_wagon(cargo_w)
        elsif type_wagon == 'passenger'
          begin
          puts 'Enter number free place for passengers'
          places = Integer(gets)
          rescue Exception => e
            puts e.message
            retry
          end
          passenger_w = PassengerWagon.new(places)
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

  def action_get_list_wagons_in_train
    go_again = 1
    while !go_again.zero?
      puts 'Select from this list train'
      train = select_train
      train.add_wagon_in_block do |wagon| 
        puts "#{wagon.type} wagon, places - #{wagon.places}" if wagon.type == 'passenger'
        puts "#{wagon.type} wagon, volume - #{wagon.volume}" if wagon.type == 'cargo' 
      end
      puts 'Get list wagons in train again? (yes - 1, no - 0)'
      go_again = Integer(gets)
    end
  end

  def action_get_list_trains_in_station
    go_again = 1
    while !go_again.zero?
      puts 'Select from this list station'
      station = select_station
      station.add_train_in_block do |train| 
        puts "#{train.train_type} train N#{train.number}" 
      end
      puts 'Get list trains in station again? (yes - 1, no - 0)'
      go_again = Integer(gets)
    end
  end

  def select_wagon(train)
    wagon_count = 1
    train.add_wagon_in_block do |wagon| 
        puts "#{wagon_count} - #{wagon.type} wagon, places - #{wagon.places}" if wagon.type == 'passenger'
        puts "#{wagon_count} - #{wagon.type} wagon, volume - #{wagon.volume}" if wagon.type == 'cargo' 
        wagon_count += 1
      end
    index = Integer(gets) - 1
    train.list_wagons[index]
  end

  def action_add_delete_place_volume_in_wagon
    go_again = 1
    while !go_again.zero?
      puts 'Select from this list train'
      train = select_train
      puts 'Select from this list wagon'
      wagon = select_wagon(train)
      if wagon.type == 'cargo'
        puts "Free volume: #{wagon.volume}"
        begin
        puts 'Enter volume for add:'
        volume = Float(gets)
        rescue Exception => e
          puts e.message
          retry
        end
        wagon.close_volume(volume)
        puts "Free volume: #{wagon.volume}"
      else
        puts "Free places before: #{wagon.places}"
        wagon.close_place
        puts "Free places after: #{wagon.places}"
      end
      puts 'Add/delete place/volume in wagon again? (yes - 1, no - 0)'
      go_again = Integer(gets)
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
