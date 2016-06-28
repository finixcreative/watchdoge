class Movie < ApplicationRecord
	searchkick
	belongs_to :user
	has_many :reviews, dependent: :destroy
	has_attached_file :image, styles: { medium: "400x600#" }
	validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
#	base_url Rails.application.config.api_server_url
#	get		:all,		"/movies"
#	get 	:find,		"/movies/:id"
#	put 	:save,		"/movies/:id"
#	post 	:create,	"/movies"
end