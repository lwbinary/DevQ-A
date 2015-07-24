# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
puts "Running seed.rb"

#create_account = User.create([email: 'example@gmail.com', password: '12345678', password_confirmation: '12345678', name: 'TestingSeedUser'])

puts "This seed.rb will auto build 20 groups which individully contain 30 posts."

create_account = User.create([email: 'example@gmail.com', password: '12345678', password_confirmation: '12345678', name: 'TestUser'])

create_groups = 
	for i in 1..20 do
    Group.create!([title: "Group no.#{i}", description: "Using seed to build #{i} group", user_id: "1"])
    for k in 1..30 do
      Post.create!([group_id: "#{i}",content: "Using Seed to build #{k} post", user_id: "1"])
    end
  end