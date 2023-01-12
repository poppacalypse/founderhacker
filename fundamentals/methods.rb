# Definition vs Invocation --------------------------------------
# Parameters vs Arguments ---------------------------------------

# Definition ⬇️ , parameters ⬇️
def method_name(city, zip_code)
  # loc 
end

# ⬇️ Invocation , arguments ⬇️
method_name("Beverly Hills", "90210")

# Inner vs Outer Scoping ----------------------------------------
# An outer-scoped variable cannot be used inside a method definition or invocation unless we pass it in 
outer_scoped_variable = 'Adam'
method_name(outer_scoped_variable) # OK 

# Whereas in looping, an outer-scoped variable is accessible inside the loop 
outer_scoped_variable = 'something'
[1,2,3].each do |num|
  outer_scoped_variable * 3 # OK
end 

# Default Parameters & Default Keyword Arguments ===============================

# Default Parameters --------------------------------------------
# example: definition
def full_name(first, middle, last)
  puts "#{first} #{middle} #{last}" # logical, but not everyone has a middle name
end

# example: definition w/ default parameter
def full_name(first, last, middle = '') # there's always a first + last, and maybe a middle
  "#{first} #{middle} #{last}"
end

# always put the default parameter at the end

#irb
> full_name('Adam', 'Jensen', 'A') # mindful to put it in the right order
> => "Adam A Jensen"
> irb(main):005:0> full_name('Adam', 'Jensen') # without middle name
> => "Adam  Jensen" # but leaves a weird space in between

# several ways to deal with weird spaces
- "  Adam Jensen    ".strip # gets rid of leading AND trailing spaces
> => "Adam Jensen"

- "Adam  Jensen".gsub("  ", " ") # find and replace with global substitute 
=> "Adam Jensen"

# refactor 1
def full_name(first, last, middle = '')
  "#{first.strip} #{middle.strip} #{last.strip}".gsub("  ", " ")
end 

# just ship ugly code first, then agonise over refactoring later. 
# so now we have code that can handle with/without middle name, and malformed data
> full_name("   Adam", "Jensen  ", "Carl")
> => "Adam Carl Jensen"

# default parameter need not be blank
def full_name(first, last, middle = 'TBD')
  "#{first.strip} #{middle.strip} #{last.strip}".gsub("  ", " ")
end

# default parameter can even be a method! 
def random_middle
  ['TBD', 'TBA', 'N/A'].sample
end

def full_name(first, last, middle = random_middle)
  "#{first.strip} #{middle.strip} #{last.strip}".gsub("  ", " ")
end

 # irb
> full_name 'Adam', 'Jensen' # without 3rd argument
> => "Adam N/A Jensen"

> full_name 'Adam', 'Jensen', 'Aaron' # with 3rd arg
> => "Adam Aaron Jensen"

# Default Keyword Arguments --------------------------------
def full_name(first, last, middle: random_middle) # is now a key/value pair
  "#{first.strip} #{middle.strip} #{last.strip}".gsub("  ", " ")
end

# irb 
> full_name 'Adam', 'Jensen', 'A' # we can't set this up 
> error full_name: wrong number of arguments (given 3, expected 2) (ArgumentError)
> full_name 'Adam', 'Jensen' # but we can omit middle and it will call it
> => "Adam TBA Jensen"
> full_name 'Adam', 'Jensen', middle: 'A' # and we can provide it like this 
> => "Adam A Jensen"

# Required Keywords ---------------------------------------
def full_name(first, last, middle:) # looks like a default parameter but without a value
  "#{first.strip} #{middle.strip} #{last.strip}".gsub("  ", " ")
end

# irb
> full_name 'Adam', 'Jensen'
> error full_name: missing keyword: :middle (ArgumentError) # it hints at what's wrong 
> irb(main):046:0> full_name 'Adam', 'Jensen', 'Carl'
> error full_name: wrong number of arguments (given 3, expected 2; required keyword: middle) (ArgumentError) # again v helpful 
> irb(main):047:0> full_name 'Adam', 'Jensen', middle: 'Carl' # this is how to use it
> => "Adam Carl Jensen"

# Generally speaking, keyword arguments allow developers who consume your work to be less concerned about memorising parameter order at invocation.

# pass-by-value and pass-by-reference ===============================

value = "Adam"

def change_value val
  val = "something new"
end

puts value 

# irb
> change_value value
> => "something new"
> value
> => "Adam"

value = 3

# irb
> change_value value
> => "something new"
> value
> => 3

arr = [1,2,3]
> change_value arr
> => "something new"
> arr
> => [1,2,3]


def change_value val
  val[:something_else] = 'new stuff'
end

hash = {person: 'Adam'}

# irb 
> change_value hash
> => "new stuff"
> hash
> => {:person=>"Adam", :something_else=>"new stuff"} # value is modified 


def change_value val
  val << 5 # value will be modified because we are using an array operator 
end

> arr
> => [1, 2, 3]
> change_value arr
> => [1, 2, 3, 5] # value is modified 
> arr
> => [1, 2, 3, 5] # value has been modified 


# What's happening? 
# Certain types of data are known as pass-by-value, others are pass-by-reference.

value = "Adam" # string - pb value
value = 3 # integer, floats etc - pb value
arr = [1,2,3] # array - pb value / pb reference? 
hash = {person: 'Adam'} # hash - pb value / pb reference?

# .:. pass-by-value = When you pass something in, and it cannot be modified. It simply MAKES A COPY. Original doesn't change.
# .:. pass-by-reference = Original is and can be modified. 

# Moral of the story: be mindful as to what sort of behaviour we want to see. 

# Continued in project_rap_name_generator.rb 

# another way of modifying the array
name_ideas = []

def generate_rapper_name ideas
  ideas << "#{pick_one SALUTATIONS} #{pick_one VERBS} #{pick_one(ARTICLES)} #{pick_one(ADJECTIVES).capitalize}" 
end 

generate_rapper_name(name_ideas) 

# irb 
> generate_rapper_name(name_ideas)
> ["Ma'am Mix them Burgers"]
> generate_rapper_name name_ideas
> ["Ma'am Mix them Burgers", "Sir Scratch a Lot"]
> generate_rapper_name name_ideas
> ["Ma'am Mix them Burgers", "Sir Scratch a Lot", "Missus Pop them Lot"] # value is modified 
> name_ideas
> ["Ma'am Mix them Burgers", "Sir Scratch a Lot", "Missus Pop them Lot"] # value has been modified 

# we can also play around with it
5.times do 
 generate_rapper_name(name_ideas) # it passes in the bag of name ideas for us
end 

# irb 
> name_ideas
> =>
["Missus Pop them Trunk",
 "Mr Bomb those Bass",
 "Missus Drop a Drums",
 "Mr Drop the Lot",
 "Sir Drop the Bass"]

# Built-in vs Custom Methods ---------------------------------------
str = "hello"

# to use a built-in method, we invoke it at the end like so:
> str.length 
> 5

# to use a custom method, we prepend it and call the arguments like so:
> double_length("hello") 

# We can create our own custom methods by knowing which class to hack:
> str.class 
> => String 

class String
  def d_length # no parameters needed
    self.length * 2 # self appears in RED bc it's a Reserved Keyword. 
  end
end 

> str.d_length 
> 10

# Run self.class you'll see it's its own Object and cannot be assigned as a variable