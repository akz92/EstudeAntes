class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.datetime :date
      t.integer :value
      t.integer :grade
      t.string :note

      t.timestamps
    end
  end
end
