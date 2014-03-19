#encoding: utf-8
class Period < ActiveRecord::Base
  belongs_to :user
  has_many :subjects
  # validate :check_current_period

  def self.get_tests_events_init_times(periods, date)
    dados = {"events"=> [], "tests"=> [], "init_times"=> [], "subjects"=> [], "period"=> []}

    periods.each do |period|
      if period.current_period
        dados["period"] = period
        dados["subjects"] = period.subjects
      end
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
    dados["init_times"].uniq!.sort!

    return dados
  end

  def self.check_current_period(period)
    if (Date.today >= period.init_date) && (Date.today <= period.final_date)
      period.current_period = true
    else
      period.current_period = false
    end

    return period
  end
end
