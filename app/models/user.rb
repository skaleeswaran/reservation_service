# frozen_string_literal: true

class User < ApplicationRecord
  has_many :reservations

  validates :first_name, :last_name, format: { with: ::Validator::NAME_REGEX }, presence: true
  validates :email, length: { maximum: 100 }, format: { with: ::Validator::EMAIL_REGEX }, presence: true
  validates :email, uniqueness: { case_sensitive: true }
  validates :phone, format: { with: ::Validator::PHONE_REGEX }

  before_create :set_api_token

  def set_api_token
    self.api_token = SecureRandom.uuid
  end
end
