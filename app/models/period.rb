#encoding: utf-8
class Period < ActiveRecord::Base  
  belongs_to :user
  has_many :subjects
  has_many :events, through: :subjects
  after_initialize :init_values
  validates_presence_of :start_date, :end_date, :number
  validates_numericality_of :number
  validates_date :end_date, after: :start_date

  def init_values
    self.mean ||= 0
  end

  def self.get_calendar_hours(period)
    first_and_last_hour = []
    hours = []

    if period
      period.subjects.each do |subject|
        subject.events.each do |event|
          hours << event.formatted_start_time
          hours << event.formatted_end_time
        end
      end
    end
    
    if hours != []
      hours.sort!
      first_and_last_hour << hours.first << hours.last
      #max_first_hour = "14:00"
      #if hours.first < max_first_hour
      #  min_last_hour = "#{hours.first.to_i + 10}:00"
      #else
      #  min_last_hour = "24:00"
      #end
      #first_and_last_hour[0] = max_first_hour if hours.first > max_first_hour
      #first_and_last_hour[1] = min_last_hour if hours.last < min_last_hour
    else
      first_and_last_hour << "06:00" << "24:00"
    end

    return first_and_last_hour
  end

  def self.get_events(period)
    jsons = []
    events = []
    period.events.each do |event|
      event.fullcalendar_dates.each do |date|
        events << date
      end
      #event.dates.each do |date|
      #  fullcalendar_start = DateTime.new(date.year, date.month, date.day, event.start_time.hour, event.start_time.min, event.start_time.sec, event.start_time.zone)
      #  fullcalendar_end = DateTime.new(date.year, date.month, date.day, event.end_time.hour, event.end_time.min, event.end_time.sec, event.end_time.zone)
      #  events << {id: event.id, title: event.title, start: fullcalendar_start.iso8601,  end: fullcalendar_end.iso8601}
      #end
    end
  
    return events
  end

  def self.check_current_period(period)
    if ((Date.today >= period.start_date) && (Date.today <= period.end_date))
      period.is_current = true
    else
      period.is_current = false
    end

    return period
  end

  def self.get_periods_and_means(periods)
    periods.each do |period|
      unless period.subjects.size == 0
        period.subjects.each do |subject|
          unless subject.value == 0
            period.mean += (subject.grade * 100) / subject.value
          else
            period.mean += 100
          end
        end
        period.mean = period.mean / period.subjects.size
      else
        period.mean = 100
      end
    end
  end
end
