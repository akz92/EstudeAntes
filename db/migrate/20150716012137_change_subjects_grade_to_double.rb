class ChangeSubjectsGradeToDouble < ActiveRecord::Migration
  def change
    change_column :subjects, :grade, 'float USING CAST(grade AS float)'
  end
end
