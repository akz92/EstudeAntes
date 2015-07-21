class Event < ActiveRecord::Base
  belongs_to :subject
  #after_initialize :init_values
  validates_presence_of :init_time, :final_time

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

  def formatted_init_time
    self.init_time.strftime("%H:%M")
  end

  def formatted_final_time
    self.final_time.strftime("%H:%M")
  end

  def self.period_number(period)
    dados_periodo = {"period_number" => []}
    dados_periodo["period_number"] = period.number

    return dados_periodo
  end
end
