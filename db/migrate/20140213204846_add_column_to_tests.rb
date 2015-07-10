class AddColumnToTests < ActiveRecord::Migration
  def change
    add_column :tests, :subject_name, :string
  end
end
