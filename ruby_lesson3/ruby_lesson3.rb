=begin
Принципы ООП: 
1) Абстракция - выделение значимых деталей при реализации модели 
2) Инкапсуляция - а) объединение данных и методов в одну сущность, б) сокрытие деталей реализации
3) Наследование - создаём иерархию классов, передаём данные и методы от родителя потомку (уменьшает дублирование кода)
4) Полиморфизм - а) возможность переопределять поведение потомков, б) возможность использовать объекты разных классов 
с одним интерфейсом одинаково.
=end

class Car
  attr_accessor :speed
  attr_accessor :engine_volume

  # attr_writer :speed # создает @speed и метод-сеттер
  # attr_reader :speed # создаст метод-геттер

  # attr_writer :engine_volume
  # attr_reader :engine_volume

  def initialize(speed = 0, engine_volume = 1.6)
    @speed = speed
    @engine_volume = engine_volume
    signal 
  end

  def start_engine
    puts 'start'
  end  

  def signal
    puts 'signal'
  end

  def stop
    self.speed = 0 # вызываем метод-сеттер
  end

  def go
    speed = 40 # локальная переменная, видна только в этом методе
    @speed = 50 # инстанс-переменная (пеерменная экземпляра), видна во всех методах класса
  end

  # def speed # get_current_speed
  #   @speed  
  # end

  # def engine_volume # get_engine_volume
  #   @engine_volume
  # end

  # def speed=(speed) # set_speed
  #   @speed = speed
  # end

  # def engine_volume=(engine_volume) # set_engine_volume
  #   @engine_volume = engine_volume
  # end 
end
