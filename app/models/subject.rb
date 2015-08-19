class Subject < ActiveRecord::Base
  belongs_to :period
  has_many :tests
  has_many :events
  after_initialize :init_values
  validates_presence_of :name, :period_id
  validates_length_of :name, maximum: 15

  def tests_only
   self.tests.where(is_project: false)
  end

  def projects
    self.tests.where(is_project: true)
  end

  def update_value_and_grade(method, test)
    case method
    when 'update'
      self.value = 0
      self.grade = 0

      self.tests.each do |test|
        self.value += test.value
        self.grade += test.grade
      end
    when 'destroy'
      self.value -= test.value
      self.grade -= test.grade
    else
      self.value += test.value
      self.grade += test.grade
    end
    self.save!
  end

  private
  def init_values
    self.value ||= 0
    self.grade ||= 0
  end
end
