class EditColumnsInUsers < ActiveRecord::Migration
  def up
    change_column :users,:age,:string
  end

  def down
  end
end
