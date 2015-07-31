require 'rails_helper'

describe Event do
  it { is_expected.to validate_presence_of :subject_id }
  it { is_expected.to validate_presence_of :start_date }
  it { is_expected.to validate_presence_of :end_date }
  it { is_expected.to validate_presence_of :start_time }
  it { is_expected.to validate_presence_of :end_time }
  it { is_expected.to validate_presence_of :title }
  it { is_expected.to validate_presence_of :every }
  it { is_expected.to validate_inclusion_of(:every).in_array(["month", "week", "day"]) }
  it { is_expected.to belong_to :subject }
  it { is_expected.to have_one(:period).through(:subject) }

  it "is invalid if start_date after end_date" do
    event= Event.new(start_date: "05-01-2015", end_date: "01-01-2015", start_time: "02:00:00", end_time: "03:00:00", title: "titulo", every: "week")
    expect(event).to be_invalid
  end
  it "is invalid if start_time after end_time" do
    event= Event.new(start_date: "01-01-2015", end_date: "05-01-2015", start_time: "04:00:00", end_time: "03:00:00", title: "titulo", every: "week")
    expect(event).to be_invalid
  end
end
