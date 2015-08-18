require 'rails_helper.rb'

describe PeriodsController do
  login_user

  it 'has a current_user' do
    expect(subject.current_user).not_to be_nil
  end

  describe '#create' do
    before(:each) do
      post :create, period: attributes_for(:period)
    end

    context 'success' do
      it { expect(Period.count).to eq(1) }
      it { expect(response).to redirect_to(root_path) }
      it { expect(flash[:success]).to be_present }
    end

    context 'error' do
      it 'flashes error message' do
        # creating another period with same ID to get an error
        post :create, period: attributes_for(:period)
        expect(flash[:error]).to be_present
      end
    end

    context 'older period' do
      before do
        post :create, period: attributes_for(:period, start_date: '01-01-2015', end_date: '05-05-2015')
      end

      it 'redirects to period_subjects_path if older period' do
        expect(response).to redirect_to(periods_all_path)
      end
    end

  end

  describe '#update' do
    let(:attr) do
      { number: 2 }
    end

    # let(:older_attr) do
    #   { start_date: '01-01-2015', end_date: '05-05-2015', is_current: false }
    # end

    before(:each) do
      @period = create(:period)
      put :update, id: @period.id, period: attr
      @period.reload
    end

    it { expect(response).to redirect_to(root_path) }
    it { expect(@period.number).to eql attr[:number] }
    it { expect(flash[:success]).to be_present }

    # it 'redirects to period_subjects_path if older period' do
    #   put :update, id: @period.id, period: older_attr
    #   @period.reload
    #   expect(response).to redirect_to(period_subjects_path(@period))
    # end
  end

  describe '#destroy' do
    before(:each) do
      @period = create(:period)
    end

    it 'destroys the period' do
      expect {
        delete :destroy, id: @period.id
      }.to change(Period, :count).by(-1)
    end

    it 'flashes success message' do
      delete :destroy, id: @period.id
      expect(flash[:success]).to be_present
    end
  end
end
