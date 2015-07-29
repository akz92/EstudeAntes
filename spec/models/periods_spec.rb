require 'rails_helper.rb'

describe Period do
  it "is invalid without start_date" do
    period = Period.new(end_date: "05-05-2015", number: 1)
    expect(period).to be_invalid
  end
  it "is invalid without end_date" do
    period = Period.new(start_date: "01-01-2015", number: 1)
    expect(period).to be_invalid
  end
  it "is invalid without number" do
    period = Period.new(start_date: "01-01-2015", end_date: "05-05-2015")
    expect(period).to be_invalid
  end
  it "is invalid if number is not a number" do
    period = Period.new(start_date: "01-01-2015", end_date: "05-05-2015", number: "a")
    expect(period).to be_invalid
  end
  it "is invalid if end_date after start_date" do
    period = Period.new(start_date: "05-05-2015", end_date: "01-01-2015", number: 1)
    expect(period).to be_invalid
  end
end
