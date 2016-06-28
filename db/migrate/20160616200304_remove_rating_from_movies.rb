class RemoveRatingFromMovies < ActiveRecord::Migration[5.0]
  def change
    remove_column :movies, :rating, :string
  end
end
