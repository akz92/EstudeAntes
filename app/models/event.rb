class Event < ActiveRecord::Base
  belongs_to :subject
  has_one :period, through: :subject
  attr_accessor :weekday
  validates_presence_of :start_date, :every, :end_date

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

  def self.format_datetime(date, time)
    return DateTime.new(date.year, date.month, date.day, time.hour, time.min, time.sec, time.zone)
  end

  def self.fullcalendar_conversion(event)
    dates = []
    event.dates.each do |date|
      fullcalendar_start = Event.format_datetime(date, event.start_time)
      fullcalendar_end = Event.format_datetime(date, event.end_time)
      dates << {id: event.id, title: event.title, start: fullcalendar_start.iso8601,  end: fullcalendar_end.iso8601}
    end

    return dates
  end

  def formatted_start_time
    self.start_time.strftime("%H:%M")
  end

  def formatted_end_time
    self.end_time.strftime("%H:%M")
  end

  def self.period_number(period)
    dados_periodo = {"period_number" => []}
    dados_periodo["period_number"] = period.number

    return dados_periodo
  end
end
