FactoryBot.define do
  factory :about do
    user { nil }
    firstname { "MyString" }
    lastname { "MyString" }
    marital_status { "MyString" }
    have_children { false }
    education { "MyString" }
    ethnicity { "MyString" }
    height { "9.99" }
    body_type { "MyString" }
  end
end
