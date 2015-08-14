require 'rails_helper.rb'

describe PeriodsController do
  before (:each) do
    @user = User.create!({
      :name => 'Test User',
      :email => 'user@test.com',
      :password => '12345678',
      :password_confirmation => '12345678'
    })
    sign_in @user
  end

  describe '#destroy' do
    before do
      # post :create, period: attributes_for(:period)
      @period = create(:period)
    end
    it 'destroys the period' do
      # expect {
      #   delete :destroy, id: @period
      # }.to change(Period, :count).by(-1)
    end
  end
end
