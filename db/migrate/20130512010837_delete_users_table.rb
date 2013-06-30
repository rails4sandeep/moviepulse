class DeleteUsersTable < ActiveRecord::Migration
  def up
    drop_table :users
  end

  def down
    drop_table :users
  end
end
