class Route 
  # Нет private/protected методов, так как все методы 
  # входят в интерфейс пользователя 
  attr_reader :first_station, :last_station

  def initialize(first_station, last_station)
    @first_station = first_station
    @last_station = last_station
    @all_stations = [@first_station, @last_station]
  end

  def add_station(station)
    @all_stations -= [@last_station]
    @all_stations << station
    @all_stations += [@last_station]
  end

  def delete_station(station)
    @all_stations.delete(station)
  end

  def stations
    @all_stations
  end

  def print_all_stations
    @all_stations.each { |st| puts st.title }
  end
end
