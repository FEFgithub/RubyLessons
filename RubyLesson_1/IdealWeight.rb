print 'Укажите Ваше имя: '
name = gets.chomp
print 'Укажите Ваш рост: '
height = Float(gets)

ideal_weight = (height - 110) * 1.15

if ideal_weight < 0
  puts 'Ваш вес уже идеальный!'
else
  puts "#{name}, Ваш идеальный вес - #{ideal_weight.round(2)} кг."
end
