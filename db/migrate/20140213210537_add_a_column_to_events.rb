class AddAColumnToEvents < ActiveRecord::Migration
  def change
    add_column :events, :subject_name, :string
  end
end
