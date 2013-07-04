class ChangeRatingsDataTypesInMovies < ActiveRecord::Migration
  def up
    change_column :movies,:average_rating,:integer
    change_column :movies,:average_rating_men,:integer
    change_column :movies,:average_rating_women,:integer
  end

  def down
  end
end
