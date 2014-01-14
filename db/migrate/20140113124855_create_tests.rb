class CreateTests < ActiveRecord::Migration
  def change
    create_table :tests do |t|
      t.date :date
      t.integer :value
      t.integer :grade
      t.string :matter

      t.timestamps
    end
  end
end
