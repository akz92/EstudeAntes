#encoding: utf-8
class Period < ActiveRecord::Base
  belongs_to :user
  has_many :subjects
  validate :check_current_period

  private

  def check_current_period
    if current_period && Period.where(current_period: true).count > 0
      errors.add(:base, "Você já possui um período vigente")
    end
  end

end
