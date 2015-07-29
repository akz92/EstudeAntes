class AddCurrentPeriodToPeriods < ActiveRecord::Migration
  def change
    add_column :periods, :is_current, :boolean
  end
end
