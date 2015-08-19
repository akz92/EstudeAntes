require 'rails_helper.rb'

describe User do
  it 'has remember_me to true by default' do
    user = build(:user)
    expect(user.remember_me).to eq('1')
  end

  it 'if facebook email already registered dont create new' do
    expect {
      user = create(:user, email: 'user@example.com')
      user.skip_confirmation!
      user.save!
      facebook_user = User.from_omniauth(OmniAuth.config.mock_auth[:facebook])
      facebook_user.save!
    }.to change { User.count }.by(1)
  end

  it 'updates a user with his facebook credentials' do
    user = create(:user, email: 'user@example.com')
    user.skip_confirmation!
    user.save!
    facebook_user = User.from_omniauth(OmniAuth.config.mock_auth[:facebook])
    facebook_user.save!
    expect(user).to eql(facebook_user)
  end

  it 'creates a user from facebook' do
    expect {
      facebook_user = User.from_omniauth(OmniAuth.config.mock_auth[:facebook])
      facebook_user.save
    }.to change { User.count }.by(1)

  end
end
