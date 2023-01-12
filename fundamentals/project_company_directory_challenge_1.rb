# Project: Company Directory (featuring Faker)
# Challenge 1: 100 names, only names with 5+ chars, sorted alphabetically.

# Hey Ryan! Thanks for letting us email you. 
# This is what I came up with for Challenge 1, after several attempts.
# I still don't know how to sort it alphabetically within the method, though

# attempt 4 
name_list = []

def get_name(name_list)
  name = Faker::Name.unique.first_name
  name_list << (name if name.length >= 5)
end

100.times { get_name(name_list) until name_list.length == 100}

name_list.sort 

#irb 
> name_list # produces clean result
> name_list.length
=> 100 

# =============================================================
# Prior to this, I tried so many things.
# But I enjoyed the challenge. This really good training! 

# attempt 0 -----------------------------------------------------------
# using constants results in repeated elements within array. big mess -_-"

GOODNAMES = []
SHORTNAMES = []

def employee
  fakename = Faker::Name.unique.first_name

  if fakename.length >= 5
    GOODNAMES << fakename
  else
    SHORTNAMES << fakename
  end
end

arr = []

20.times { arr << employee until arr.length == 10 }


# attempt 1 -----------------------------------------------------------
# results include empty [], must use `reject` or `puts` to clean up at the end

def generate_staff_name
  arr = [] 
  staff_name = Faker::Name.unique.first_name

  if staff_name.length >= 5
    arr << staff_name
  else
    nil
  end

  arr
end

staff_roll = []
100.times { staff_roll << generate_staff_name until staff_roll.reject(&:empty?).length == 20 }

staff_roll.reject(&:empty?)
OR 
puts staff_roll # will puts only non-empty values 


# attempt 2 -----------------------------------------------------------
# trying out with 2 arrays , ignore arr2, only return arr
# results still contain empty [], still need `reject` to clean up 

def generate_staff_name
  arr = [] 
  arr2 = []
  staff_name = Faker::Name.unique.first_name

  if staff_name.length >= 5
    arr << staff_name
  else
    arr2 << staff_name 
  end

  arr
end

staff_roll = []
20.times { staff_roll << generate_staff_name }

staff_roll = []
100.times { staff_roll << generate_staff_name until staff_roll.reject(&:nil?).length == 20 }

staff_roll.reject(&:nil?)


# attempt 3 -----------------------------------------------------------
# by far the cleanest solution. no empty [], does not require cleanup.

arr = []

def generate_staff_name(arr)
  staff_name = Faker::Name.unique.first_name

  if staff_name.length >= 5
    arr << staff_name
  else
    nil
  end

  arr 
end

50.times { generate_staff_name(arr) until arr.length == 10}
# need to start with a bigger number to give it room to skip the <5 char names
# e.g. if we do 
10.times { generate_staff_name(arr) }
# we may only get arr.length => 8 

> arr # produces clean result
> arr.length
=> 10 

# UPDATE: doing this will get the same results; no need to start with bigger number. it seems to continue going until hits the `until` number 
10.times { generate_staff_name(arr) until arr.length == 10}


# attempt 4 -----------------------------------------------------------
# a refactor of attempt 3

name_list = []

def get_name(name_list)
  name = Faker::Name.unique.first_name
  name_list << (name if name.length >= 5)
  # return name_list.sort
end

100.times { get_name(name_list) until name_list.length == 100}

> name_list # produces clean result
> name_list.length
=> 100 
> name_list.sort # alphabetised 