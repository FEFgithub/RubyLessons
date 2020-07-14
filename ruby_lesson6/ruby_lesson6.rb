# begin
#   puts 'before'
#   1/0
#   puts 'after'  
# rescue Exception => exception # создание экземпляра класса Exception
#   puts "Exception #{exception.inspect}"
#   puts exception.backtrace.inspect
#   puts exception.message
#   raise # команда выброса исключения
# end

# begin
#   puts '1'
#   puts Math.sqrt(-2)
#   puts '2'
# rescue StandardError => e
#   puts e.message
# rescue NoMemoryError => e 
#   puts 'No memory!'
# end
# -----------------------------------
# def error_method
#   raise 'Nooooooooo!'
# end

# begin
#   error_method
# rescue RuntimeError => e
#   puts e.inspect
# end
# puts 'after'
# -------------------------------------------------

# def sqrt_calc(value)
#   puts Math.sqrt(value)
# rescue StandardError => e 
#   puts 'Uncorrect value!'
# end

# sqrt_calc(-13)
#-------------------------------

# def connect_to_wikipedia
#   #...
#   raise 'Connection error'
# end

# count_error = 0
# begin
#   connect_to_wikipedia
#   rescue RuntimeError => e
#     count_error += 1
#     puts 'Check your connection!'
#     retry if count_error < 5
#   ensure # выполняется в любом случае
#     puts count_error
# end
# ----------------------------------

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

  attr_accessor :number

  NUMBER_FORMAT = /^[а-я]{1}\d{3}[а-я]{2}$/i

  @@instances = 0 # наследуется

  def initialize(number)
    @@instances += 1
    @current_rpm = 0
    debug('instance debug')
    @number = number
    validate!
  end

  def  self.instances
    @@instances
  end

  def valid?
    validate!
  rescue
    false
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

  # def initialize
  #   @current_rpm = 0
  # end

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

  def validate!
    raise 'Number can not be nil!' if number.nil?
    raise 'Number should be >= 6 symbols!' if number.length < 6
    # raise 'Number uncorrect format!' if number !~ /^[а-яА-Я]{1}\d{3}[а-яА-Я]{2}$/
    raise 'Number uncorrect format!' if number !~ NUMBER_FORMAT 
    true
  end

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

# rubular.com

car = Car.new('н009вы')
puts car.valid?

