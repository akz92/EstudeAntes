class RemoveMatterFromTest < ActiveRecord::Migration
  def change
    remove_column :tests, :matter
  end
end
