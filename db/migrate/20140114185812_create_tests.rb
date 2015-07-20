class CreateTests < ActiveRecord::Migration
  def change
    create_table :tests do |t|
      t.datetime :date
      t.integer :value
      t.integer :grade
      t.string :note
      t.integer :subject_id

      t.timestamps
    end
  end
end
