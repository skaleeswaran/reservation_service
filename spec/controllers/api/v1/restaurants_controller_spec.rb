require 'rails_helper'

RSpec.describe Api::V1::RestaurantsController do
  describe '#index' do
    let(:restaurant) { create(:restaurant) }
    let(:admin) { create(:admin) }
    let(:do_request) { get(:index) }

    before do
      admin
      restaurant
      auth_login(admin.api_token)
    end

    it 'responds with success' do
      do_request
      expect(response).to be_successful
    end
  end

  describe '#create' do
    let(:admin) { create(:admin) }
    let(:do_request) { post(:create, params: {email: 'sample12@sample.com', name: 'sample', phone: '87354', location: 'dubai', opening_hours: '9.00AM', cuisines: ['Asian']}) }

    before do
      admin
      auth_login(admin.api_token)
    end

    it 'responds with success' do
      do_request
      expect(response).to be_successful
      expect(json_response_body['email']).to eql('sample12@sample.com')
    end
  end

  describe '#create_with_invalid' do
    let(:admin) { create(:admin) }
    let(:do_request) { post(:create, params: {email: 'sample12@sample.com', name: 'sample', phone: '87354', location: 'dubai', opening_hours: 'AM', cuisines: ['Asian']}) }

    before do
      admin
      auth_login(admin.api_token)
    end

    it 'responds with failure' do
      do_request
      expect(response.status).to eql(400)
    end
  end
  
  describe '#update' do
    let(:admin) { create(:admin) }
    let(:restaurant) { create(:restaurant) }
    
    before do
      admin
      restaurant
      auth_login(admin.api_token)
    end

    it 'responds with success' do
      put(:update, params: {id: restaurant.id, email: 'sample124@sample.com', name: 'sample', phone: '87354', location: 'dubai', opening_hours: '9.00AM', cuisines: ['Asian']})
      expect(response).to be_successful
      expect(json_response_body['email']).to eql('sample124@sample.com')
    end
  end

  describe '#show' do
    let(:admin) { create(:admin) }
    let(:restaurant) { create(:restaurant) }

    before do
      admin
      restaurant
      auth_login(admin.api_token)
    end

    it 'responds with failure' do
      get(:show, params: {id: restaurant.id})
      expect(response.status).to eql(200)
      expect(json_response_body['email']).to eql(restaurant.email)
    end
  end

  describe '#destroy' do
    let(:admin) { create(:admin) }
    let(:restaurant) { create(:restaurant) }

    before do
      admin
      restaurant
      auth_login(admin.api_token)
    end

    it 'responds with failure' do
      delete(:destroy, params: {id: restaurant.id})
      expect(response.status).to eql(204)
    end
  end
end