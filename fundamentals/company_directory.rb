# Project: Company Directory (featuring Faker)

# Project 1: 100 names, only names with 5+ chars

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
# results include empty [], must use reject or puts to clean up at the end

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
# results still contain empty [], still need reject to clean up 

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
  return name_list
end

100.times { get_name(name_list) until name_list.length == 100}

> name_list # produces clean result
> name_list.length
=> 100 
> name_list.sort # alphabetised 

# ====================================================================
# Project 2: Array of hashes with a name and an email per hash
# 25 names + emails 
# [{
#   { name: 'Adam', email: 'adam@sarif.ind'}
# }]

# attempt 0 -----------------------------------------------------------
# generate name and company name, concatenate both into email address

email_list = []

def get_name_and_email(email_list)
  name = Faker::Name.unique.first_name
  company = Faker::Company.name.downcase.split(/[\s,']/).join

  # email = name.downcase + "@" + company + ".com"
  email = "#{name.downcase}@#{company}.com"

  email_list << { name: name, email: email }
end

25.times { get_name_and_email(email_list) }

# attempt 1 -----------------------------------------------------------
# use Faker email generator - cleaner, save 1 LOC 

email_list = []

def get_name_and_email(email_list)
  name = Faker::Name.unique.first_name
  email = Faker::Internet.email(name: name)

  email_list << { name: name, email: email }
end

25.times { get_name_and_email(email_list) }


# ====================================================================
# Project 3: Every email comprises first initial of first name, last name, and company name 
# 25 names + emails 
# [{
#   { name: 'Adam Jensen', email: 'a.jensen@sarif.ind'}
# }]

# attempt 0 -----------------------------------------------------------
# ! works but Faker seems to randomly shift first name initial to after the '.' 

full_list = []

def get_full_name_and_email(full_list)
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name 
  full_name = "#{first_name} #{last_name}"
  email_name = "#{first_name.split("")[0]} #{last_name}".downcase

  email = Faker::Internet.email(name: email_name, separators: '.')

  full_list << { name: full_name, email: email }
end

25.times { get_full_name_and_email(full_list) }

# attempt 0 -----------------------------------------------------------
full_list = []

def get_full_name_and_email(full_list)
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name 
  full_name = "#{first_name} #{last_name}"

  email = "#{first_name.split("")[0]}.#{last_name}@#{Faker::Internet.domain_name}".downcase

  full_list << { name: full_name, email: email }
end

25.times { get_full_name_and_email(full_list) }
