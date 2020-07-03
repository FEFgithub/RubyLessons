class Route
  attr_reader :first_station, :last_station, :stations

  def initialize(first_station, last_station)
    @first_station = first_station
    @last_station = last_station
    @stations = []
  end  

  def add_station(station)
    @stations << station
    puts "Станция #{station.title} добавлена в маршрут"
  end

  def delete_station(station)
    @stations -= [station]
    puts "Станция #{station.title} удалена из маршрута"
  end

  def print_all_stations
    @all_stations = [@first_station]
    @stations.each { |station| @all_stations << station }
    @all_stations += [@last_station]
    @all_stations.each { |station| puts "Станция: #{station.title}" }
  end

  def stations
    @all_stations
  end
end

