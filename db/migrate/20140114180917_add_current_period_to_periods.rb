class AddCurrentPeriodToPeriods < ActiveRecord::Migration
  def change
    add_column :periods, :current_period, :boolean
  end
end
