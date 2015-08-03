require 'rails_helper'

describe Test do
  it { is_expected.to validate_presence_of :date }
  it { is_expected.to validate_numericality_of :value }
  it { is_expected.to validate_numericality_of :grade }
  it { is_expected.to validate_numericality_of :subject_id }
  it { is_expected.to belong_to :subject }

  it 'is valid when built by FactoryGirl' do
    test = build(:test)
    expect(test).to be_valid
  end

  it 'is invalid if grade is higher than value' do
    #test = Test.new(date: '01-01-2015', grade: 10, value: 5)
    test = build(:test, value: 8, grade: 10)
    expect(test).to be_invalid
  end
end
