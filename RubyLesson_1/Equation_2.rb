print 'Введите 1 число: '
a = Float(gets)
print 'Введите 2 число: '
b = Float(gets)
print 'Введите 3 число: '
c = Float(gets)

if a == 0
  puts 'Уравнение не квадратное!'
else
  D = b ** 2 - 4 * a * c 
  if D == 0
    puts 'D = ' + D.to_s + ' x1 = x2 = ' + (-b / (2 * a)).to_s
  elsif D > 0
    puts 'D = ' + D.to_s + ' x1 = ' + ( (-b + Math.sqrt(D)) / (2 * a) ).to_s + ' x2 = ' + ( (-b - Math.sqrt(D)) / (2 * a) ).to_s
  else
    puts 'D = ' + D.to_s + ' x1 = ' + Complex(-b/(2 * a), Math.sqrt(-D)/ (2 * a)).to_s + ' x2 = ' + Complex(-b/(2 * a), -Math.sqrt(-D)/ (2 * a)).to_s     
  end
end
