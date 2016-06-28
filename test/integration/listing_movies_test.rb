require 'test_helper'

class ListingMoviesTest < ActionDispatch::IntegrationTest

	setup { host! 'api.example.com'}
	test 'return list of all movies' do
		get '/movies'
		assert_equal 200, response.status
		refute_empty response.body

end