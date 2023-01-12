# start with pseudocode 
# example name: Sir Mix A Lot --> consists of salutation, verb, article, adjective
# 1. generate random values for the anatomy of a name
# 2. combine those values in proper order

# start with how we'd pick a random salutation 
all_salutations = %w[Sir Ma'am Mr Mister Ms Miss Missus DJ]
salutation = all_salutations.sample
> => "Mr"

# now we know we have a pattern, we're 80% done. We can move on to the other words
all_salutations = %w[Sir Ma'am Mr Mister Ms Miss Missus DJ]
all_verbs = %w(Pop Mix Drop Bomb Flip Scratch)

salutation = all_salutations.sample
verb = all_verbs.sample 

# still a good idea to test in irb every step of the way (results condensed for simplicity)
> => "Ms"
> => "Flip" 

# and now we finish up 
all_salutations = %w[Sir Ma'am Mr Mister Ms Miss Missus DJ]
all_verbs = %w(Pop Mix Drop Bomb Flip Scratch)
all_articles = %w(the a 'em )
all_adjectives = %w(trunk burgers lot vinyl beat drums bass) 

salutation = all_salutations.sample
verb = all_verbs.sample 
article = all_articles.sample 
adjective = all_adjectives.sample.capitalize
> => "Mr"
> => "Pop"
> => "a"
> => "Trunk"

puts "My rap name is #{salutation} #{verb} #{article} #{adjective} !"

# finally, put all of this into a method 
def generate_rapper_name
  all_salutations = %w[Sir Ma'am Mr Mister Ms Miss Missus DJ]
  all_verbs = %w(Pop Mix Drop Bomb Flip Scratch)
  all_articles = %w(the a 'em )
  all_adjectives = %w(trunk burgers lot vinyl beat drums bass) 

  salutation = all_salutations.sample
  verb = all_verbs.sample 
  article = all_articles.sample 
  adjective = all_adjectives.sample.capitalize

  puts "My rap name is #{salutation} #{verb} #{article} #{adjective} !"
end

> generate_rapper_name
> My rap name is Mr Pop a Vinyl !
> => nil
> generate_rapper_name
> My rap name is DJ Flip 'em Drums !
> => nil
> generate_rapper_name
> My rap name is Mr Flip the Beat !
> => nil
'

# in order to aid inspection when things go wrong, we can give turn each expression into their own method 
def all_salutations
  %w[Sir Ma'am Mr Mister Ms Miss Missus DJ]
end

def all_verbs
  %w(Pop Mix Drop Bomb Flip Scratch)
end

def all_articles
  %w(the a 'em )
end

def all_adjectives
  %w(trunk burgers lot vinyl beat drums bass) 
end

# now we can work on DRY, although, "Duplication is far cheaper than the wrong abstraction" –Sandi Metz
# one way to refactor, is to not use .sample four times in the method 
def pick_one words
  words.sample # why? in case we decide .sample isn't the best method to use, we can easily impr ove / change it just once here
end

def full_rapper_name sal, ver, art, adj # work with/without ()
  puts "My rap name is #{sal} #{ver} #{art} #{adj} !"
end

def generate_rapper_name
  salutation = pick_one all_salutations # just mixing it up to show we can do without parentheses
  verb = pick_one all_verbs 
  article = pick_one(all_articles) # and with parentheses in Ruby 
  adjective = pick_one(all_adjectives).capitalize # method chaining requires the use of parentheses

  puts full_rapper_name(salutation, verb, article, adjective) # works with/without ()
end 

> generate_rapper_name
> My rap name is Miss Flip 'em Bass ! '
> generate_rapper_name
> My rap name is DJ Flip a Burgers !

# we can further refactor. there are still duplications that can be removed, like `all_`
def salutations
  %w[Sir Ma'am Mr Mister Ms Miss Missus DJ]
end

def verbs
  %w(Pop Mix Drop Bomb Flip Scratch)
end

def articles
  %w(the a 'em )
end

def adjectives
  %w(trunk burgers lot vinyl beat drums bass) 
end

def pick_one words
  words.sample 
end

def generate_rapper_name
  puts "#{pick_one salutations} #{pick_one verbs} #{pick_one(articles)} #{pick_one(adjectives).capitalize}" # again mixing up w&w/o () for fun
end 

> generate_rapper_name
> DJ Drop 'em Drums    '
> generate_rapper_name
> Mister Drop a Trunk

# each method only does one thing. Easy for future maintenance and enhancement.

# note: outer-scoped *methods* can be invoked within another method. Only variables cannot. 
# because in a way, they are within the same scope. In this eg, both are defined within Scope A 

# Scope A
def pick_one words
  # Scope B (inner scope of pick_one)
  words.sample 
end

# Scope A
def generate_rapper_name
  # Scope C (inner scope of generate_rapper_name)
  puts "#{pick_one salutations} #{pick_one verbs} #{pick_one(articles)} #{pick_one(adjectives).capitalize}" # again mixing up w&w/o () for fun
end 

# Constants ------------------------------------------
# one way to access an outer-scoped variable inside a method, is to use a constant
this = 'that' # variable assignment
THIS = 'THAT' # CONSTANT assignment i.e. a variable that is immutable 

# same as a variable, a CONSTANT needs to store value, but this value never needs to change 

HARD_CODED_SALUTATIONS = ['Sir']

def salutations2 # <-- don't have to pass it in
  HARD_CODED_SALUTATIONS # <-- just use it directly 
end

# so now we can refactor one more time. It might make more sense to use CONSTANT rather than def because basically we are just storing values. 

SALUTATIONS = %w[Sir Ma'am Mr Mister Ms Miss Missus DJ]
VERBS = %w(Pop Mix Drop Bomb Flip Scratch)
ARTICLES = %w(the a those them)
ADJECTIVES = %w(trunk burgers lot vinyl beat drums bass) 

def pick_one words
  words.sample 
end

def generate_rapper_name
  "#{pick_one SALUTATIONS} #{pick_one VERBS} #{pick_one(ARTICLES)} #{pick_one(ADJECTIVES).capitalize}" 
end 

# continued from methods.rb 

name_ideas = [] # start with this
name_ideas << generate_rapper_name # then do this, multiple times

# irb 
> name_ideas
> => [nil]
> name_ideas << generate_rapper_name
> => [nil, "Ma'am Pop a Lot"]
> name_ideas << generate_rapper_name
> => [nil, "Ma'am Pop a Lot", "DJ Drop them Trunk"]
> name_ideas << generate_rapper_name
> => [nil, "Ma'am Pop a Lot", "DJ Drop them Trunk", "Ms Mix them Drums"]
> name_ideas # it has been modified, .:. pass-by-reference
> =>
[nil,
 "Ma'am Pop a Lot",
 "DJ Drop them Trunk",
 "Ms Mix them Drums"]

