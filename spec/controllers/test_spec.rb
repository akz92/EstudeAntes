require 'rails_helper.rb'

describe TestsController do
  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    user = create(:user)
    user.confirm
    sign_in user
  end

  it 'has a current_user' do
    expect(subject.current_user).not_to be_nil
  end

  describe '#create' do
    before(:each) do
      @period = create(:period, id: 1)
      @subject = create(:subject, id: 1, period_id: @period.id)
      post :create, test: attributes_for(:test), period_id: @period.id, subject_id: @subject.id
    end
    
    context 'success' do
      it { expect(Test.count).to eq(1) }
      it { expect(response).to redirect_to(period_subject_path(@period, @subject)) }
      it { expect(flash[:success]).to be_present }
    end

    # context 'error' do
    #   it 'flashes error message' do
    #     # creating a test without date to raise validation error
    #     post :create, test: attributes_for(:test, date: nil), period_id: @period.id, subject_id: @subject.id
    #     expect(flash[:error]).to be_present
    #   end
    # end
  end

  describe '#update' do
    let(:attr) do
      { value: 12 }
    end

    # let(:error_attr) do
    #   { name: 'name_grater_than_15_chars' }
    # end

    before(:each) do
      @period = create(:period)
      @subject = create(:subject, period_id: @period.id)
      @test = create(:test, subject_id: @subject.id)
      put :update, id: @test.id, test: attr, period_id: @period.id, subject_id: @subject.id
      @test.reload
    end

    context 'success' do
      it { expect(response).to redirect_to(period_subject_path(@period, @subject)) }
      it { expect(@test.value).to eql attr[:value] }
      it { expect(flash[:success]).to be_present }
    end

    # context 'error' do
    #   it 'flashes error message' do
    #     # updating a subject with name greater than 15 chars to raise validation error
    #     put :update, id: @subject.id, subject: error_attr, period_id: @period.id
    #     @subject.reload
    #     expect(flash[:error]).to be_present
    #   end
    # end
  end

  describe '#destroy' do
    before(:each) do
      @period = create(:period)
      @subject = create(:subject, period_id: @period.id)
      @test = create(:test, subject_id: @subject.id)
    end

    it 'destroys the period' do
      expect {
        delete :destroy, id: @test.id, subject_id: @subject.id, period_id: @period.id
      }.to change(Test, :count).by(-1)
    end

    it 'flashes success message' do
      delete :destroy, id: @test.id, subject_id: @subject.id, period_id: @period.id
      expect(flash[:success]).to be_present
    end
  end
end
