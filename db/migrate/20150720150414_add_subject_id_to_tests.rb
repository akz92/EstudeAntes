class AddSubjectIdToTests < ActiveRecord::Migration
  def change
    add_column :tests, :subject_id, :integer
  end
end
