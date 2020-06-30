day = Integer(gets)
month = Integer(gets)
year = Integer(gets)

hash_month_day = {}
i = 1
while i <= month  
  if i == 9 || i == 4 || i == 6 || i == 11
    hash_month_day[i] = 30
  elsif i == 2
    hash_month_day[2] = 28
  else
    hash_month_day[i] = 31
  end
  i += 1
end 

if (year % 4 == 0 && year % 100 != 0) || year % 400 == 0
  hash_month_day[2] = 29
end

n_num = 0
hash_month_day.each { |i| n_num += i[1] }

puts "#{n_num - hash_month_day[month] + day} день года"
