class Subject < ActiveRecord::Base
  belongs_to :period
  has_many :tests
  has_many :projects
  has_many :events
  after_initialize :init_values
  validates_presence_of :name, :period_id
  validates_length_of :name, maximum: 15
  accepts_nested_attributes_for :tests, :reject_if => lambda { |a| a[:content].blank? }

  def init_values
    self.value ||= 0
    self.grade ||= 0
  end

  def self.get_period_and_subjects(period)
    dados = {"period" => [], "period_number" => [], "subjects" => []}

    dados["period"] = period
    dados["period_number"] = period.number

    period.subjects.each do |subject|
      dados["subjects"] << subject
    end

    return dados
  end

def self.get_tests_and_projects(subject)
  dados = {"tests" => [], "projects" => [], "events" => []}
  
  subject.tests.each do |test|
  
    if test.is_project
      dados["projects"] << test
    else
      dados["tests"] << test
    end
  end
  
  events = Event.where("subject_id = #{subject.id}")
  
  events.each do |event|
    dados["events"] << event
  end
  
  return dados
  end
end
