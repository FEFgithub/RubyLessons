print 'Введите 1 сторону: '
a = Float(gets)
print 'Введите 2 сторону: '
b = Float(gets)
print 'Введите 3 сторону: '
c = Float(gets)
 
x, y, hyp = [a, b, c].sort

if x == y && x == hyp 
  puts 'Треугольник является равносторонним и равнобедренным'
elsif (hyp ** 2 == x ** 2 + y ** 2 ) && (x == y || x == hyp || y == hyp) 
  puts 'Треугольник является прямоугольным равнобедренным'
elsif   (hyp ** 2 == x ** 2 + y ** 2) && (x != y && x != hyp && y != hyp)
  puts 'Треугольник является прямоугольным'
elsif x == y || x == hyp || y == hyp 
  puts 'Треугольник является равнобедренным'
else
  puts 'Это обычный треугольник'
end
