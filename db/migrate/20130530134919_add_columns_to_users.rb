class AddColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :username, :string
    add_column :users, :age, :integer
    add_column :users, :sex, :string
    add_column :users, :country, :string
    add_column :users, :city, :string
  end
end
