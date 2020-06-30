# 1.Сделать хеш, содеращий месяцы и количество дней в месяце. 
# В цикле выводить те месяцы, у которых количество дней ровно 30
puts '№1'
hash_year2020 = { January: 31, February: 29, March: 31, April: 30, 
  	        	    May: 31, June: 30, July: 31, August: 31, 
  	        	    September: 30, October: 31, November: 30, December: 31 } 						
hash_year2020.each { |i| print "#{i[0]} " if i[1] == 30 }
puts "\n"

# 2. Заполнить массив числами от 10 до 100 с шагом 5
puts '№2'
array1 = (10..100).step(5).to_a
print array1
puts "\n"

# 3. Заполнить массив числами фибоначчи до 100
puts '№3'
array2 = []
def num_fib(n)
  if n == 0
    0 
  elsif n == 1
  	1
  else
    num_fib(n - 1) + num_fib(n - 2)
  end
end

(0..100).to_a.each do |i|
  if num_fib(i) <= 100
    array2.push(num_fib(i))
  else
  	break
  end
end
print array2
puts "\n"

# Заполнить хеш гласными буквами, где значением будет являтся 
# порядковый номер буквы в алфавите (a - 1).
puts '№4'
hash_abc = {}
int_number = 1
VOWEL = ['a', 'e', 'i', 'o', 'u'].freeze
('a'..'z').each do |v| 
  hash_abc[v] = int_number if VOWEL.include?(v)
  int_number += 1
end   
print hash_abc
puts "\n"
