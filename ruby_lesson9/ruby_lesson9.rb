=begin
# свой irb
line_num = 0
input = ''

loop do
  print "#{line_num += 1}?: "
  line = gets
  break if line.strip == 'exit' # strip удаляет пробелы

  if line.strip == ''
    puts 'Evaluating'  
    puts eval(input) # выполняет любой код, переданный в виде строки
    input = ''
  else
    input += line
  end
end 
# eval - приватный
# instance_eval - публичный 
=end

class Foo
  def initialize
    @bar = 'instance_var'
  end 

  private 
  def private_method
    puts 'private'
  end
end 

foo = Foo.new
foo.instance_eval do
  def m
    puts 'public_method'
    puts "#{@bar}"
    private_method
  end 
end
puts foo.m

module X
end

class Y
  include X
  @@y = 12 
end 

puts Y.class_eval('@@y')

Y.class_eval do
  def f_y 
    puts 'instance_Y_method'
  end 
end

y = Y.new 
y.f_y

X.module_eval do
  def module_method
    puts 'module_method_X'
  end 
end

y.module_method

# module_eval and class_eval - alias

p Y.class_variables

p Y.class_variable_get(:@@y)
Y.class_variable_set(:@@y, 'set_@@y')
p Y.class_variable_get(:@@y)

y.instance_variable_set(:@x, 2)
puts y.instance_variable_get(:@x)
p y.instance_variables

class Z
  define_method(:new_method_z) do
    puts 'new_method_z' 
  end 
end 

z = Z.new
z.new_method_z

Z.const_set :CCONN, true
p Z.const_get :CCONN

module MyAttrAccessor
  def my_attr_accessor(*names)
    names.each do |name|
      my_var = "@#{name}".to_sym
      define_method(name) { instance_variable_get(my_var) }
      define_method("#{name}=".to_sym) { |value| instance_variable_set(my_var, value) }
    end
  end
end

class Test
  extend MyAttrAccessor
  
  my_attr_accessor :my_attr
end

test = Test.new
test.my_attr= 'attr'
puts test.my_attr

puts 2.send(:*, 23)

# remove_method :name_method

class Miss
  def m 
    puts 'm'
  end 

  def method_missing(name, *args)
    puts "Called #{name} method with #{args}"
  end
end 

miss = Miss.new 
miss.m
miss.abc

class MissNew
  def method_missing(name, *args)
    self.class.send(:define_method, name.to_sym, lambda { |*args| puts args.inspect})
  end
end 

miss_new = MissNew.new 
puts miss_new.nnnil 212, :efdsfds

