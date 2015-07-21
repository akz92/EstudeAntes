class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.date :start_date
      t.text :every
      t.date :end_date
      t.time :init_time
      t.time :final_time

      t.timestamps
    end
  end
end
