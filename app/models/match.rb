class Match < ApplicationRecord
  belongs_to :user1, class_name: "User"
  belongs_to :user2, class_name: "User"

  validates :user1_id, uniqueness: { scope: :user2_id }
  validate :users_must_be_different

  def other_user(user)
    user == user1 ? user2 : user1
  end

  private

  def users_must_be_different
    errors.add(:base, "Cannot match with yourself") if user1_id == user2_id
  end
end
