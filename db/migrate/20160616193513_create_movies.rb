class CreateMovies < ActiveRecord::Migration[5.0]
  def change
    create_table :movies do |t|
      t.string :title
      t.date :release_date
      t.string :genre
      t.string :rating

      t.timestamps
    end
  end
end
