require 'rails_helper'

RSpec.describe "CreateReviews", type: :request do
  it "Adds new reviews to database" do
  	user = factory(:user)
  	create(:user) do |user|
  		user.review.create()
  	end
  	review = factory(:review)
  	visit new_movie_review_path
  	fill_in :rating, with: review.rating
  	fill_in :comment, with: review.comment
  	fill_in :movie_id, with: review.movie_id
  	click_button "Complete"
  end
end