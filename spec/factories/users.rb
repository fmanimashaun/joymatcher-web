FactoryBot.define do
  factory :user do
    # Basic user fields
    email { Faker::Internet.unique.email } # Ensure unique emails
    password { 'Password123!' }
    password_confirmation { 'Password123!' }
    gender { [ 'male', 'female' ].sample }
    interest { [ 'male', 'female' ].sample }
    birthday { Faker::Date.birthday(min_age: 18, max_age: 100) }
    membership { [ 'free', 'premium', 'VIP' ].sample }
    role { [ 'user', 'admin' ].sample }

    # Forced confirmation
    confirmed_at { Time.current } # Force confirmation

    # Association: About
    after(:create) do |user|
      create(:about, user: user) # Create associated About record
    end
  end
end
