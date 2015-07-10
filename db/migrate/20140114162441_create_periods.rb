class CreatePeriods < ActiveRecord::Migration
  def change
    create_table :periods do |t|
      t.date :init_date
      t.date :final_date
      t.integer :number

      t.timestamps
    end
  end
end
