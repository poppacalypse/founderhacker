# Challenge 3: Every email comprises first initial of first name, last name, and company name 
# 25 names + emails 
# [{
#   { name: 'Dorla Feest', email: 'd.feest@gmail.com'}
# }]

# attempt 0 -----------------------------------------------------------
# works! but Faker seems to randomly place the first name initial after the last name, e.g. feest.d@gmail.com  

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

# irb
> full_list 
=>
[{:name=>"Violette Champlin", :email=>"champlin.v@abshire.org"}, # see here
 {:name=>"Omer Schiller", :email=>"schiller.o@grady.co"}, # and here
 {:name=>"Franklin Runolfsdottir", :email=>"f.runolfsdottir@hickle.name"},
 {:name=>"Marjorie Reinger", :email=>"m.reinger@gulgowski.co"},
 {:name=>"Emmitt Gerhold", :email=>"gerhold.e@grimes.net"}, # so random 
 {:name=>"Katelin Lindgren", :email=>"lindgren.k@hessel.net"}, # gah!
.
.
.


# attempt 1 -----------------------------------------------------------
# have to do it this way to get [initial].[lastname]@[company.domain]

full_list = []

def get_full_name_and_email(full_list)
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name 
  full_name = "#{first_name} #{last_name}"

  email = "#{first_name.split("")[0]}.#{last_name}@#{Faker::Internet.domain_name}".downcase

  full_list << { name: full_name, email: email }
end

25.times { get_full_name_and_email(full_list) }