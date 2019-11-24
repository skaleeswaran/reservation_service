# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(current_user)
    if user.is_a? Admin
      can :manage, All
    elsif user.is_a?(RestaurantUser) or user.is_a?(Guest)
      can :manage, Reservation
    end
  end
end
