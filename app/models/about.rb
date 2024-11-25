class About < ApplicationRecord
  belongs_to :user

  has_many_attached :photos

  # Validations for regular users
  validates :firstname, :lastname, presence: true, unless: :admin_user?
  validates :marital_status,
            inclusion: { in: %w[single married separated divorced widowed] }, unless: :admin_user?
  validates :have_children, inclusion: { in: [true, false] }, unless: :admin_user?
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

  # Validate country and state presence for regular users
  validates :country, :state, presence: true, unless: :admin_user?

  # Custom photo validation to ensure at least one photo is attached and validates formats
  validate :photos_presence_and_format

  # Custom validation for country-state correspondence
  validate :validate_country_state_relationship, unless: :admin_user?

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

  # Validate that the country and state are consistent (state should exist for the country)
  def validate_country_state_relationship
    return if country.blank? || state.blank?

    country_obj = ISO3166::Country.find_country_by_name(country)
    if country_obj && !country_obj.subdivisions.key?(state)
      errors.add(:state, "must be a valid state for the selected country")
    end
  end
end
