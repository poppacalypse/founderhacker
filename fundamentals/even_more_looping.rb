numbers = (1..5).to_a

# each, map, select iterators
numbers.each do |num|
  puts num
end 

# for loop --------------------------------------------------------
for num in numbers do 
  puts num
end 

> 1
> 2
> 3
> 4
> 5
> => [1, 2, 3, 4, 5] # same behaviour and same return either way

# literally nobody uses `for` in Ruby. In JS you'll be `for`-ing all the time.

# times iterator -------------------------------------------------
10.times do |num|
  # do stuff n times
  puts num 
end 

> 0
> 1
> 2
> 3
> 4
> 5
> 6
> 7
> 8
> 9
> => 10 # start with 0 and loops 10 times

# we can use it even when it's not related to something
3.times do |_|
  puts "asdf"
end 

# or even cleaner, leave out the pipes altogether 
3.times do
  puts "asdf"
end 

> asdf
> asdf
> asdf
> => 3

# we can even do this with eg. the .each iterator. Now we know the paramter name is optional.
numbers.each do 
  puts "no parameter!"
end 

> no parameter!
> no parameter!
> no parameter!
> no parameter!
> no parameter!
> => [1, 2, 3, 4, 5] # it's still looping through the array, it's just not making use of the number 

# while loop ------------------------------------------------ 
# similar to `if` but not really. Useful when needing to refresh APIs. See footer
x = 0

# this will result in infinite loop
while x < 10 
  puts "X is less than 10"
end 

# so let's refine it
while x < 5 # as long as this is true 
  puts "X is less than 5"  # puts this 
  puts "X is #{x}" # and puts this 
  x += 1 # then do this at the end of every loop (a shorthand for x = x + 1)
end 

> X is less than 5
> X is 0
> X is less than 5
> X is 1
> X is less than 5
> X is 2
> X is less than 5
> X is 3
> X is less than 5
> X is 4
> => nil # while loop terminates itself once the initial expression is no longer true 

# this also mutates the variable, because now: 
> x 
> => 5 

# until loop ---------------------------------------------- similar to `unless` but not really 
# baically the inverse of `while`
x = 0
until x > 5 # as long as this is true 
  puts "X is less than 5"  # puts this 
  puts "X is #{x}" # and puts this 
  x += 1 # then do this at the end of every loop (a shorthand for x = x + 1)
end 

> X is less than 5
> X is 0
> X is less than 5
> X is 1
> X is less than 5
> X is 2
> X is less than 5
> X is 3
> X is less than 5
> X is 4
> X is less than 5
> X is 5
> => nil

# real world use case:
def api_key_works?
  # logic here 
end

def refresh_token!
  # logic here
end

def get_product
  retries = 0
  until retries > 3 || api_key_works?
    refresh_token!
  end 

  #fetch product logic here
end


