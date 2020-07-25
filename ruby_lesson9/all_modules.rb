module NameCompany
  attr_accessor :name_company
end

module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_accessor :instances
  end

  module InstanceMethods
    def register_instance
      self.class.instances = self.class.instances.to_i + 1
    end
  end
end

module AllMainMethods
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

  def create_station
    go_again = 1
    until go_again.zero?
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

  def create_train
    go_again = 1
    until go_again.zero?
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
            train = PassengerTrain.new(number, 'passenger', PassengerWagon.new(10))
            @trains << train
          elsif add_wagon10.zero?
            train = PassengerTrain.new(number)
            @trains << train
          else
            puts 'Enter 1 or 0'
          end
        elsif train_type == 'cargo'
          if add_wagon10 == 1
            train = CargoTrain.new(number, 'cargo', CargoWagon.new(10))
            @trains << train
          elsif add_wagon10.zero?
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

  def create_route
    go_again = 1
    until go_again.zero?
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

  def add_station_in_route
    go_again = 1
    until go_again.zero?
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

  def delete_station_in_route
    go_again = 1
    until go_again.zero?
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

  def set_route_on_train
    go_again = 1
    until go_again.zero?
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

  def add_wagon_in_train
    go_again = 1
    until go_again.zero?
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
          rescue StandardError => e
            puts e.message
            retry
          end
          cargo_w = CargoWagon.new(volume)
          train.add_wagon(cargo_w)
        elsif type_wagon == 'passenger'
          begin
            puts 'Enter number free place for passengers'
            places = Integer(gets)
          rescue StandardError => e
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

  def delete_wagon_in_train
    go_again = 1
    until go_again.zero?
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

  def move_train_in_forward
    go_again = 1
    until go_again.zero?
      puts 'Select from this list train'
      train = select_train
      puts 'Select from this list route'
      route = select_route
      train.set_route(route)
      forward = 1
      until forward.zero?
        puts "Prev station - #{train.current_station.title}"
        train.move_forward
        puts "Current station - #{train.current_station.title}"
        puts 'move forward again? (yes - 1, no - 0)'
        forward = Integer(gets)
      end
      puts 'Move other train again? (yes - 1, no - 0)'
      go_again = Integer(gets)
    end
  end

  def move_train_in_back
    go_again = 1
    until go_again.zero?
      puts 'Select from this list train'
      train = select_train
      puts 'Select from this list route'
      route = select_route
      train.set_route(route)
      train.index_position = route.stations.size - 1
      back = 1
      until back.zero?
        puts "Prev station - #{train.current_station.title}"
        train.move_back
        puts "Current station - #{train.current_station.title}"
        puts 'move back again? (yes - 1, no - 0)'
        back = Integer(gets)
      end
      puts 'Move other train again? (yes - 1, no - 0)'
      go_again = Integer(gets)
    end
  end

  def add_delete_train_on_station
    puts 'Select from this list station for watch all train on her, add or delete train'
    station = select_station
    go_again = 1
    until go_again.zero?
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

  def set_get_name_company
    go_again = 1
    until go_again.zero?
      puts 'Select from this list train'
      train = select_train
      puts 'If set name company - 1, if get name company - 0'
      set_get = Integer(gets)
      if set_get == 1
        puts 'Set name company for this train'
        name = gets.chomp
        train.name_company = name
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

  def get_all_stations
    puts "Was created #{Station.all} stations"
  end

  def get_train_by_number
    go_again = 1
    until go_again.zero?
      puts 'Enter train number'
      number = Integer(gets)
      puts "Train - #{Train.find(number)}"
      puts 'Get train by number again? (yes - 1, no - 0)'
      go_again = Integer(gets)
    end
  end

  def get_all_trains_and_wagons
    puts "Created cargo trains: #{CargoTrain.instances}, passenger trains: #{PassengerTrain.instances},
        cargo wagons: #{CargoWagon.instances}, passenger wagons #{PassengerWagon.instances}."
  end

  def get_list_wagons_in_train
    go_again = 1
    until go_again.zero?
      puts 'Select from this list train'
      train = select_train
      train.each_wagon do |wagon|
        puts "#{wagon.type} wagon, places - #{wagon.capacity}" if wagon.type == 'passenger'
        puts "#{wagon.type} wagon, volume - #{wagon.capacity}" if wagon.type == 'cargo'
      end
      puts 'Get list wagons in train again? (yes - 1, no - 0)'
      go_again = Integer(gets)
    end
  end

  def get_list_trains_in_station
    go_again = 1
    until go_again.zero?
      puts 'Select from this list station'
      station = select_station
      station.each_train do |train|
        puts "#{train.train_type} train N#{train.number}"
      end
      puts 'Get list trains in station again? (yes - 1, no - 0)'
      go_again = Integer(gets)
    end
  end

  def select_wagon(train)
    wagon_count = 1
    train.each_wagon do |wagon|
      puts "#{wagon_count} - #{wagon.type} wagon, places - #{wagon.capacity}" if wagon.type == 'passenger'
      puts "#{wagon_count} - #{wagon.type} wagon, volume - #{wagon.capacity}" if wagon.type == 'cargo'
      wagon_count += 1
    end
    index = Integer(gets) - 1
    train.list_wagons[index]
  end

  def add_delete_place_volume_in_wagon
    go_again = 1
    until go_again.zero?
      puts 'Select from this list train'
      train = select_train
      puts 'Select from this list wagon'
      wagon = select_wagon(train)
      if wagon.type == 'cargo'
        puts "Free volume: #{wagon.capacity}"
        begin
          puts 'Enter volume for add:'
          volume = Float(gets)
        rescue StandardError => e
          puts e.message
          retry
        end
        wagon.close_capacity(volume)
        puts "Free volume: #{wagon.capacity}"
      else
        puts "Free places before: #{wagon.capacity}"
        wagon.close_capacity
        puts "Free places after: #{wagon.capacity}"
      end
      puts 'Add/delete place/volume in wagon again? (yes - 1, no - 0)'
      go_again = Integer(gets)
    end
  end
end
