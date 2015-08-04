class Subject < ActiveRecord::Base
  belongs_to :period
  has_many :tests
  has_many :events
  after_initialize :init_values
  validates_presence_of :name, :period_id
  validates_length_of :name, maximum: 15

	#def tests
  #  self.tests.where(is_project: false)
  #end

  def projects
    self.tests.where(is_project: true)
  end

  private
  def init_values
    self.value ||= 0
    self.grade ||= 0
  end
end
