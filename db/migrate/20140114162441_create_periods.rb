class CreatePeriods < ActiveRecord::Migration
  def change
    create_table :periods do |t|
      t.date :start_date
      t.date :end_date
      t.integer :number
			t.boolean :is_current
			t.integer :user_id

      t.timestamps
    end

		add_index :periods, :user_id
  end
end
