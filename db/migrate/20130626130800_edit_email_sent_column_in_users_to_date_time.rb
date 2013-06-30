class EditEmailSentColumnInUsersToDateTime < ActiveRecord::Migration
  def up
  	change_column :users,:reset_password_sent_at,:datetime
  end

  def down
  end
end
