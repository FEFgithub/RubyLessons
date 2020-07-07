class Route
  attr_reader :first_station, :last_station, :stations
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
end
