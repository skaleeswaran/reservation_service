# frozen_string_literal: true

FactoryBot.define do
  factory :restaurant, class: 'Restaurant' do
    name { 'sample' }
    phone { '9999' }
    sequence(:email) { |i| "sample@sample#{i}.com" }
    location { 'dubai'}
    opening_hours { '9.00AM'}
    cuisines { ['ASIAN']}
  end
end
