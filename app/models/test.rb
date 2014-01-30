class Test < ActiveRecord::Base
  belongs_to :subject
  validates_numericality_of :grade, :less_than_or_equal_to => :value, :message => 'can\'t be greater than the test value'
  after_initialize :init_values

  def init_values
       self.value ||= 0
       self.grade ||= 0
  end
end
