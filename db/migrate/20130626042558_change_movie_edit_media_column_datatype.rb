class ChangeMovieEditMediaColumnDatatype < ActiveRecord::Migration
  def up
    change_column :movies,:media,:string
  end

  def down
  end
end
