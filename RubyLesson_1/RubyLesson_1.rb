puts "Как тебя зовут?"
name = gets.chomp # убираем лишние символы (пробелы, экранирующие, переводы строк) в конце строки
puts "Привет, #{name}!"

unless 3 > 4
    puts "false"
end

if !(3 > 4)
    puts "false"
end

some_str = "dfdfsf"
puts some_str.nil?