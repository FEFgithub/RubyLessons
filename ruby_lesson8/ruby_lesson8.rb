# Идиомы в Ruby

class Foo
  attr_accessor :m

  def long_method
    sleep(4)
  end

  def memoization
    @m ||= long_method # присваивает значение только если false или nil
  end
end

class User
  attr_accessor :name

  def has_name?
    # name.nil? ? true : false
    !!name # двойное отрицание
  end

  def has_not_name?
    !has_name?
  end

  def name=(value)
    @name = value.capitalize
  end
end

# foo = Foo.new
# puts foo.memoization
# puts foo.memoization
# puts foo.memoization

# user = User.new
# user.name = 'dfgdfg'
# puts user.has_name?

arr = %w[str1 str2 str3]
p arr
# arr.map! { |str| str.upcase }
arr.map!(&:upcase) # применяте метод ко всем элементам, работает быстрее
p arr

class Color
  COLORS = { red: '#f00', green: '#0f0', blue: '#00f', white: '#fff' }.freeze

  def code(name)
    @code = COLORS[name] || '#000'
    # @code = case name
    # when :red
    #   '#f00'
    # when :green
    #   '#0f0'
    # when :blue
    #   '#00f'
    # when :white
    #   '#fff'
    # else
    #   '#000'
    # end
  end

  alias by_name code
end

color = Color.new
puts color.code(:red)
puts color.by_name(:white)

# def fun_hash({a: 1, b: 2})
# end
def fun_hash(a: 1, b: 2); end

def fun_change_args(var1, *array_vars); end

class Train
  attr_accessor :type, :number, :num_wagons, :model

  # def initialize(type, *arr)
  #   @type = type
  #   @number = arr[0] || 'default'
  #   @num_wagons = arr[1] || 'default'
  #   @model = arr[2] || 'default'
  # end

  def initialize(type, options = {})
    @type = type
    @number = options[:number] || 'default'
    @num_wagons = options[:num_wagons] || 'default'
    @model = options[:model] || 'default'
  end
end

train = Train.new('type', number: 123)
puts train.number

class String # все классы открытые, можно добавлять любые методы
  def add_str
    to_s + 'str'
  end
end

puts 'str'.add_str

class Boo
end
boo = Boo.new
class << boo # синглтон-метод
  def bbo(str)
    str.reverse
  end
end
puts boo.bbo('boo')

symb_arr = %i[sym1 sym2 sym3]
p symb_arr

# rubocop -a ./
