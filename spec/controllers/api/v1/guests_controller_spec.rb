require 'rails_helper'

RSpec.describe Api::V1::GuestsController do
  describe '#index' do
    let(:guest) { create(:guest) }
    let(:admin) { create(:admin) }
    let(:do_request) { get(:index) }

    before do
      admin
      guest
      auth_login(admin.api_token)
    end

    it 'responds with success' do
      do_request
      expect(response).to be_successful
    end
  end

  describe '#index' do
    let(:guest) { create(:guest) }
    let(:do_request) { get(:index) }

    before do
      guest
      auth_login(guest.api_token)
    end

    it 'denies access by guest user' do
      do_request
      expect(response.status).to eql(403)
    end
  end

  describe '#create' do
    let(:admin) { create(:admin) }
    let(:do_request) { post(:create, params: {email: 'sample12@sample.com', first_name: 'sample', last_name: 'sample', phone: '87354'}) }

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
    let(:do_request) { post(:create, params: {email: 'sample12@sample.com', first_name: 'sample123', last_name: 'sample', phone: '87354'}) }

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
    let(:guest) { create(:guest) }
    
    before do
      admin
      guest
      auth_login(admin.api_token)
    end

    it 'responds with success' do
      put(:update, params: {id: guest.id, email: 'sample124@sample.com', first_name: 'sample', last_name: 'sample', phone: '87354'})
      expect(response).to be_successful
      expect(json_response_body['email']).to eql('sample124@sample.com')
    end
  end

  describe '#show' do
    let(:admin) { create(:admin) }
    let(:guest) { create(:guest) }

    before do
      admin
      guest
      auth_login(admin.api_token)
    end

    it 'responds with failure' do
      get(:show, params: {id: guest.id})
      expect(response.status).to eql(200)
      expect(json_response_body['email']).to eql(guest.email)
    end
  end

  describe '#destroy' do
    let(:admin) { create(:admin) }
    let(:guest) { create(:guest) }

    before do
      admin
      guest
      auth_login(admin.api_token)
    end

    it 'responds with failure' do
      delete(:destroy, params: {id: guest.id})
      expect(response.status).to eql(204)
    end
  end
end