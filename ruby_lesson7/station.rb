class Station
  # Нет private/protected методов, так как все методы 
  # входят в интерфейс пользователя 
  attr_reader :title, :trains
  @@all_created_stations = []

  def initialize(title)
    @title = title
    @trains = []
    @@all_created_stations.push(self)
    validate!
  end

  def valid?
    validate!
    true
  rescue
    false
  end

  def self.all
    @@all_created_stations 
  end
  
  def train_in(some_train)
    @trains << some_train
  end

  def train_out(some_train)
    @trains -= [some_train]
  end

  def print_list_of_all_trains
    @trains.each { |train| puts "#{train.train_type} train  N#{train.number} on station #{self.title}" }
  end

  def print_list_of_special_trains(train_type)
    count_trains = 0
    @trains.each do |train|
      if train.train_type == train_type
        puts "#{train_type}"
        count_trains += 1 
      end 
    end
    puts "#{count_trains} - #{train_type}"
  end

  protected
  def validate!
    raise 'Title can not be nil!' if title.nil?
    raise 'Title should be > 3 symbols!' if title.length < 3 
  end
end
