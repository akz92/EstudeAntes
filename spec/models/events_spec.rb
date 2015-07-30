require 'rails_helper'

describe Event do
  it "is invalid without subject_id" do
    event= Event.new(start_date: "01-01-2015", end_date: "05-01-2015", start_time: "01:00:00", end_time: "02:00:00", every: "week", title: "titulo")
    expect(event).to be_invalid
  end
  it "is invalid without a start date" do
    event= Event.new(end_date: "01-01-2015", start_time: "01:00:00", end_time: "02:00:00", every: "week", title: "titulo")
    expect(event).to be_invalid
  end
  it "is invalid without an end date" do
    event= Event.new(start_date: "01-01-2015", start_time: "01:00:00", end_time: "02:00:00", every: "week", title: "titulo")
    expect(event).to be_invalid
  end
  it "is invalid without a start time" do
    event= Event.new(start_date: "01-01-2015", end_date: "05-01-2015", end_time: "02:00:00", every: "week", title: "titulo")
    expect(event).to be_invalid
  end
  it "is invalid without an end time" do
    event= Event.new(start_date: "01-01-2015", end_date: "05-01-2015", start_time: "02:00:00", every: "week", title: "titulo")
    expect(event).to be_invalid
  end
  it "is invalid without a title" do
    event= Event.new(start_date: "01-01-2015", end_date: "05-01-2015", start_time: "02:00:00", end_time: "03:00:00", every: "week")
    expect(event).to be_invalid
  end
  it "is invalid without every" do
    event= Event.new(start_date: "01-01-2015", end_date: "05-01-2015", start_time: "02:00:00", end_time: "03:00:00", title: "titulo")
    expect(event).to be_invalid
  end
  it "is invalid if start_date after end_date" do
    event= Event.new(start_date: "05-01-2015", end_date: "01-01-2015", start_time: "02:00:00", end_time: "03:00:00", title: "titulo", every: "week")
    expect(event).to be_invalid
  end
  it "is invalid if start_time after end_time" do
    event= Event.new(start_date: "01-01-2015", end_date: "05-01-2015", start_time: "04:00:00", end_time: "03:00:00", title: "titulo", every: "week")
    expect(event).to be_invalid
  end
  it "is invalid if every not in allowed_every_values" do
    event= Event.new(start_date: "01-01-2015", end_date: "05-01-2015", start_time: "01:00:00", end_time: "03:00:00", title: "titulo", every: "foo")
    expect(event).to be_invalid
  end
end
