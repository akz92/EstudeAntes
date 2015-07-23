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

  def self.fullcalendar_conversion(event)
    dates = []
    event.dates.each do |date|
      fullcalendar_start = DateTime.new(date.year, date.month, date.day, event.start_time.hour, event.start_time.min, event.start_time.sec, event.start_time.zone)
      fullcalendar_end = DateTime.new(date.year, date.month, date.day, event.end_time.hour, event.end_time.min, event.end_time.sec, event.end_time.zone)
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
