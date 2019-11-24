# frozen_string_literal: true

class Restaurant < ApplicationRecord
  has_many :reservations
  has_many :guests, through: :reservations

  has_many :restaurant_users, inverse_of: :restaurant

  validates :name, :cuisines, :location, :opening_hours, :phone, presence: true
  validates :name, uniqueness: true
  validates :phone, format: { with: Validator::PHONE_REGEX }
  validates :email, length: { maximum: 100 }, format: { with: Validator::EMAIL_REGEX }, presence: true
  validates_time :opening_hours

  serialize :cuisines, Array
end
