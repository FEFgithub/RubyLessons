module FuelTank
  def fill_tank(level)
    @fuel_tank = level
  end

  def fuel_level
    @fuel_tank
  end

  protected
  attr_accessor :fuel_tank
end

module Debugger
  def self.included(base) # передается класс куда мы подключаем модуль
    base.extend ClassMethods
    base.send :include, InstanceMethods # send вызывает приватные методы
  end

  module ClassMethods
    def debug(log)
      puts "Debug #{log}"
    end
  end

  module InstanceMethods
    def debug(log)
      # self.class.debug(log)
      puts "debug #{log}!"
    end

    def print_class
      puts self.class
    end
  end
end

class Car
  include FuelTank # включает методы как методы экземпляра 
  # extend Debugger::ClassMethods # включает методы как методы класса
  # include Debugger::InstanceMethods
  include Debugger

  @@instances = 0 # наследуется

  def initialize
    @@instances += 1
    debug('instance debug')
  end

  def  self.instances
    @@instances
  end

  def fill_tank(level)
    @fuel_tank = level
  end

  def fuel_level
    @fuel_tank
  end

  # def self.debug(log)
  #   puts "Debug #{log}"
  # end

  debug(12)

  def self.description
    puts 'This method for all cars'
  end

  class << self
    def description2
      puts 'This again method for class'
    end
  end

  def description
    puts 'This method for instance class'
    # debug(123) # не сработает
    # self.debug(14) # не сработает
    self.class.debug(15)
  end

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
  attr_accessor :fuel_tank
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
end

class MotorBike
  include FuelTank 
  # extend Debugger::ClassMethods 
  # include Debugger::InstanceMethods
  include Debugger
end

puts Car.instances
Car.description
bus = Car.new # = new do ... end
puts Car.instances
bus.description
Car.description2

bike = MotorBike.new 
bus.fill_tank(50)
puts bus.fuel_level
bike.fill_tank(25)
puts bike.fuel_level

bus.print_class
bike.print_class
