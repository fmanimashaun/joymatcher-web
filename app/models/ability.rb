class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new  # guest user (not logged in)

    # Admins have full access to all resources
    if user.role == "admin"
      can :manage, :all

    # Regular users
    elsif user.role == "user"
      can :read, :all  # Can read all content

      # Premium and VIP users can access premium content
      can :access, :premium_features if user.membership == "premium" || user.membership == "VIP"

      # VIP users have access to exclusive VIP features
      can :access, :vip_features if user.membership == "VIP"

    # Guest users can access public content only
    else
      can :read, :public_content
    end
  end
end
