require 'rails_helper.rb'

describe Subject do
  it "is invalid without name" do
    subject = Subject.new
    expect(subject).to be_invalid
  end
  it "is invalid without period_id" do
    subject = Subject.new(name: "Math")
    expect(subject).to be_invalid
  end
  it "is invalid if name is greater than 15 caracters" do
    subject = Subject.new(name: "matematica aplic")
    expect(subject).to be_invalid
  end
end
