class AddColumnToEvents < ActiveRecord::Migration
  def change
    add_column :events, :subject_id, :integer
  end
end
