print 'Введите основание треугольника: '
a = gets
while a.to_f == 0
    print 'Введите корректное основание треугольника: '
    a = gets
end
print 'Введите высоту треугольника: '
h = gets
while h.to_f == 0
    print 'Введите корректную высоту треугольника: '
    h = gets
end

puts 'Площадь треугольника равна ' + (0.5 * a.to_f * h.to_f).to_s 
