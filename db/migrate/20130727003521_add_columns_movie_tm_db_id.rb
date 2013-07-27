class AddColumnsMovieTmDbId < ActiveRecord::Migration
  def up
    add_column(:movies,:tmdb_id,:integer)
  end

  def down
    remove_column(:movies,:tmdb_id,:integer)
  end
end
