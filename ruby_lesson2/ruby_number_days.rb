day = Integer(gets)
month = Integer(gets)
year = Integer(gets)

hash_month_day = {}

for i in 1..month
  if i == 9 || i == 4 || i == 6 || i == 11
    hash_month_day[i] = 30
  elsif i ==2
    if (year % 4 == 0 && year % 100 != 0) || year % 400 == 0
      hash_month_day[2] = 29
    else
      hash_month_day[2] = 28
    end  
  else
    hash_month_day[i] = 31
  end
end 

n_num = 0
for i in hash_month_day
   n_num += i[1]
end

puts "#{n_num - hash_month_day[month] + day} день года"
