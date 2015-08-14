require 'rails_helper.rb'

describe User::OmniauthCallbacksController do
  include Devise::TestHelpers
  before do
    request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:facebook]
    request.env["devise.mapping"] = Devise.mappings[:user]
  end

  describe "#facebook" do

    it "should successfully create a user" do
      expect {
        post :facebook, provider: :facebook
      }.to change{ User.count }.by(1)
    end

    it "should successfully create a session" do
      expect(session[:user_id]).to be_nil
      post :facebook, provider: :facebook
      expect(session[:user_id]).not_to be_nil
    end

    it "should redirect the user to the root url" do
      post :facebook, provider: :facebook
      expect(response).to redirect_to root_url
    end

  end

end
