class Station
  attr_reader :title, :trains

  def initialize(title)
    @title = title
    @trains = []
  end
  
  def train_in(some_train)
    @trains << some_train
    puts "Поезд номер #{some_train.number} прибыл на станцию #{@title}"
  end

  def train_out(some_train)
    @trains -= [some_train]
    puts "Поезд номер #{some_train.number} отправился со станции #{@title}"
  end

  def print_list_of_all_trains
    @trains.each { |train| puts "На станции #{@title} поезд номер #{train.number}" }
    puts "Всего поездов на станции #{@title} - #{@trains.size}"
  end

  def print_list_of_special_trains(train_type)
    count_trains = 0
    @trains.each do |train|
      if train.train_type == train_type
        puts "На станции #{@title} поезд номер #{train.number} типа #{train_type}"
        count_trains += 1 
      end 
    end
    puts "На станции #{@title} #{count_trains} поездов типа #{train_type}"
  end
end
