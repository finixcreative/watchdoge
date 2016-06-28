require 'themoviedb'

class MoviesController < ApplicationController
	before_action :set_movie, only: [:show, :new, :create, :edit, :update, :destroy]
	before_action :authenticate_user!, except: [:index, :show, :search]
	# GET /movies
	# GET /movies.json

	Tmdb::Api.key("b5eca1ae38bd3945a2564f64ff6595e0")

	def index
		#@movies = Movie.all.order('title').paginate(page: params[:page], per_page: 4)
		if params[:filter] == "popular"
			@movies = Tmdb::Movie.popular
			@headline = "Most Popular"
		elsif params[:filter] == "toprated"
			@movies = Tmdb::Movie.top_rated
			@headline = "Top Rated"
		elsif params[:filter] == "nowplaying"
			@movies = Tmdb::Movie.now_playing
			@headline = "Playing Now"
		elsif params[:filter] == "upcoming"
			@movies = Tmdb::Movie.upcoming
			@headline = "Coming Soon"
		else
			@movies = Tmdb::Movie.popular
			@headline = "Most Popular"
		end

		if params[:order] == "title"
			@movies.sort! { |a,b| a.title <=> b.title }
			@subheadline = "by Title"
		elsif params[:order] == "release"
			@movies.sort! { |a,b| a.release_date <=> b.release_date }
			@subheadline = "by Release Date"
		elsif params[:order] == "genre"
			@movies.sort! { |a,b| a.genres <=> b.genres }
			@subheadline = "by Genre"
		else
			@movies.sort! { |a,b| a.title <=> b.title }
		end
	end

	def search
		if params[:search].present?
			@movies = Tmdb::Movie.find(params[:search])
		else
			@movies = Tmdb::Movie.popular
		end

		if params[:order] == "title"
			@movies.sort! { |a,b| a.title <=> b.title }
			@subheadline = "by Title"
		elsif params[:order] == "release"
			@movies.sort! { |a,b| a.release_date <=> b.release_date }
			@subheadline = "by Release Date"
		elsif params[:order] == "genre"
			@movies.sort! { |a,b| a.genres <=> b.genres }
			@subheadline = "by Genre"
		else
			@movies.sort! { |a,b| a.title <=> b.title }
		end
	end
	# GET /movies/1
	# GET /movies/1.json
	def show
		@reviews = Review.where(movie_id: @movie['id']).order("created_at DESC")
		if @reviews.blank?
			@avg_review = 0
		else
			@avg_review = @reviews.average(:rating).round(2)
		end
	end

	# GET /movies/new
	def new
		@movie = current_user.movies.build
	end

	# GET /movies/1/edit
	def edit
	end

	# POST /movies
	# POST /movies.json
	def create
		@movie = current_user.movies.build(movie_params)

		respond_to do |format|
			if @movie.save
				format.html { redirect_to @movie, notice: 'Movie was successfully created.' }
				format.json { render :show, status: :created, location: @movie }
			else
				format.html { render :new }
				format.json { render json: @movie.errors, status: :unprocessable_entity }
			end
		end
	end

	# PATCH/PUT /movies/1
	# PATCH/PUT /movies/1.json
	def update
		respond_to do |format|
			if @movie.update(movie_params)
				format.html { redirect_to movies_url, notice: 'Movie was successfully updated.' }
				format.json { render :show, status: :ok, location: @movie }
			else
				format.html { render :edit }
				format.json { render json: @movie.errors, status: :unprocessable_entity }
			end
		end
	end

	# DELETE /movies/1
	# DELETE /movies/1.json
	def destroy
		@movie.destroy
		respond_to do |format|
			format.html { redirect_to movies_url, notice: 'Movie was successfully destroyed.' }
			format.json { head :no_content }
		end
	end

	private
		# Use callbacks to share common setup or constraints between actions.
		def set_movie
			@movie = Tmdb::Movie.detail(params[:id])
			@movie_id = @movie['id']
			@movie_poster = "https://image.tmdb.org/t/p/w185/#{@movie['poster_path']}"
		end

		# Never trust parameters from the scary internet, only allow the white list through.
		def movie_params
			params.require(:movie).permit(:title, :release_date, :genre, :rating, :image)
		end
end