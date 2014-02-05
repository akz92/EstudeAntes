class Event < ActiveRecord::Base
  belongs_to :subject
  after_initialize :init_values

  def init_values
    self.weekday ||= 1
    self.recurrent ||= true
  end

  def formatted_init_time
    self.init_time.strftime("%H:%M")
  end

  def formatted_final_time
    self.final_time.strftime("%H:%M")
  end
end
