1 == 1 # true
1.object_id == 1.object_id # true
:symbol1.object_id == :sumbol1.object_id # true
'string1' == 'string1' # true
'string1'.object_id == 'string1'.object_id # false

p "Hello!".gsub('!', '?') # "Hello?"
p "Hello!".gsub'!', '?' # "Hello?"

2 + 3 # 2.+(3)

Kernel.puts "Hello" # puts "Hello"

arr = []

p arr.any? # false
p arr.empty? # true

p arr.push('strin2')
p arr << "str2"

p arr.first
p arr.last

arr.delete_at(0) # => 'string2' и удалит её (по индексу)
arr.delete('str2') # => str2 и удалит её (по значению)
arr.compact # удаляет пустые элементы, возвращает изменённую копию массива
arr.compact! # удаляет пустые элементы, изменяет сам массив arr

arr[0] = 1
arr[-1] = 12 # последний элемент

arr.max
arr.min
arr.sort
arr.reverse

p arr.include?(12) # true

('a'..'d') # Range
('a'..'d').include?('a') # true
 
h_hash = {a: 1, b: 2} # <=> h_hash = {:a=>1, :b=>2} только для символов
h_hash = {a: :c, b: 2}
p h_hash[:a]

# !!! в ruby строка и символ не взаимозаменяемы, в rails - наоборот

h_hash.keys # возвращает массив ключей
h_hash.values

h_hash.include? :a # true (только с ключами)

h_hash.to_a

=begin
for # range
while # +
until # -
=end

# итераторы
some_arr = [1, 3, 345, 323333]
some_arr.each do |some_el|
  p some_el
end
some_arr.each { |x| p x**2 } # если 1 строка
h_hash.each { |key, val| p "#{key.class} - #{key} - #{val} - #{val.class}" }

print new_arr = [1, 2, 3].map { |i| i**2 }  # => [1, 4, 9] получаем другой массив
puts

loop do
  puts "1. Считаем идеальный вес"
  puts "2. Считаем площадь треугольника"
  puts "0. Выход"
  puts "Выберите вариант: "
  input = gets.to_i
  break if input == 0
  # здесь идет обработка ввода, в зависимости от выбранного варианта
end
