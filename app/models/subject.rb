class Subject < ActiveRecord::Base
  belongs_to :period
  has_many :tests
  has_many :projects
  has_many :events
  after_initialize :init_values

  def init_values
    self.value ||= 0
    self.grade ||= 0
  end

end
