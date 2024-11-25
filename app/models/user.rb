class User < ApplicationRecord
  devise :confirmable, :database_authenticatable, :registerable, :recoverable, :validatable

  has_one :about, dependent: :destroy

  # Constants
  PASSWORD_FORMAT = /\A
  (?=.*\d)           # Must contain a digit
  (?=.*[a-z])        # Must contain a lower case character
  (?=.*[A-Z])        # Must contain an upper case character
  (?=.*[[:^alnum:]]) # Must contain a symbol
  \z/x

  GENDER_OPTIONS = %w[male female].freeze
  INTEREST_OPTIONS = %w[male female].freeze
  MEMBERSHIP_OPTIONS = %w[free premium VIP].freeze
  ROLE_OPTIONS = %w[user admin].freeze

  # Validation Messages
  AGE_ERROR_MESSAGE = "You must be at least 18 years old".freeze
  INCLUSION_ERROR_MESSAGE = "is not included in the list".freeze
  PASSWORD_FORMAT_ERROR_MESSAGE = "Password must include at least one digit, one lowercase letter, one uppercase letter, and one symbol.".freeze

  # Validations
  validates :gender, inclusion: { in: GENDER_OPTIONS, message: INCLUSION_ERROR_MESSAGE }
  validates :interest, inclusion: { in: INTEREST_OPTIONS, message: INCLUSION_ERROR_MESSAGE }
  validates :birthday, presence: true
  validates :membership, inclusion: { in: MEMBERSHIP_OPTIONS, message: INCLUSION_ERROR_MESSAGE }
  validates :role, inclusion: { in: ROLE_OPTIONS, message: INCLUSION_ERROR_MESSAGE }

  # Email validation
  validates :email,
            format: { with: URI::MailTo::EMAIL_REGEXP },
            presence: true,
            uniqueness: { case_sensitive: false }

  # Password validation
  # validates :password,
  #           presence: true,
  #           length: { within: Devise.password_length },
  #           format: { with: PASSWORD_FORMAT, message: PASSWORD_FORMAT_ERROR_MESSAGE },
  #           if: :password_required?

  # Custom validation for age
  validate :must_be_at_least_18_years_old

  # Delegate onboarded? to the associated About model
  delegate :onboarded?, to: :about, allow_nil: true

  private

  # Custom validation for age
  def must_be_at_least_18_years_old
    return unless birthday.present? && birthday > 18.years.ago.to_date

    errors.add(:birthday, AGE_ERROR_MESSAGE)
  end
end
