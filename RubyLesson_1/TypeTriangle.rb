print 'Введите 1 сторону: '
a = gets.to_f
while a.to_f ==0
    print 'Укажите 1 сторону корректно: '
    a = gets.to_f    
end
print 'Введите 2 сторону: '
b = gets.to_f
while b.to_f ==0
    print 'Укажите 2 сторону корректно: '
    b = gets.to_f    
end
print 'Введите 3 сторону: '
c = gets.to_f
while c.to_f ==0
    print 'Укажите 3 сторону корректно: '
    c = gets.to_f    
end 

if a == b && c == b 
    puts 'Треугольник является равносторонним и равнобедренным'
elsif ([a, b, c].max ** 2 == a ** 2 + b ** 2 || [a, b, c].max ** 2 == a ** 2 + c ** 2 ||
      [a, b, c].max ** 2 == b ** 2 + c **2) && (a == b || a == c || b == c) 
    puts 'Треугольник является прямоугольным равнобедренным'
elsif   ([a, b, c].max ** 2 == a ** 2 + b ** 2 || [a, b, c].max ** 2 == a ** 2 + c ** 2 || 
        [a, b, c].max ** 2 == b ** 2 + c **2) && (a != b && a != c && b != c)
    puts 'Треугольник является прямоугольным'
elsif a == b || a == c || b == c 
    puts 'Треугольник является равнобедренным'
else
    puts 'Это обычный треугольник'
end