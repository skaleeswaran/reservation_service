# frozen_string_literal: true

class Reservation < ApplicationRecord
  include AASM

  belongs_to :guest
  belongs_to :restaurant

  validates :start_time, presence: true
  validates :covers, presence: true

  validates_datetime :start_time, after: Time.now

  aasm column: :status do
    state :booked, initial: true
    state :active
    state :deleted

    event :to_active do
      transitions from: %i[booked], to: :active
    end

    event :to_deleted do
      transitions from: %i[booked active], to: :deleted
    end
  end
end
