class AddPeriodIdToSubjects < ActiveRecord::Migration
  def up
    add_column :subjects, :period_id, :integer
  end

  def down
    remove_column :subjects, :period_id
  end
end
