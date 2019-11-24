# frozen_string_literal: true

class Guest < User
  has_many :reservations
  has_many :restaurants, through: :reservations
end
