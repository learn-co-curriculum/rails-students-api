# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

(0..9).each do |number|
  Cohort.create(name: "Ruby-00#{number}", kind: "Web")
end

Cohort.all.each do |cohort|
  5.times do
    name = Faker::Name.name
    email = Faker::Internet.email(name)
    student = Student.create(name: name, email: email)
    cohort.students << student
  end
  cohort.save
end