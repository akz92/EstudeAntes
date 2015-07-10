class ChangeGradeType < ActiveRecord::Migration
  def up
    change_column :tests, :grade, :float
  end

  def down
    change_column :tests, :grade, :integer
  end
end
