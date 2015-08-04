class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.date :start_date
      t.text :every
      t.date :end_date
      t.time :start_time
      t.time :end_time
			t.integer :subject_id
			t.string :title
			t.jsonb :fullcalendar_dates

      t.timestamps
    end

		add_index :events, :subject_id
  end
end
