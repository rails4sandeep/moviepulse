class AddRatingsToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :average_rating, :decimal
    add_column :movies, :average_rating_men, :decimal
    add_column :movies, :average_rating_women, :decimal
  end
end
