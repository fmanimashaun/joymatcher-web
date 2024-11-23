# Clear existing data (use with caution in production)
User.delete_all
About.delete_all

# Create the Admin User
admin_user = FactoryBot.create(:user,
                                role: 'admin',
                                membership: 'VIP',
                                gender: 'male',
                                email: 'admin@joymatcher.com')
puts "Admin user created: #{admin_user.email}"

# Create 10 Female Users
10.times do |i|
  female_user = FactoryBot.create(:user,
                                  gender: 'female',
                                  email: "female#{i + 1}@joymatcher.com")
  puts "Female user created: #{female_user.email}"
end

# Create 10 Male Users
10.times do |i|
  male_user = FactoryBot.create(:user,
                                gender: 'male',
                                email: "male#{i + 1}@joymatcher.com")
  puts "Male user created: #{male_user.email}"
end
