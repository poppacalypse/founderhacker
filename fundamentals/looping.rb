names = ["Adam", "Sarah", "robot"]

# example 
names.each do |name|
  puts name
end 

names.each do |name|
  puts name if name.length >= 5
end

names.each do |name|
  if name == name.downcase # 'Robot' => 'robot'
    puts "#{name} is formatted incorrectly"
  else 
    puts "#{name} seems OK"
  end 
end

# anatomy 
collection.each do |any_name| # in between "pipes", can be any name for my convenience
  # some logic
end 

# using plural - singular (names, name) is an easy convention 

numbers = [1,2,3,4,5]

numbers.each do |num|
  puts "#{num} is odd" if num.odd? # functionally. see below ⬇️ for imperative version
end

#* imperatively:
if num.odd?
  puts "#{num} is odd"
end 

# We have 2 syntax options, for 2 use cases.
# Multi-line inner loop blocks
collection.each do |parameter_name|
  # logic_here
end

# Single-line inner loop blocks
collection.each { |parameter_name| logic_here }

# ==============================================

# SCOPING AND LOOPS
# When we introduce a var outside of a Method™, 
# it's available inside of the method IF AND ONLY IF  we pass it in
# as a method argument

variable_here_outside = "hello"

def puts_the_thing outside_var
  puts outside_var
end

#irb:
> puts_the_thing(variable_here_outside)
> hello
=> nil

# But with Loops™, we can use an external variable without passing any arg inside the block

variable_here_outside = "hello"

names.each do |name|
  puts variable_here_outside #just for kicks, and can be nested anywhere 
  if name == name.downcase # 'Robot' => 'robot'
    # puts variable_here_outside -- eg. can be nested here 
    puts "#{name} is formatted incorrectly"
  else 
    puts "#{name} seems OK"
  end 
end

#irb:
> hello
> Adam seems OK
> hello
> Sarah seems OK
> hello
> robot is formatted incorrectly
> => ["Adam", "Sarah", "robot"]

# SCOPING tl;dr
# Outer-scoped variables are accessible on the inside of a Loop
# Outer-scoped variables are accessible by default on the inside of a Method, unless you pass them in (as arguments)

# Example using Loop 
longest_name = ''
names = %w[AJ Jim Sara Ophelia] # works with [], (), {}, but prefer to use [] to denote array.

names.each do |name|
  longest_name = name if name.length > longest_name.length
end

#irb:
> longest_name 
> => "Ophelia"

# Example using Method
names = %w[AJ Jim Sara Ophelia]

def longest_str collection # <= because it can be anything
  longest_str = ''
  
  collection.each do |str| # we can reuse the Loop block, but params must match 
    longest_str = str if str.length > longest_str.length
  end

  longest_str
end

# irb: 
> longest_str names
> => "Ophelia"

> cities = %w[ATL Barcelona London Tokyo Milan Albuquerque]
> longest_str cities
> => "Albuquerque"


