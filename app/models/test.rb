class Test < ActiveRecord::Base
  belongs_to :subject
  validates_presence_of :date, :value, :grade, :subject_id
  validates_numericality_of :value, :grade, :subject_id
  validates_numericality_of :grade, less_than_or_equal_to: :value
  after_initialize :init_values

  private
  def init_values
    self.value ||= 0
    self.grade ||= 0
    self.is_project ||= false
  end
end
