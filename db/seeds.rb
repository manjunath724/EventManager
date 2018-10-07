# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

10.times do |t|
  name = Faker::Internet.username
  email = Faker::Internet.safe_email
  pass = Faker::Internet.password
  phone = Faker::PhoneNumber.cell_phone
  user = User.create(name: name, email: email, phone: phone, password: pass, password_confirmation: pass)

  p "#{t + 1}. Created: #{user.inspect}"
end
