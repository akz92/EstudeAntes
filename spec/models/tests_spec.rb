require 'rails_helper'

describe Test do
  it "is invalid without date" do
    test = Test.new
    expect(test).to be_invalid
  end
  it "is invalid if value is not a number" do
    test = Test.new(date: "01-01-2015", value: "b")
    expect(test).to be_invalid
  end
  it "is invalid if grade is not a number" do
    test = Test.new(date: "01-01-2015", value: 1, grade: "b")
    expect(test).to be_invalid
  end
  it "is invalid if grade is higher than value" do
    test = Test.new(date: "01-01-2015", grade: 10, value: 5)
    expect(test).to be_invalid
  end
end
