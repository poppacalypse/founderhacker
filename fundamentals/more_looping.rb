- .map 

- .select , .collect , .reject 

numbers = [1,2,3,4,5]

# EACH
what_is_returned = numbers.each do |num| # yes you can assign a loop to a variable 
  puts num
end
# irb:
> what_is_returned
> => [1, 2, 3, 4, 5]

# MAP 
what_is_returned = numbers.map do |num| # yes you can assign a loop to a variable 
  puts num
end
# irb:
> what_is_returned
> => [nil, nil, nil, nil, nil] # because there's no truthyness to puts-ing something ⬇️

# eg. 
> puts name
> Adam Jensen
> => nil # the return is nil, .:. puts is not truthy 

# Explanation: 
# EACH 
numbers.each do |num|
  puts num # do stuff here
end 
# collection is returned by itself (no modifications)

# MAP 
numbers.map do |num|
  puts num # do stuff here -- the inner execution of .map needs to be TRUTHY i.e. "kinda true" i.e. it exists
end 
# NEW collection is returned by itself (original is still not modified)

# if we did
numbers.map do |num|
  num # just return, not puts 
end 

> => [1, 2, 3, 4, 5] # this is truthy 

# Another example
# EACH
numbers.each do |num|
  puts num if num.odd? # without puts, it will only return original array.
end 

> 1
> 3
> 5
> => [1, 2, 3, 4, 5] # original collection is returned by itself (no modifications)

# MAP 
numbers.map do |num|
  num.odd?
end 

> => [true, false, true, false, true] # NEW collection is returned 

# SELECT 
numbers.select do |num|
  num.odd?
end 

> => [1, 3, 5] # returns a collection of the values that suit the truthyness of num.odd? 

# More examples 
# version 1.0 - EACH with an instantiated outer scope variable 
new_numbers = []
numbers.each do |num|
  new_numbers << (num * 2)
end 

# version 2.0 - MAP
numbers.map do |num|
  num * 2
end


