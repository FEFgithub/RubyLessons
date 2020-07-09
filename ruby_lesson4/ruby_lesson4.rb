# require 'абсолютный путь'
# require_relative 'относительный путь к main.rb' 

class Car 
  attr_reader :current_rpm

  public # публичные все до private (по умолчанию все публичные) 

  def initialize
    @current_rpm = 0
  end

  def start_engine
    start_engine! if engine_stopped?
  end  

  def engine_stopped?
    current_rpm.zero? # rpm - обороты 
  end

  # private # будут приватными все внизу, доступ только в классе
  protected # доступ в классе и в наследниках

  attr_writer :current_rpm

  # INITIAL_RPM = 700
  def initial_rpm
    700
  end

  def start_engine!
    @current_rpm = initial_rpm
  end
end

class Truck < Car
  def loading
  end

  protected

  def initial_rpm # проявление полиморфизма
    500
  end 
end

class SportCar < Car
  def start_engine
    puts '...'
    super # вызываем функционал родительского класса (в скобках аргументы, если есть) 
    puts 'Go'
  end

  protected

  def initial_rpm # проявление полиморфизма
    1000
  end
end

car = Car.new
puts car.current_rpm 
car.start_engine
puts car.current_rpm
# Интерфейс класса - список публичных методов класса
truck = Truck.new 
puts truck.current_rpm
truck.start_engine
puts  truck.current_rpm
# В Ruby приватные методы наследуются, но не работает обращение к самому себе (self.)
sportcar = SportCar.new
sportcar.start_engine

# Загрузка файлов в irb: 
# 1) irb -r ./main.rb
# 2) irb 
# load './main.rb'  
