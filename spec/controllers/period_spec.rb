require 'rails_helper.rb'

describe PeriodsController do
  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    user = create(:user)
    user.confirm # or set a confirmed_at inside the factory. Only necessary if you are using the "confirmable" module
    sign_in user
  end

  it 'has a current_user' do
    expect(subject.current_user).not_to be_nil
  end

  describe '#create' do
    
    it 'creates a period' do
      expect {
        # create(:period, user_id: subject.current_user.id)
        post :create, period: attributes_for(:period, user_id: subject.current_user.id)
      }.to change(subject.current_user.periods, :count).by(1)
    end

    it '' do

    end
  
  end

  # describe '#destroy' do
  #   before do
  #     # post :create, period: attributes_for(:period)
  #     @period = create(:period, user_id: @user.id)
  #   end
  #   it 'destroys the period' do
  #     expect {
  #       delete :destroy, id: @period.id
  #     }.to change(Period, :count).by(-1)
  #   end
  # end
end
