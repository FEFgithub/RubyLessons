class Train
  attr_accessor :speed
  attr_reader :number, :train_type, :wagon_count


  def initialize(number, train_type, wagon_count)
    @number = number
    @train_type = train_type
    @wagon_count = wagon_count
    @position_train = []
    @train_road_list = []
    @index_position = 0
  end  

  def train_stop
    self.speed = 0
  end

  def add_wagon
    @wagon_count += 1 if self.speed == 0
  end

  def delete_wagon
    @wagon_count -= 1 if @wagon_count > 0 && self.speed == 0
  end

  def set_route(route)
    @route = route
    @index_position = 0
    @train_road_list = [@route.first_station] + @route.stations + [@route.last_station]
    @position_train = [nil, @train_road_list[@index_position].title, 
                      @train_road_list[@index_position + 1].title]
  end

  def move_forward
    @index_position += 1
    @position_train = [@train_road_list[@index_position - 1].title,
                      @train_road_list[@index_position].title,
                      @train_road_list[@index_position + 1].title] if @index_position + 1 < @train_road_list.size
    if @position_train[1] == @train_road_list[-1].title
      @position_train = [@train_road_list[-2].title,
                        @train_road_list[-1].title,
                        nil]
    end                    
  end

  def move_back
    @index_position -= 1
    @position_train = [@train_road_list[@index_position + 1].title,
                      @train_road_list[@index_position].title,
                      @train_road_list[@index_position - 1].title] if @index_position + 1 < @train_road_list.size
    if @position_train[1] == @train_road_list[0].title
      @position_train = [@train_road_list[1].title,
                        @train_road_list[0].title,
                        nil]
    end                    
  end

  def get_information 
    puts "Предыдущая станция - #{@position_train[0]}"
    puts "Текущая станция - #{@position_train[1]}"
    puts "Следующая станция - #{@position_train[2]}"
  end
end
