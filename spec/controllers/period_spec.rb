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
    before(:each) do
      post :create, period: attributes_for(:period, user_id: subject.current_user.id)
    end
    
    context 'success' do
      it { expect(subject.current_user.periods.count).to eq(1) }
      it { expect(response).to redirect_to(root_path) }
      it { expect(flash[:success]).to be_present }
    end

    context 'error' do
      it 'flashes error message' do
        # creating another period with same ID to get an error
        post :create, period: attributes_for(:period, user_id: subject.current_user.id)
        expect(flash[:error]).to be_present
      end
    end
  
  end

  describe '#update' do
    let(:attr) do
      { number: 2 }
    end

    before(:each) do
      @period = create(:period, user_id: subject.current_user.id)
      put :update, id: @period.id, period: attr
      @period.reload
    end

    it { expect(response).to redirect_to(root_path) }
    it { expect(@period.number).to eql attr[:number] }
    it { expect(flash[:success]).to be_present }


    # it 'redirects to period subjects path if older period' do
    #   put :update, id: @period.id, period: { start_date: '01-01-2014', end_date: '01-02-2015' }
    #   @period.reload
    #   expect(@period.is_current).to be false
    #   # expect(response).to redirect_to(period_subjects_path(@period))
    # end
  end

  # describe '#destroy' do
  #   before do
  #     post :create, period: attributes_for(:period, user_id: subject.current_user.id)
  #   end

  #   it 'destroys the period' do
  #     expect {
  #       delete :destroy, id: 1
  #     }.to change(subject.current_user.periods, :count).by(-1)
  #   end

  #   # it 'flashes success message if destroyed' do
  #   #   delete :destroy, id: 1
  #   #   expect(flash[:success]).to be_present
  #   # end
  # end
end
