class Like < ApplicationRecord
  belongs_to :liker, class_name: "User"
  belongs_to :likee, class_name: "User"

  validates :liker_id, uniqueness: { scope: :likee_id }
  validate :cannot_like_self

  enum :status, { pending: 0, accepted: 1, rejected: 2 }, default: :pending

  after_create :check_for_match
  after_destroy :unmatch_users

  def accept
    update(status: :accepted)
    check_for_match
  end

  def reject
    update(status: :rejected)
    unmatch_users
  end

  private

  def cannot_like_self
    errors.add(:base, "Cannot like yourself") if liker_id == likee_id
  end

  def check_for_match
    if status == "accepted" && Like.exists?(liker: likee, likee: liker, status: :accepted)
      Match.find_or_create_by(user1: [ liker, likee ].min, user2: [ liker, likee ].max)
    end
  end

  def unmatch_users
    # Use safe navigation operator (&.) to ensure the method is called only if `liker` and `likee` exist
    liker&.unmatch(likee)
  end
end
