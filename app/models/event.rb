class Event < ActiveRecord::Base
  belongs_to :subject
  has_one :period, through: :subject
  attr_accessor :weekday
  validates_presence_of :start_date, :every, :end_date, :start_time, :end_time, :title, :subject_id
  validates_date :end_date, after: :start_date
  validates_time :end_time, after: :start_time
  validates_inclusion_of :every, in: ['week', 'month', 'day']

  # Converts a recurrence rule to an array of dates using Recurrence gem
  #
  # @return [Array] an array containing every date between the corresponding period start and end date that meets the recurrence rule criteria
  def dates(options = {})
    options = { every: every, starts: start_date, until: end_date }.merge(options)
    options[:on] = case options[:every]
                   when 'year'
                     [options[:starts].month, options[:starts].day]
                   when 'week'
                     options[:starts].strftime('%A').downcase.to_sym
                   when 'day', 'month'
                     options[:starts].day
                   else
                     raise "valor nao suportado: #{options[:every]}"
                   end
    Recurrence.new(options).events
  end

  # Converts an array of dates into a JSON according to FullCalendar's JSON format
  #
  # @return [Json] a JSON containing every date that the event occurs
  def fullcalendar_conversion
    dates = []
    self.dates.each do |date|
      dates << { id: self.id, title: self.title, start: Event.format_datetime(date, self.start_time), end: Event.format_datetime(date, self.end_time) }
    end

    return dates
  end

  def update_by_date(params, period, subject)
    # self.start_time = params[:start_time]
    # self.end_time = params[:end_time]
    self.update(params)
    self.start_date = period.start_date + ((params[:weekday].to_i - period.start_date.wday) % 7)
    self.end_date ||= period.end_date
    self.fullcalendar_dates = self.fullcalendar_conversion
    self.save
  end

  private
  def self.format_datetime(date, time)
    return DateTime.new(date.year, date.month, date.day, time.hour, time.min, time.sec, time.zone)
  end

  def self.by_date(params, period, subject)
    event = subject.events.new(params)
    event.title ||= subject.name
    event.start_date = period.start_date + ((event.weekday.to_i - period.start_date.wday) % 7)
    event.end_date ||= period.end_date
    event.fullcalendar_dates = event.fullcalendar_conversion
    event
  end
end
