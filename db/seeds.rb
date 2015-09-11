seed_data = YAML.load_file("#{Rails.root}/db/seeds.yml")

[
  'designations', 
  'emp_types', 
  'grades',
  'confirmations',
  'statuses',
  'locations',
  'lta_options',
  'med_reimb_options',
  'marital_statuses',
  'loss_of_pays',
  'genders',
  'projects'
].each do |table|
  ActiveRecord::Base.connection.execute("TRUNCATE #{table}")
  seed_data[table].each do |val|
    table.classify.constantize.create(name: val)
  end
  puts "Populated data for <<#{table}>> successfully.".green
end

# Create Leaves Type
ActiveRecord::Base.connection.execute("TRUNCATE leaves")
seed_data["leaves"].each do |leave|
  Leave.create(name: leave)
  puts "Populated data for <<leaves>> successfully.".green
end