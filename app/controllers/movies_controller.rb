class MoviesController < ApplicationController
  def new
    @movie = Movie.new

  end

  def index
    matching_movies = Movie.all

    @movies = matching_movies.order created_at: :desc 

    respond_to do |format|
      format.json do
        render json: @movies
      end

      format.html do
        render "movies/index"
      end
    end
  end

  def show
    @movie = Movie.find_by(id: params.fetch(:id))

  end

  def create
    @movie = Movie.new
    @movie.title = params.fetch(:title)
    @movie.description = params.fetch(:description)

    if @movie.valid?
      @movie.save
      redirect_to movies_url, notice: "Movie created successfully."
    else
      render "movies/new"
    end
  end

  def edit
    the_id = params.fetch(:id)

    matching_movies = Movie.where id: the_id

    @movie = matching_movies.first

  end

  def update
    the_id = params.fetch(:id)
    the_movie = Movie.where( id: the_id ).first

    the_movie.title = params.fetch(:title)
    the_movie.description = params.fetch(:description)

    if the_movie.valid?
      the_movie.save
      redirect_to "/movies/#{the_movie.id}", notice: "Movie updated successfully."
    else
      redirect_to "/movies/#{the_movie.id}", alert: "Movie failed to update successfully."
    end
  end

  def destroy
    the_id = params.fetch(:id)
    @movie = Movie.where(id: the_id).first

    @movie.destroy

    redirect_to "/movies", notice: "Movie deleted successfully."
  end
end
