require 'rails_helper.rb'

describe User::OmniauthCallbacksController do
  include Devise::TestHelpers
  before do
    request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:facebook]
    request.env['devise.mapping'] = Devise.mappings[:user]
  end

  describe '#facebook' do

    it 'successfully creates a user' do
      expect {
        post :facebook, provider: :facebook
      }.to change { User.count }.by(1)
    end

    it 'redirects the user to the root url' do
      post :facebook, provider: :facebook
      expect(response).to redirect_to root_url
    end

    it 'signs the user in' do
      post :facebook, provider: :facebook
      expect(warden.authenticated?(:user)).to be true
    end
  end

end
