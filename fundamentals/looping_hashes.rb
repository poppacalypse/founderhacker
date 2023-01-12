array = [1,2,3]

array.each do |num|
  # do something
end 

people = [
  { first_name: 'AJ', age: 53 },
  { first_name: 'Jim', age: 33 },
  { first_name: 'Adam', age: 43 },
  { first_name: 'Sarah', age: 23 },
  { first_name: 'Ophelia', age: 13 }
]

# if i want to loop through these people
people.each do |person|
  age = person[:age]
  name = person[:first_name]

  puts "#{name} is #{age} years old."
end

> AJ is 53 years old.
> Jim is 33 years old.
> Adam is 43 years old.
> Sarah is 23 years old.
> Ophelia is 13 years old.

# another way to deal with the each do block, is the 'inner loop'
# i.e. loop within loop 
people.each do |person|
  person.each do |k, v| # key, value - can be named anything remember? 
    puts "Key is #{k}"
    puts "Value is #{v}"
  end 
end

> Key is first_name
> Value is AJ
> Key is age
> Value is 53
> Key is first_name
> Value is Jim
> ...

# or change the params, get same result
people.each do |person|
  person.each do |characteristic, data|
    puts "Characteristic: #{characteristic}"
    puts "Data: #{data}"
  end
end 

> Characteristic: first_name
> Data: AJ
> Characteristic: age
> Data: 53
> Characteristic: first_name
> Data: Jim
> ...

# what if are only interested in the values? not the keys?
# simple solution would be 
people.each do |person|
  person.each do |k, v| # this will totally work, but it's not good code
    puts v  # another dev looking at it might think you wanted to do sth with k but forgot? 
  end 
end

# so a better way, stylistically, is to do this:
people.each do |person|
  person.each do |_, v| # this allows another dev or our future selves to know we're not using k 
    puts v 
  end 
end 

> AJ
> 53
> Jim
> 33

# but let's do something more useful. let's create a collection of everyone's ages
people.map do |person|
  person.map do |_, v|
    v 
  end 
end 
# what we'll get is an array of arrays... and we only want the ages i.e. [53, 33, 43, 23, 13]
> => [["AJ", 53], ["Jim", 33], ["Adam", 43], ["Sarah", 23], ["Ophelia", 13]] 

# so let's leverage the logic we alr know 
people.map do |person|
  person.select do |attribute, value| # replace k, v with sth more descriptive 
    if attribute == :age # we want the symbol :age, not the string 'age' 
      value 
    end 
  end 
end 
# now we're slightly closer to what we want  
> => [[nil, 53], [nil, 33], [nil, 43], [nil, 23], [nil, 13]]

# maybe we try replace person.map with person.select ? 
> => [{:age=>53}, {:age=>33}, {:age=>43}, {:age=>23}, {:age=>13}] 
# hmm , not quite , so let's go back to person.map and shorten the code 
# and invoke .compact to remove the nils 

people.map do |person|
  person.map do |attribute, value|
    value if attribute == :age
  end.compact 
end
# almost there! but it's *still* an array of arrays...
> => [[53], [33], [43], [23], [13]] 

# let's experiment with a method called .flatten. It assumes you have an array of arrays, and combines all values into one array.
> [[53], [33], [43], [23], [13]].flatten 
> => [53, 33, 43, 23, 13] # yay this is what we want! 

people.map do |person|
  person.map do |attribute, value|
    value if attribute == :age
  end.compact # adding .flatten here won't work 
end.flatten # needs to be on the outer loop 

> => [53, 33, 43, 23, 13]

# What's even more useful than getting all ages? Maybe we want to figure out the average age. 
# remember we can assign a loop to a variable 

all_ages = people.map do |person|
  person.map do |attribute, value|
    value if attribute == :age
  end.compact 
end.flatten 

> all_ages
> => [53, 33, 43, 23, 13]

# think mathematically + a bit of guesswork , and remember to coerce integers to floats so we get an accurate answer
> avg_age = all_ages.sum.to_f / all_ages.count # .length , .size, .count are all the same function. 
> => 33.0
# technically we can attach this ⬆️ to our previous loop, and do some method chaining 
people.map do |person|
  person.map do |attribute, value|
    value if attribute == :age
  end.compact 
end.flatten.sum.to_f / all_ages.count # like so 

# so we can now put this all in a method 

def avg_age folks # just to reiterate that our parameter name != argument name
  all_ages = folks.map do |person|
    person.map do |attribute, value|
      value if attribute == :age 
    end.compact 
  end.flatten 

  avg_age = all_ages.sum.to_f / all_ages.count 
end
> avg_age people 
> 33.0

# we can clean it up further. let's not assign all_ages & avg_age just to use it only once 
def avg_age folks
  folks.map do |person|
    person.map do |attribute, value|
      value if attribute == :age 
    end.compact  
  end.flatten.sum.to_f / folks.count 
end
> avg_age people
> => 33.0

# we can add more people to the group 
people = [
  { first_name: 'AJ', age: 53 },
  { first_name: 'Jim', age: 33 },
  { first_name: 'Adam', age: 43 },
  { first_name: 'Sarah', age: 23 },
  { first_name: 'Ophelia', age: 11 },
  { first_name: 'Ophelia', age: 12 },
  { first_name: 'Ophelia', age: 14 },
  { first_name: 'Ophelia', age: 15 },
  { first_name: 'Ophelia', age: 16 }
]

> avg_age people
> => 24.444444444444443


# parameter = method definition
# argument = method invocation 