#encoding: utf-8
class Period < ActiveRecord::Base  
  belongs_to :user
  has_many :subjects
  has_many :events, through: :subjects
  after_initialize :init_values
  validates_presence_of :start_date, :end_date, :number, :user_id
  validates_numericality_of :number
  validates_date :end_date, after: :start_date
  validates_uniqueness_of :number
  validates_uniqueness_of :is_current, if: :true?

  def get_calendar_hours
    hours = []

    self.events.each do |event|
      hours << event.formatted_start_time << event.formatted_end_time
    end

    hours.sort!
    hours = ["06:00", "24:00"] if hours == []
    hours = [hours.first, hours.last]

    hours
  end

  def get_events
    events = []

    self.events.each do |event|
      event.fullcalendar_dates.each do |date|
        events << date
      end
    end
    events
  end

  def is_current?
    if Date.today.between?(self.start_date, self.end_date)
      self.is_current = true
    end
    self
  end

  private

  def init_values
    self.mean ||= 0
    self.is_current ||= false
  end

  def true?
    self.is_current == true 
  end
end
