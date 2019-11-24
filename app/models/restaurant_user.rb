# frozen_string_literal: true

class RestaurantUser < User
  belongs_to :restaurant, inverse_of: :restaurant_users
  has_many :reservations, foreign_key: :created_by
end
