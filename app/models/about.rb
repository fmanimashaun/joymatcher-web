class About < ApplicationRecord
  belongs_to :user

  has_many_attached :photos

  validates :firstname, :lastname, presence: true
  validates :marital_status,
            inclusion: {
              in: %w[single married separated divorced widowed]
            }
  validates :have_children, inclusion: { in: [ true, false ] }
  validates :education,
            inclusion: {
              in: [
                "High School",
                "Some College",
                "Associate Degree",
                "Bachelor's Degree",
                "Master's Degree",
                "Doctorate",
                "Other"
              ]
            }
  validates :ethnicity, inclusion: { in: %w[Asian Black Hispanic White Other] }
  validates :height, numericality: { greater_than: 0 }
  validates :body_type,
            inclusion: {
              in: [ "Slim", "Athletic", "Average", "Curvy", "Plus Size" ]
            }

  validate :photos_presence_and_format

  private

  def photos_presence_and_format
    if photos.attached?
      photos.each do |photo|
        if !photo.content_type.in?(%w[image/jpeg image/png])
          errors.add(:photos, "must be JPEG or PNG")
        elsif photo.blob.byte_size > 5.megabytes
          errors.add(:photos, "size should be less than 5MB")
        end
      end
    else
      errors.add(:photos, "must have at least one photo")
    end
  end
end
