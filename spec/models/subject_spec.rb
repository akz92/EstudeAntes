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

  describe '.update_value_and_grade' do
    before(:each) do
      @subject = create(:subject)
      @test = create(:test, value: 10, grade: 8, subject_id: @subject.id)
      expect(@subject.value).to eq(0)
      expect(@subject.grade).to eq(0)
      @subject.update_value_and_grade('create', @test)
    end

    it 'sums new test value and grade' do
      expect(@subject.value).to eq(10)
      expect(@subject.grade).to eq(8)
    end

    it 'substracts destroyed test value and grade' do
      @subject.update_value_and_grade('destroy', @test)
      expect(@subject.value).to eq(0)
      expect(@subject.grade).to eq(0)
    end

    it 'updates from all tests' do
      another_test = create(:test, value: 10, grade: 8, subject_id: @subject.id)
      @subject.update_value_and_grade('update', another_test)
      expect(@subject.value).to eq(20)
      expect(@subject.grade).to eq(16)
    end
  end
end
