class Event < ActiveRecord::Base
  belongs_to :subject
  #after_initialize :init_values
  attr_accessor :weekday
  validates_presence_of :start_date, :every, :end_date

  #def init_values
  #  self.weekday ||= 1
  #  self.recurrent ||= true
  #end
  
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

  #def self.next_date(day, date)
  #  weekday = Date::DAYNAMES[day].to_s
  #  new_date  = date(weekday)
  #  delta = new_date > Date.today ? 0 : 7
  #  new_date + delta
  #end

  #def self.next_weekday(date, weekday)
  #  #date = Date::strptime(init_date, "%m-%d-%Y")
  #  date += 1 + ((weekday-date.wday) % 7) 
  #  date
  #end

  def as_json(options = {})
    {
      id: self.id,
      title: self.title,
      start: self.start_time,
      end: self.end_time,
      allDay: false
    }
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
