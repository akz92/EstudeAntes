class Event < ActiveRecord::Base
  #after_initialize :init_values
  validates_presence_of :start_date
  validates_presence_of :end_date
  validates_presence_of :every
  validates_presence_of :title
  validates_presence_of :start_time
  validates_presence_of :end_time

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

  #def init_values
  #  self.weekday ||= 1
  #  self.recurrent ||= true
  #end

  def formatted_start_time
    self.init_time.strftime("%H:%M")
  end

  def formatted_end_time
    self.final_time.strftime("%H:%M")
  end

  def self.period_number(period)
    dados_periodo = {"period_number" => []}
    dados_periodo["period_number"] = period.number

    return dados_periodo
  end
end
