FactoryBot.define do
  factory :about do
    user { nil }

    # Associations and fields for About model
    firstname { Faker::Name.first_name }
    lastname { Faker::Name.last_name }
    marital_status { [ 'single', 'married', 'divorced' ].sample }
    have_children { [ true, false ].sample }
    education { [ 'High School', 'Bachelor\'s Degree', 'Master\'s Degree' ].sample }
    ethnicity { [ 'Asian', 'Black', 'White' ].sample }
    height { Faker::Number.between(from: 150, to: 200) }
    body_type { [ 'Slim', 'Average', 'Athletic' ].sample }
    country { 'Lagos' }

    # Attach images with role-based logic
    before(:create) do |about|
      if about.user.role == 'admin'
        # Admin-specific image (SVG)
        admin_image_path = Rails.root.join('app', 'assets', 'images', 'default_admin_image.svg')

        about.photos.attach(io: File.open(admin_image_path), filename: 'default_admin_image.svg', content_type: 'image/svg+xml')

      else
        # Non-admin users: Attach default user image based on gender
        default_image_name = about.user.gender == 'male' ? 'default_user_male_image.jpg' : 'default_user_female_image.jpg'
        default_image_path = Rails.root.join('app', 'assets', 'images', default_image_name)

        about.photos.attach(io: File.open(default_image_path), filename: default_image_name, content_type: 'image/jpeg')

      end
    end
  end
end
