class Test < ActiveRecord::Base
  belongs_to :subject
  validates_numericality_of :grade, :less_than_or_equal_to => :value, :message => 'can\'t be greater than the test value'
  validates_presence_of :date
  after_initialize :init_values

  def init_values
       self.value ||= 0
       self.grade ||= 0
       self.is_project ||= false
  end

  def formatted_init_time
    self.date.strftime("%H:%M")
  end

  def formatted_final_time
    self.date.strftime("%H:%M")
  end

  def self.period_number(period)
    dados_periodo = {"period_number" => []}
    dados_periodo["period_number"] = period.number

    return dados_periodo
  end

  def self.init
  end

end
