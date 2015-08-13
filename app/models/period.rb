# encoding: utf-8
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

  # Fetches the minimal start time and the maximum end time from all events from the Period
  #
  # @return [Array] a 2 element array containing the first and last hour to use as minTime and maxTime in FullCalendar
  def calendar_hours
    hours = ['06:00', '22:00']
    unless self.events.empty?
      hours = [self.events.min_by(&:start_time).start_time.strftime('%H:%M')]
      hours << self.events.max_by(&:end_time).end_time.strftime('%H:%M')
    end
    hours
  end

  # def chart_hash
  #   Hash[*self.subjects.all.map { |subject| [subject.name, (subject.grade / subject.value) * 100] }.flatten]
  # end

  # Converts an array of events JSONs into one single events JSON
  #
  # @return [Json] one single events JSON
  def get_events
    dates = []

    self.events.each do |event|
      event.fullcalendar_dates.each do |date|
        dates << date
      end
    end
    dates
  end

  # Defines the Period as current based on its start and end dates
  #
  # @return [Period] itself as current if it's current
  def is_current?
    if Date.today.between?(self.start_date, self.end_date)
      self.is_current = true
    end
    self
  end

  private
  def init_values
    self.is_current ||= false
  end

  # Checks if a given Period is current
  #
  # @return [Boolean] true if the Period is current
  def true?
    self.is_current == true
  end
end
