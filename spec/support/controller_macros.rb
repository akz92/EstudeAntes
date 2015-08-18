module ControllerMacros
  # Creates a user using Devise and use it to login before running any tests
  def login_user
    before(:each) do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      user = create(:user)
      user.confirm
      sign_in user
    end
  end
end
