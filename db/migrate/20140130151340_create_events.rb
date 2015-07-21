class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :weekday
      t.time :init_time
      t.time :final_time
      t.boolean :recurrent

      t.timestamps
    end
  end
end
