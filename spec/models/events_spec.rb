require 'rails_helper'

describe Event do
  it "has a valid factory" do
    Factory.create(:event).should be_valid
  end
  it "is invalid without a start date"
  it "is invalid without an end date"
  it "is invalid without a start time"
  it "is invalid without an end time"
  it "is invalid without a title"
end
