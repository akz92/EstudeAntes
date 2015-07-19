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
    dados = {"events"=> [], "tests"=> [], "init_times"=> [], "subjects"=> [], "period"=> [], "period_number" => [], "current_period" => [], "all_periods" => []}

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
        dados["init_times"] << event.formatted_init_time
      end
    end

    dados["events"].sort_by! { |a| [a.weekday, a.init_time, a.final_time] }

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
        events << {id: event.id, title: subject.name, start: event.init_time.strftime("%Y-%m-%d"),  end: event.final_time.strftime("%Y-%m-%d")}
      end
    end
  
  return events
  end

  def self.check_current_period(period)
    if (period.init_date != nil && period.final_date != nil &&(Date.today >= period.init_date) && (Date.today <= period.final_date))
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
