class AddColumnIsProjectToTests < ActiveRecord::Migration
  def change
    add_column :tests, :is_project, :boolean
  end
end
