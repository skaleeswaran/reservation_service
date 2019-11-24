# frozen_string_literal: true

FactoryBot.define do
  factory :reservation, class: 'Reservation' do
    start_time { Time.now + 1.hour }
    covers { 5 }
    notes { 'Sample' }
  end
end
