class CreateTests < ActiveRecord::Migration
  def change
    create_table :tests do |t|
      t.datetime :date
      t.integer :value
      t.float :grade
      t.string :note
			t.boolean :is_project, default: false
			t.integer :subject_id

      t.timestamps
    end

		add_index :tests, :subject_id
  end
end
