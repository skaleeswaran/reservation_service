# frozen_string_literal: true

class Admin < User
  has_many :reservations, foreign_key: :created_by
end
