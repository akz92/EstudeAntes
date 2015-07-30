require 'rails_helper.rb'

describe Subject do
  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of :period_id }
  it { is_expected.to validate_length_of(:name).is_at_most(15) }
end
