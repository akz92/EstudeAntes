class Subject < ActiveRecord::Base
  belongs_to :period
  has_many :tests
  has_many :projects
end
