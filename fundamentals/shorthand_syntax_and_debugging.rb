# DEBUGGING 
require 'pry'

# pry freezes code execution in 'real time', so you can see each loop step-by-step

[1,2,3,4,5].each do |num|
  binding.pry # frozen in time right here 
end 

#irb
> pry 
> [1] pry(main)> [1,2,3].each do |num|
>  binding.pry
>end
> [1] pry(main)> num
> => 1 # showing us the first loop out of [1,2,3]
> [2] pry(main)> puts num
> 1
> => nil
> [3] pry(main)> # blank enter -- number goes to [4] to show steps
>[4] pry(main)> # here we exit Ctrl D

> [1] pry(main)> num
> => 2 # showing us the second loop out of [1,2,3]
> [2] pry(main)> # Ctrl D

> [1] pry(main)> num
> => 3
> [2] pry(main)> # Ctrl D

> => [1, 2, 3]
> [2] pry(main)> # Ctrl D 

> irb(main):004:0> # once the loop finishes, it exits Pry. Typing num here will produce error, because we are now out of scope. irb doesn't know what binding.pry is. 

# let's try sth more interesting 
[1,2,3,4,5].each do |num|
  if num > 3 
    binding.pry 
  end 
end 

> [1] pry(main)> num
> => 4
> [2] pry(main)> # Ctrl D

> [1] pry(main)> num
> => 5
> [2] pry(main)> # Ctrl D 

> => [1, 2, 3, 4, 5]
> [3] pry(main)> # Ctrl D
> => nil
irb(main):006:0>

# -----------------------------------------------------------------------
# SHORTHAND SYNTAX 

# Collections with regular elements
collection.each do |parameter_name|
  # if you have only one line of code (loc) to do something
end 

# Common shorthand: replace `do` with `{` and replace `end` with `}`
collection.each { |parameter_name| 'do something' }

# Example 
collection = ["Adam", "Carl"]

# long-form (each...do)
collection.each do |name|
  puts name
end 
> Adam
> Carl
> => ["Adam", "Carl"]

# short-hand ({})
collection.each { |name| puts name }
> Adam
> Carl
> => ["Adam", "Carl"]

# it can potentially take in multiple lines, but doesn't look as good.
collection.each { |name| 
  puts name.reverse 
  puts name.chars 
  puts name.length 
}
# or alternaitvely, still put in one line, but separated with a `;` (otherwise Ruby doesn't recognise that the line is terminated)
collection.each { |name| puts name.reverse; puts name.chars; puts name.length }

# but doesn't quite make sense. So reserve shorthand for one-liners. 

# BACK TO DEBUGGING -------------------------------------------------
# we could debug within the shorthand code 
collection.each { |name| binding.pry; puts name.reverse }


# Loops often break, and we need to dig in to that to see where it's breaking. 
# Using an extension of the looping method `_with_index` . Not a separate method, but a POWER UP of each...
names = %w(Adam Carl Bruce Ivy Derek AJ)

# ...that requires us to create another parameter, typically called `idx` (index)
names.each_with_index do |name, idx| # also works with .map_with_index & other looping methods
  puts "sitting at index number #{idx} is #{name}"
end 

# example: identify where the problem is halfway through the list
names.each_with_index do |name, idx|
  if idx >= names.length.to_f / 2 
    puts "trouble starts here... index #{idx} #{name} "
    binding.pry
  end
  # we might have tonnes of other code here, but slit a little debugger above to figure out what's wrong 
end 

> trouble starts here... index 3 Ivy
> [1] pry(main)> idx
=> 3
> [2] pry(main)> name
> => "Ivy"

# we can expand the code more then 'step through' the code to see where the problem is 
names.each_with_index do |name, idx|
  if idx >= 1 
    puts "trouble starts here... index #{idx} #{name}"
    binding.pry
  end 

  surname = "Zomb" if name.length <= 4

  name += "Wassup" 
  puts "name + surname: #{name} + #{surname}"
  name + surname
end 

# a clear illustration of 'stepping through' -- we can test each line of code within pry 
> name + surname: AdamWassup + Zomb
> trouble starts here... index 1 Carl
> [1] pry(main)> surname = "Zomb" if name.length <= 4 # copypaste from L131. okay so far so good 
> => "Zomb"
> [2] pry(main)> name += "Wassup" # test the next line 
> => "CarlWassup"
> [3] pry(main)> name + surname # all good 
> => "CarlWassupZomb"
> [4] pry(main)>
> 
> name + surname: CarlWassupWassup + Zomb
> trouble starts here... index 2 Bruce
> [1] pry(main)> surname = "Zomb" if name.length <= 4 # here's where we get a clue something is not right. Returns `nil`
> => nil
> [2] pry(main)> name += "Wassup" # this one still works 
> => "BruceWassup"
> [3] pry(main)> name + surname # this is where things break. Bc you can't add `nil` 
> TypeError: no implicit conversion of nil into String
> from (pry):17:in `+`
> [4] pry(main) 

# `system 'clear'`
nums = (1..1000).to_a 

nums.each_with_index do |num, idx|
  progress = (100 * (idx.to_f / nums.count).round(2))
  system 'clear'
  puts "Progress: #{progress}%"
end 

# try on irb! pretty cool, counts up to 100% 
# also try by commenting out `system 'clear'`


# DEBUGGING REVISITED -------------------------------------------------
# binding.pry is great for debugging, but you can't use it in production. Browser will crash.
# Here's a more precise way to debug AND deploy to production, w/o adverse effect to the end-user.
# First, we need to understand different 'types' of errors -

# 1 
> numbers = [1,2,3]
> number.class # we know what class this is
> => Array 

# We know each class has its own methods
# Some classes share the same methods
> numbers.length # Array
> 3
> "hello".length # String 
> 5

# But there are some methods that aren't shared between classes
> "hello".chars 
> => ["h", "e", "l", "l", "o"]
> numbers.chars  # no such thing as a character within an Array
> NoMethodError (undefined method `chars` for [1, 2, 3]:Array)
> e = [1,2,3].chars # won't work even if we try to set it as a variable
> NoMethodError (undefined method `chars` for [1, 2, 3]:Array) # we're invoking a real method, but the data type isn't accurate
> e 
> => nil 
> NoMethodError.class # we didn't create this method, but it exists
> => Class 

# Let's create a few more...
# 2
outer_scoped_variable = 'asdf'
def do_something!
  puts outer_scoped_variable 
end
> do_something! # if we try to leverage tt outer-scoped variable in the method, w/o passing it in as an argument
> NameError (undefined local variable or method `outer_scoped_variable` for main:Object)

# 3
# here we define two parameters
def full_name(first, last)
  "#{first} #{last}"
end
# which means we need to pass in two arguments
> full_name('Adam', 'Jensen')
> => "Adam Jensen"

# what happens if we pass in 1 argument? 
> full_name('Adam')
> ArgumentError (wrong number of arguments (given 1, expected 2))
# or 3 arguments?
> full_name('Adam', 'Jensen', 'A')
> ArgumentError (wrong number of arguments (given 3, expected 2))

# 4
five = nil 
> five + 4 # nil + 4
> NoMethodError (undefined method `+` for nil:NilClass) # there is no method to nil. We're invoking a real method that's available to another Class, but the Object we have is nil. 

# aside: operators are also just methods
+, -, +=, -=, *, ...
# inside of Ruby, the method might look sth like
# eg. 5 + 4 or 5+4 or 5+(4)
class Integer
  def +(num)
    self + 4 # does Maths in here
  end
end 
# so '+' is its own method
# .:. error #4 is the same as error #1 - NoMethodError. Ruby doesn't recognise the method.

# in our effort to debug, we were busting out all of these tools:
- ..._with_index
- puts "working on this element... #{element_name}"
- if ... end... (if idx == 50) binding.pry 
- binding.pry 
# problem: we need to remember where we inserted all these, and which are to be taken out once bug is fixed.

# Enter: Rescue.


# RESCUE -----------------------------------------------------------------------

# if binding.pry is like a butcher knife, rescue is like a scalpel

#there are 3 parts to the syntax:
begin
  # intended behaviour (Plan A) <-- binding.pry only gets you this far
rescue 
  # if something goes wrong, a backup plan (Plan B)
end 

arr = [1,2,nil,3].map do |num|
  num * 3
end 
> => error 

new_arr = [1,2,nil,3].map do |num|
  num * 3
end 
> new_arr 
> => nil

another_array = [1,2,nil,3].map do |num|
  begin # intended behaviour i.e. Plan A
    num * 3
  rescue # if something goes wrong, do Plan B
    # Plan B can be "do nothing"
  end 
end 
> another_array
> => [3, 6, nil, 9] # if it couldn't do it, it didn't do it. Everything looks clean.

# let's look back at the type of errors we spotted. So far 3:
- NoMethodError
- NameError
- ArgumentError 

# passing .class method gets us `=> Class` for all 3.
# if we pass the superclass method into them, we'll discover:
> NoMethodError.superclass 
> => NameError
> NameError.superclass 
> => StandardError 
> ArgumentError.superclass 
> => StandardError 

# what's a StandardError?
> StandardError.superclass 
=> Exception 

# a more technical way to describe errors is Exception. We hear devs say, "It raised an exception".
# errors = "I wanted sth to happen and it didn't"
# Exception can be defined. "Was it a NoMethodError?" We can describe exactly what went wrong in a granular way.

# visual tree of Exceptions in Ruby
Exception
  - StandardError 
    - ArgumentError
    - NameError 
      - NoMethodError 
      - ...
    - ...

# so when we do a Rescue
begin
rescue # this is where the magic happens i.e. what type of Error we're rescuing 
end

begin
rescue StandardError # allows us to skip running bad code when the error msg is any child under StandardError. 
                     # Not including it means we rescue all Exceptions, generally a bad practice. 
end 

# let's re-run the code with StandardError included
one_more_array = [1,2,nil,3].map do |num|
  begin
    num * 3
  rescue StandardError
    # do nothing
  end
end
> => [3, 6, nil, 9]

# let's include a Plan B
one_more_array = [1,2,nil,3].map do |num|
  begin
    num * 3
  rescue StandardError
    0 
  end
end
> => => [3, 6, 0, 9] # voila! 

one_more_array = [1,2,nil,3].map do |num|
  begin
    num * 3
  rescue StandardError => e # same as `do |e|`. We're taking whatever error it is that broke it, and calling it `e`
    binding.pry # binding.pry and rescue are not mutually exclusive. More powerful when used together.
  end
end
> require 'pry'
> # copypaste code above 
pry > num 
    => nil # remember we've already done Begin and we're in the Rescue block now  
    > e 
    => <NoMethodError: undefined method `*` for nil:NilClass> # same msg we were seeing before we had Rescue. 
                                                              # We've 'caught' the error

# .:. Rescue rescues us from breaking the code and it catches the error. 
# But it only puts it inside of a parameter we can work with and inspect, if we use the hashrocket `=> e`
# we can use any variable in place of `e`. Dev convention is to use `e` for error.
# (`e` is a variable parameter because it's an inner-scoped variable)

# `e` has its own methods, but first let's explore its Class.
pry > e.class
    => NoMethodError 

# another sidetrack: if you call the .methods method , you will see a list of methods available to the value in Ruby
> 5.class 
=> Integer 
> 5.methods
:to_int,
:to_s,
:to_i,
:divmod,
:modulo,
:remainder,
:abs,
:magnitude,
:integer?,
.
.
.
# .:. we can call .methods on `e` because `e` is an Object, like everything else in Ruby.
pry > e.methods 
    :private_call?,
    :original_message,
    :corrections,
    :spell_checker,
    :to_s,
    .
    .
    .
pry > e.to_s 
    => "undefined method `*` for nil:NilClass"
    > e.message 
    => "undefined method `*` for nil:NilClass"
    > e.full_message 
    => "\e[1mTraceback\e[m (most recent call last):\n\t21: from /Users/adc/.gem/ruby/2.7.6/bin/irb:25:in `<main>`\n\t20: from...."

# now that we have a tonne of insight into what `e` is, we can try this:
one_more_array = [1,2,nil,3].map do |num|
  begin
    num * 3
  rescue StandardError => e 
    puts e.message # we can do this 
    0 # and we also want to assume that the number is 0
  end
end

# and by doing so, we get these results - best of both worlds, i.e.:
=> undefined method `*` for nil:NilClass # we're logging the error AND
=> [3, 6, 0, 9]                          # we're continuing the loop + not risking breaking everything 
                                         # (just bc one element is breaking)

# in Ruby there's a nice inheritance feature, whereby even if you don't specify `StandardError`, it assumes everything belongs to `StandardError` anyway. So we can write:
one_more_array = [1,2,nil,3].map do |num|
  begin
    num * 3
  rescue => e # can omit `StandardError`
    puts e.message 
    0 
  end
end

# we will still get the same results as above
=> undefined method `*` for nil:NilClass
=> [3, 6, 0, 9]

# We can also make Rescue more precise, instead of catching everything under the `StandardError` umbrella.
some_array = [1,2,nil,3].map do |num|
  begin
    num * 3
  rescue NoMethodError => e
    puts e.message 
    binding.pry 
    0 
  end
end
=> undefined method `*` for nil:NilClass # works here. It won't work if there's any other error in the code.

#eg. an outer-scoped variable that isn't defined:
some_array = [1,2,nil,3].map do |num|
  begin
    num * 3
    random_outerscoped_var_here # this var / method does not exist 
  rescue StandardError => e # let's revert this to SE for the time being 
    puts e.message 
    binding.pry 
    0 
  end
end
pry => undefined local variable or method `random_outerscoped_var_here` for main:Object
    > e.message 
    => "undefined local variable or method `random_outerscoped_var_here` for main:Object"
    > e.class 
    => NameError # so it caught this, because NameError is a child of StandardError 

# what if only want to rescue NoMethodError specifically? 
some_array = [1,2,nil,3].map do |num|
  begin
    num * 3
    random_outerscoped_var_here # this will result in a NameError
  rescue NoMethodError => e 
    puts "WE'RE IN PRY SUCCESSFULLY"
    binding.pry 
    0 
  end
end
=> Traceback....undefined local variable or method `random_outerscoped_var_here` for main:Object (NameError)
# we never landed in pry because the NameError is not _allowed_ to be caught (NoMethodError is a child of NameError)

some_array = [1,2,nil,3].map do |num|
  begin
    num * 3
    random_outerscoped_var_here 
  rescue NameError => e # go up one level in the error tree, to allow the error to pass through
    puts "WE'RE IN PRY SUCCESSFULLY"
    binding.pry 
    0 
  end
end
pry => "WE'RE IN PRY SUCCESSFULLY"

# to test it:
pry > num 
    => 1 # so this worked in its first loop run 
    > e 
    => <NameError: undefined local variable or method `random_outerscoped_var_here` for main:Object> # this is the line that broke, the line after `num * 3`
    > e.message
    => "undefined local variable or method `random_outerscoped_var_here` for main:Object"

# .:. the double-edged sword of rescue when passing in an Exception class - when we use sth too specific, it won't pass through. 

# if you only put default values, you will get a lot of bugs. eg:
an_array = [1,2,nil,3].map do |num|
  begin 
    num * 3
    random_outerscoped_var_here
  rescue NameError => e 
    0 # like so
  end
end 

# what rescue is particularly good for, is 
# A.) when using a 3rd party tool / some dependency / pinging another server.
# where the code is not under your control. you may not know whether it's working or not etc. 
s = something.each do |xyz|
  begin
    # what's supposed to happen
  rescue ServerNotResponding => e 
    puts "Weather service is down"
    binding.pry 
    # ping another server 
  end
end
# B.) where the code is not super critical. 

# if it is critical, don't use a rescue block. it's better to let the code scream at you.


outer_scoped_variable = 'hello'
def do_something!
  puts outer_scoped_variable
end
> do_something!
=> Traceback.... NameError 
# not gonna work because... When we introduce a var outside of a Method™, it's available inside of the method IF AND ONLY IF  we pass it in as a method argument (see looping.rb L49) Only CONSTANTS are accessible outside of method.


# you can put a rescue block inside a method, too. 
outer_scoped_variable = 'hello'
def do_something!
  begin 
    puts outer_scoped_variable # i.e. Plan A 
  rescue 
    # Plan B(ackup) - optional 
  end 
end
> do_something!
=> nil # which means it landed in Plan B 

# we can insert something into Plan B, and watch it in action 
outer_scoped_variable = 'hello'
def do_something!
  begin 
    puts outer_scoped_variable # i.e. Plan A 
  rescue 
    puts "something went wrong..."
  end 
end
> do_something!
=> something went wrong... # evidence of rescue working as it's supposed to.

# but no error screamed at us. It's clean, suppressed. 

# We don't have to use `begin` when rescuing a method. Ruby assumes the first line is the beginning and assigns it as `begin`
def do_something_else!
  puts outer_scoped_variable # Plan A
rescue 
  puts "something went wrong..." # Plan B
end
> do_something_else! 
=> something went wrong... 

# Use `begin` in a method when you have many lines of code, and you want to be surgically precise in where to begin rescuing it
def do_the_thing!
  # LOC 1
  # LOC 2
  # LOC 3
  # LOC 4
  begin 
    # LOC 5
    # LOC 6
  rescue => e 
    puts e.message 
    puts "something went wrong..."
  end
end

# In Ruby, to rescue multiple "types" of errors just separate them by commas, e.g:
rescue => NameError, ArgumentError