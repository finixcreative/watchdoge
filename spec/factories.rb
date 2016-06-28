FactoryGirl.define do
	factory :user do
		user_email "example@email.com"
	end

	factory :review do
		rating 5
		comment "Loved it."
		movie_id 300000
	end
end