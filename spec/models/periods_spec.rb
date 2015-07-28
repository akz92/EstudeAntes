require 'rails_helper.rb'

describe Period do
  it "is invalid without init_date" do
    period = Period.new(final_date: "05-05-2015", number: 1)
    expect(period).to be_invalid
  end
  it "is invalid without final_date" do
    period = Period.new(init_date: "01-01-2015", number: 1)
    expect(period).to be_invalid
  end
  it "is invalid without number" do
    period = Period.new(init_date: "01-01-2015", final_date: "05-05-2015")
    expect(period).to be_invalid
  end
  it "is invalid if number is not a number" do
    period = Period.new(init_date: "01-01-2015", final_date: "05-05-2015", number: "a")
    expect(period).to be_invalid
  end
  it "is invalid if final_date after init_date" do
    period = Period.new(init_date: "05-05-2015", final_date: "01-01-2015", number: 1)
    expect(period).to be_invalid
  end
end
