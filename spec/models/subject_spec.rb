require 'rails_helper.rb'

describe Subject do
  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of :period_id }
  it { is_expected.to validate_length_of(:name).is_at_most(15) }
  it { is_expected.to belong_to :period }
  it { is_expected.to have_many :tests }
  it { is_expected.to have_many :events }
end
