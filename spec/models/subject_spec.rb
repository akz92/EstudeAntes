require 'rails_helper.rb'

describe Subject do
  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of :period_id }
  it { is_expected.to validate_length_of(:name).is_at_most(15) }
  it { is_expected.to belong_to :period }
  it { is_expected.to have_many :tests }
  it { is_expected.to have_many :events }

  it 'gets tests only' do
    subject = create(:subject, id: 1)
    test = create(:test, subject_id: 1)
    create(:test, subject_id: 1, is_project: true)
    expect(subject.tests_only).to eq([test])
  end

  it 'gets projects only' do
    subject = create(:subject, id: 1)
    create(:test, subject_id: 1)
    project = create(:test, subject_id: 1, is_project: true)
    expect(subject.projects).to eq([project])
  end
end
