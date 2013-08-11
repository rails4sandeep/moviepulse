class AddNowPlayingAustraliaColumnToMovies < ActiveRecord::Migration
  def change
  	add_column :movies, :now_playing_au, :integer
  end
end
