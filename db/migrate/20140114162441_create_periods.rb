class CreatePeriods < ActiveRecord::Migration
  def change
    create_table :periods do |t|
      t.date :start_date
      t.date :end_date
      t.integer :number

      t.timestamps
    end
  end
end
