print 'Укажите Ваше имя: '
name = gets.chomp
print 'Укажите Ваш рост: '
height = gets

while height.to_f == 0
    print 'Укажите корректный рост, пожалуйста: '
    height = gets
end

ideal_weight = (height.to_f - 110) * 1.15

if ideal_weight < 0
    p 'Ваш вес уже идеальный!'
else
    puts "#{name}, Ваш идеальный вес - #{ideal_weight.round(2)} кг."
end
