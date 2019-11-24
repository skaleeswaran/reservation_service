# frozen_string_literal: true

FactoryBot.define do
  factory :guest, class: 'Guest' do
    first_name { 'sample' }
    last_name { 'sample' }
    phone { '9999' }
    api_token { '1234' }
    sequence(:email) { |i| "sample@sample#{i}.com" }
  end
end
