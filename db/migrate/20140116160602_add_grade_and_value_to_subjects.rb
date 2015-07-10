class AddGradeAndValueToSubjects < ActiveRecord::Migration
  def up
    add_column :subjects, :value, :integer
    add_column :subjects, :grade, :integer
  end

  def down
    remove_column :subjects, :value
    remove_column :subjects, :grade
  end

end
