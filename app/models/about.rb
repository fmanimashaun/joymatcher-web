class About < ApplicationRecord
  belongs_to :user

  has_many_attached :photos

  validates :firstname, :lastname, presence: true, unless: :admin_user?
  validates :marital_status,
            inclusion: { in: %w[single married separated divorced widowed] }, unless: :admin_user?
  validates :have_children, inclusion: { in: [ true, false ] }, unless: :admin_user?
  validates :education,
            inclusion: {
              in: [
                "High School", "Some College", "Associate Degree", "Bachelor's Degree",
                "Master's Degree", "Doctorate", "Other"
              ]
            }, unless: :admin_user?
  validates :ethnicity, inclusion: { in: %w[Asian Black Hispanic White Other] }, unless: :admin_user?
  validates :height, numericality: { greater_than: 0 }, unless: :admin_user?
  validates :body_type,
            inclusion: { in: [ "Slim", "Athletic", "Average", "Curvy", "Plus Size" ] }, unless: :admin_user?

  # Ensure at least one photo is attached for all users
  validate :photos_presence_and_format

  private

  # Custom validation to ensure at least one photo is attached
  def photos_presence_and_format
    if photos.attached?
      photos.each do |photo|
        # Only allow JPEG and PNG for regular users
        if !admin_user? && !photo.content_type.in?(%w[image/jpeg image/png])
          errors.add(:photos, "must be JPEG or PNG")
        # Allow SVG only for admins
        elsif admin_user? && !photo.content_type.in?(%w[image/jpeg image/png image/svg+xml])
          errors.add(:photos, "must be JPEG, PNG, or SVG")
        elsif photo.blob.byte_size > 5.megabytes
          errors.add(:photos, "size should be less than 5MB")
        end
      end
    else
      errors.add(:photos, "must have at least one photo")
    end
  end

  # Check if the associated user is an admin
  def admin_user?
    user&.role == "admin"
  end
end
