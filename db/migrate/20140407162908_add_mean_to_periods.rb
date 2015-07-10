class AddMeanToPeriods < ActiveRecord::Migration
  def self.up
    add_column :periods, :mean, :float
  end

  def self.down
    remove_column :periods, :mean, :float
  end
end
