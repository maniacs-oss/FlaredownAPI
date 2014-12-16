# Some user
u=User.create(email: "dataguy@test.com", password: "testing123", password_confirmation: "testing123", catalogs: ["hbi"])

# Add some random entries for them, based off of spec/factories/entry_factory.rb
10.times do |n|
  FactoryGirl.create :hbi_entry, user: u, date: Date.today-n.days

  # Responses are built automatically, but you can override using build instead of create, then save
  # entry = FactoryGirl.build :hbi_entry, user: u, date: Date.today-n.days
  # entry.responses << build(:response, {catalog: "hbi", name: :general_wellbeing , value: 1})
  # entry.save
end

# Some distribution stuff I don't know how to use...
Distribution::T.cdf 1,1