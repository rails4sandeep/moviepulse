class EditEmailSentColumnInUsers < ActiveRecord::Migration
  def up
  	change_column :users,:reset_password_sent_at,:date
  end

  def down
  end
end
