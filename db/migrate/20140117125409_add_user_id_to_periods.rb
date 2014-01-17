class AddUserIdToPeriods < ActiveRecord::Migration
  def up
    add_column :periods, :user_id, :integer
  end

  def down
    remove_column :periods, :user_id
  end
end
