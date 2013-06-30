class AddColumnsToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :release, :date
    add_column :movies, :actors, :string
    add_column :movies, :director, :string
    add_column :movies, :music, :string
    add_column :movies, :description, :text
    add_column :movies, :media, :binary
  end
end
