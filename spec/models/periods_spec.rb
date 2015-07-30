require 'rails_helper.rb'

describe Period do
  it { is_expected.to validate_uniqueness_of :number }
  it { is_expected.to validate_presence_of :user_id }
  it { is_expected.to validate_presence_of :start_date }
  it { is_expected.to validate_presence_of :end_date }
  it { is_expected.to validate_presence_of :number }
  it { is_expected.to validate_numericality_of :number }

  it "has an end_date after start_date" do
    period = Period.new(start_date: "05-05-2015", end_date: "01-01-2015", number: 1)
    expect(period).to be_invalid
  end
end
