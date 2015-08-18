require 'rails_helper'

describe Test do
  it { is_expected.to validate_presence_of :date }
  it { is_expected.to validate_numericality_of :value }
  it { is_expected.to validate_numericality_of :grade }
  it { is_expected.to validate_numericality_of :subject_id }
  it { is_expected.to belong_to :subject }

  it 'is invalid if grade is higher than value' do
    test = build(:test, value: 8, grade: 10)
    expect(test).to be_invalid
  end
end
