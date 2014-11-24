# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.transaction do
  1..40.times do |i|
    user = User.create!(surname: "Surname#{i}",
                       firstname: "Firstname#{i}",
                       email: "cwl#{i}@aber.ac.uk",
                       phone: '01970 622422',
                       jobs:      true,
                       grad_year: 1985)
    UserDetail.create!(login: "cwl#{i}",
                       password: 'secret',
                       user: user)
  end
  # Create one special admin user
  user = User.create!(surname: 'Slater',
                      firstname: 'James',
                      email: 'jas38@aber.ac.uk',
                      phone: '07875671207',
                      grad_year: 1985)
  UserDetail.create!(login: 'admin',
                     password: 'password',
                     user: user)

  # Create some dummy feeds
  Feed.create!(name: 'twitter')
  Feed.create!(name: 'facebook')
  Feed.create!(name: 'email')
  Feed.create!(name: 'RSS')
  Feed.create!(name: 'atom')
end