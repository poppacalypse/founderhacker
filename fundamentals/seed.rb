require 'faker'

10.times do
  GOODNAMES.employee(
    name: Faker::Name.unique.first_name 
  )
end