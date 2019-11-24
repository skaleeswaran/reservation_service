require 'rails_helper'

RSpec.describe Api::V1::ReservationsController do
  let(:admin) { create(:admin) }
  let(:restaurant_user) { create(:restaurant_user) }
  let(:restaurant) { create(:restaurant) }
  let(:guest) { create(:guest) }
  let(:reservation) { create(:reservation, guest_id: guest.id, restaurant_id: restaurant.id) }

  describe '#index' do
    
    let(:do_request) { get(:index) }

    before do
      admin
      guest
      restaurant
      auth_login(admin.api_token)
    end

    it 'responds with success' do
      do_request
      expect(response).to be_successful
    end
  end

  describe '#create by admin' do
    let(:admin) { create(:admin) }
    let(:do_request) { post(:create, params: {start_time: Time.now + 2.hours, covers: 5, notes: 'Sample', guest_id: guest.id, restaurant_id: restaurant.id}) }

    before do
      admin
      auth_login(admin.api_token)
    end

    it 'responds with success' do
      do_request
      expect(response).to be_successful
      expect(json_response_body['covers']).to eql(5)
    end
  end

  describe '#create by guest' do
    let(:guest) {create(:guest)}
    let(:do_request) { post(:create, params: {start_time: Time.now + 2.hours, covers: 5, notes: 'Sample', restaurant_id: restaurant.id}) }

    before do
      guest
      auth_login(guest.api_token)
    end

    it 'responds with success with same guest id' do
      do_request
      expect(response).to be_successful
      expect(json_response_body['guest_id']).to eql(guest.id)
    end
  end

  describe '#create by restaurant user' do
    let(:restaurant_user) { create(:restaurant_user, restaurant_id: restaurant.id) }
    let(:guest) { create(:guest) }

    before do
      guest
      restaurant_user
      auth_login(restaurant_user.api_token)
    end

    it 'responds with success' do
      post(:create, params: {start_time: Time.now + 2.hours, covers: 5, notes: 'Sample', guest_id: guest.id})
      expect(response).to be_successful
      expect(json_response_body['restaurant_id']).to eql(restaurant.id)
    end
  end

  describe '#create_with_invalid' do
    let(:restaurant_user) { create(:restaurant_user, restaurant_id: restaurant.id) }
    let(:do_request) { post(:create, params: {start_time: Time.now - 2.hours, covers: 5, notes: 'Sample', guest_id: guest.id}) }

    before do
      guest
      restaurant_user
      auth_login(restaurant_user.api_token)
    end

    it 'responds with success' do
      do_request
      expect(response.status).to eql(400)
    end
  end
end