class CreateSubjects < ActiveRecord::Migration
  def change
    create_table :subjects do |t|
      t.string :name
			t.integer :period_id
			t.integer :value
			t.float :grade

      t.timestamps
    end

		add_index :subjects, :period_id
  end
end
