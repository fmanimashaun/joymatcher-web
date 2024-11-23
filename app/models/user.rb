class User < ApplicationRecord
  devise :confirmable, :database_authenticatable, :registerable, :recoverable, :validatable

  has_one :about, dependent: :destroy

  # Constants
  PASSWORD_FORMAT = /\A
    (?=.*\d)           # Must contain a digit
    (?=.*[a-z])        # Must contain a lower case character
    (?=.*[A-Z])        # Must contain an upper case character
    (?=.*[[:^alnum:]]) # Must contain a symbol
  /x

  # Validations
  validates :gender, inclusion: { in: %w[male female] }
  validates :interest, inclusion: { in: %w[male female] }
  validates :birthday, presence: true
  validates :membership, inclusion: { in: %w[free premium VIP] }
  validates :role, inclusion: { in: %w[user admin] }

  # Email validation
  validates :email,
            format: { with: URI::MailTo::EMAIL_REGEXP },
            presence: true,
            uniqueness: { case_sensitive: false }

  # Password validation
  validates :password,
            presence: true,
            length: { within: Devise.password_length },
            format: { with: PASSWORD_FORMAT },
            if: :password_required?

  # Custom validation for age
  validate :must_be_at_least_18_years_old

  # Delegate onboarded? to the associated About model
  delegate :onboarded?, to: :about, allow_nil: true

  private

  # Custom validation for age
  def must_be_at_least_18_years_old
    return unless birthday.present? && birthday > 18.years.ago.to_date

    errors.add(:birthday, "You must be at least 18 years old")
  end
end
