# Challenge 2: Array of hashes with a name and an email per hash
# 25 names + emails 
# [{
#   { name: 'Ryan', email: 'ryan@somewhere.com'}
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