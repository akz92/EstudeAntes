require 'rails_helper.rb'

describe SubjectsController do
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
      post :create, subject: attributes_for(:subject, period_id: 1)
    end
    
    context 'success' do
      # it { expect(Subject.count).to eq(1) }
      # it { expect(response).to redirect_to(root_path) }
      # it { expect(flash[:success]).to be_present }
    end
  end
end
