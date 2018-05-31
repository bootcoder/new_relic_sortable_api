10.times do
  Company.create!(name: "#{Faker::Company.name} #{Faker::Company.suffix}")
end

Company.all.each do |company|
  rand(10..15).times do
    company.customers.create!(
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name)
  end
end
