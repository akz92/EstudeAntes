#encoding: utf-8
class Period < ActiveRecord::Base
  belongs_to :user
  has_many :subjects
  after_initialize :init_values
  validates_presence_of :init_date, :final_date, :number
  validates_numericality_of :number
  # validate :check_current_period

  def init_values
    self.mean ||= 0
  end

  def self.get_tests_events_init_times(periods, date, other_periods)
    dados = {"events"=> [], "tests"=> [], "init_times"=> [], "subjects"=> [], "period"=> [], "period_number" => [], "current_period" => [], "all_periods" => [], "highest_endtime" => []}

    periods.each do |period|
      dados["period"] = period
      dados["subjects"] = period.subjects
      dados["period_number"] = period.number
      if period.current_period
        dados["current_period"] = true
      else
        dados["current_period"] = false
      end
    end

    other_periods.each do |period|
      dados["all_periods"] << period
    end


    dados["subjects"].each do |subject|
      subject.tests.each do |test|
        if (test.date.strftime("%U").to_i == date.strftime("%U").to_i)
          dados["tests"] << test
        end
      end

      subject.events.each do |event|
        dados["events"] << event
        dados["init_times"] << event.formatted_start_time
        dados["highest_endtime"] << event.formatted_end_time
      end
    end
    unless dados["highest_endtime"] == []
      dados["highest_endtime"].sort!
      dados["highest_endtime"] = dados["highest_endtime"].last
    end
    
    unless dados["init_times"] == []
      dados["init_times"].uniq!
      dados["init_times"].sort!
    end

    return dados
  end

  def self.get_events(period)
    events = []
    period[0].subjects.each do |subject|
      subject.events.each do |event|
        event.dates.each do |date|
          fullcalendar_start = DateTime.new(date.year, date.month, date.day, event.start_time.hour, event.start_time.min, event.start_time.sec, event.start_time.zone)
          fullcalendar_end = DateTime.new(date.year, date.month, date.day, event.end_time.hour, event.end_time.min, event.end_time.sec, event.end_time.zone)
          events << {id: event.id, title: event.title, start: fullcalendar_start.iso8601,  end: fullcalendar_end.iso8601}
        end
      end
    end
  
  return events
  end

  def self.check_current_period(period)
    if ((Date.today >= period.init_date) && (Date.today <= period.final_date))
      period.current_period = true
    else
      period.current_period = false
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
