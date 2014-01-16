class Subject < ActiveRecord::Base
  belongs_to :period
  has_many :tests
  has_many :projects

  def init
    self.value ||= 0
    self.grade ||= 0
  end

end
