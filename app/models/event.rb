class Event < ActiveRecord::Base
  belongs_to :subject
  has_one :period, through: :subject
  attr_accessor :weekday
  validates_presence_of :start_date, :every, :end_date, :start_time, :end_time, :title, :subject_id
  validates_date :end_date, after: :start_date
  validates_time :end_time, after: :start_time
  validates_inclusion_of :every, in: ["week", "month", "day"]

  def dates(options={})
    options = {:every => every, :starts => start_date, :until => end_date}.merge(options)
    options[:on] = case options[:every]
    when 'year'
      [options[:starts].month, options[:starts].day]
    when 'week'
      options[:starts].strftime('%A').downcase.to_sym
    when 'day', 'month'
      options[:starts].day
    end
    Recurrence.new(options).events
  end

  def fullcalendar_conversion
    dates = []
    self.dates.each do |date|
      dates << {id: self.id, title: self.title, start: Event.format_datetime(date, self.start_time), end: Event.format_datetime(date, self.end_time)}
    end

    return dates
  end

  def formatted_start_time
    self.start_time.strftime("%H:%M")
  end

  def formatted_end_time
    self.end_time.strftime("%H:%M")
  end

  private
  def self.format_datetime(date, time)
    return DateTime.new(date.year, date.month, date.day, time.hour, time.min, time.sec, time.zone)
  end

end
