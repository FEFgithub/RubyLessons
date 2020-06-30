hash_all_title = {}

puts 'Для выхода введите "стоп" в название товара'
print 'Введите название товара: '
title = gets.chomp
until title == 'стоп'
  print 'Введите цену товара: '	
  price = Float(gets)
  print 'Введите количество товара: '
  number = Float(gets)
  hash_all_title[title] = { price => number }
  puts 'Для выхода введите "стоп" в название товара'
  print 'Введите название товара: '
  title = gets.chomp 
end

print hash_all_title
puts "\n"

external_price = 0.0
hash_all_title.each do |i|
  inner_price = 0.0
  i[1].to_a.each do |j|
  	inner_price += j[0] * j[1]
  end
  puts "Стоимость #{i[0]} равна #{inner_price}"
  external_price += inner_price
end
puts "Общая стоимость покупок: #{external_price}"
