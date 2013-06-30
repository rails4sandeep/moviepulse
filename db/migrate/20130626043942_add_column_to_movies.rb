class AddColumnToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :movie, :string
  end
end
