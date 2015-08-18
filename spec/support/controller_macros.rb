module ControllerMacros
  # Creates a user using Devise and use it to login before running any tests
  def login_user
    before(:each) do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      user = create(:user)
      user.confirm
      sign_in user

      expect(subject.current_user).not_to be_nil
    end
  end
end
