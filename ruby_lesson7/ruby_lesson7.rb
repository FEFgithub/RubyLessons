# Блоки не являются объектами, чтобы сохранить их как объекты используем:
a = Proc.new { |i| puts i**2 }
b = proc { |i| puts i**2 }
c = lambda { |i| puts i**2 }

puts a.class
puts b.class 
puts c.class 

a.call(4, 'fdgfdg')
b.call(43, 453, 3435)
c.call(4464) # лямбда проверяет количестов входящих аргументов

# Блоки - это замыкания (хранит в себе переменные окружения)

x = 'hello'
block = Proc.new { puts x }
block.call 
def f(block)
  x = 'hello_def'
  puts x 
  block.call
end
f(block) # => hello_def hello

# передача блоков в качестве аргументов мктода
def f_block 
  puts 'before'
  yield # вызывает блок
  puts 'after'
end
f_block { puts 'block' }
# f_block ({ puts 'block' }) - ошибка, блоки не вызываются как именованные аргументы
def caps(str)
  str.capitalize!
  yield(str)
end
caps('abc') { |str| puts str } 
# Чтобы передать блок как именованный аргумент, нужно сохранить его как объект:
block = lambda { |str| puts str }
def caps2(str, block)
  str.capitalize!
  block.call(str)
end
caps2('block', block)

def caps22(str, &block) # блок должен идти последним аргументом
  str.capitalize!
  block.call(str)
  yield(str) # вызывает тот же блок 
end
caps22('str') { |str| puts str[0] }
# если блок не обязателен 
def m(str, &block)
  if block_given?
    yield(str)
  else
    puts str 
  end 
end

m('str') { |str| puts str * 2 }
m('str')
