class ChangePeriodInitAndFinalDate < ActiveRecord::Migration
  def change
    rename_column :periods, :init_date, :start_date
    rename_column :periods, :final_date, :end_date
  end
end
