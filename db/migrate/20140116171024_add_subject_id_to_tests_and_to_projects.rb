class AddSubjectIdToTestsAndToProjects < ActiveRecord::Migration
  def up
    add_column :tests, :subject_id, :integer
    add_column :projects, :subject_id, :integer
  end

  def down
    remove_column :tests, :subject_id
    remove_column :projects, :subject_id
  end
end
