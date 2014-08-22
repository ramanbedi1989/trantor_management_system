# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
SeedData["designations"].each do |designation|
  Designation.create(name: designation)
end
SeedData["emp_types"].each do |type|
  EmpType.create(name: type)
end
SeedData["grades"].each do |grade|
  Grade.create(name: grade)
end
SeedData["confirmations"].each do |confirmation|
  Confirmation.create(name: confirmation)
end
SeedData["statuses"].each do |status|
  Status.create(name: status)
end
SeedData["locations"].each do |location|
  Location.create(name: location)
end
SeedData["lta_options"].each do |lta_option|
  LtaOption.create(name: lta_option)
end
SeedData["med_reimb_options"].each do |med_reimb_option|
  MedReimbOption.create(name: med_reimb_option)
end
SeedData["marital_statuses"].each do |marital_status|
  MaritalStatus.create(name: marital_status)
end
SeedData["loss_of_pays"].each do |loss_of_pay|
  LossOfPay.create(name: loss_of_pay)
end
SeedData["leaves"].each do |leave|
  Leave.create(name: leave)
end
SeedData["genders"].each do |gender|
  Gender.create(name: gender)
end

Project.create(name: "BDG")
User.create(username: "raman.bedi", card_no: "16609047", day_shift: true)
Holiday.create(name: "Independence Day", date: "15/08/2014".to_date, day_shift: true)