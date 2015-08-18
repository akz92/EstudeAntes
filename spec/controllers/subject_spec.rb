require 'rails_helper.rb'

describe SubjectsController do
  login_user

  describe '#create' do
    before(:each) do
      @period = create(:period, id: 1)
      post :create, subject: attributes_for(:subject), period_id: 1
    end

    context 'success' do
      it { expect(Subject.count).to eq(1) }
      it { expect(response).to redirect_to(root_path) }
      it { expect(flash[:success]).to be_present }
    end

    context 'error' do
      it 'flashes error message' do
        # creating a subject with name greater than 15 chars to raise validation error
        post :create, subject: attributes_for(:subject, name: 'name_greater_than_15_chars'), period_id: 1
        expect(flash[:error]).to be_present
      end
    end
  end

  describe '#update' do
    let(:attr) do
      { name: 'Science' }
    end

    let(:error_attr) do
      { name: 'name_grater_than_15_chars' }
    end

    before(:each) do
      @period = create(:period)
      @subject = create(:subject, period_id: @period.id)
      put :update, id: @subject.id, subject: attr, period_id: @period.id
      @subject.reload
    end

    context 'success' do
      it { expect(response).to redirect_to(period_subject_path(@period, @subject)) }
      it { expect(@subject.name).to eql attr[:name] }
      it { expect(flash[:success]).to be_present }
    end

    context 'error' do
      it 'flashes error message' do
        # updating a subject with name greater than 15 chars to raise validation error
        put :update, id: @subject.id, subject: error_attr, period_id: @period.id
        @subject.reload
        expect(flash[:error]).to be_present
      end
    end
  end

  describe '#destroy' do
    before(:each) do
      @period = create(:period)
      @subject = create(:subject, period_id: @period.id)
    end

    it 'destroys the period' do
      expect {
        delete :destroy, id: @subject.id, period_id: @period.id
      }.to change(Subject, :count).by(-1)
    end

    it 'flashes success message' do
      delete :destroy, id: @subject.id, period_id: @period.id
      expect(flash[:success]).to be_present
    end
  end
end
