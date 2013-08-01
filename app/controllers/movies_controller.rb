class MoviesController < ApplicationController
  before_filter :authenticate_user!, :only => [:new, :create], :except => [:index,:show,:movie,:dashboard,:create_from_tmdb]
  include MoviesHelper

  def index
    @tmdb_movie_results=[]
    @search=Movie.search(params[:q])
    if params[:q].nil? then
      @search=Movie.search(params[:q])
      @movie_results=[]
    else
      @search=Movie.search(params[:q])
      @movie_results=@search.result
    end
    if params[:q].nil? || params[:q]['name_cont'].empty?
      @tmdb_movie_results=[]
    else   
      @tmdb_movie_results=matching_movie_results(params[:q]['name_cont'])
    end
    #@movies = @q.result(:distinct => true)
    #@movies=Movie.all_movies#.order('name').page(params[:page]).per(5)
    #@movies.order('name').paginate(:page => params[:page])
    #@movies=Movie.order("name").page(params[:page]).per(5)
    @movies=Kaminari.paginate_array(@movie_results).page(params[:page]).per(5)
    @tmdb_movies=Kaminari.paginate_array(@tmdb_movie_results).page(params[:page]).per(5)
  end

  def show
    @users=Array.new
    @ratings=Array.new
    @movie=Movie.find(params[:id])
    @reviews=Review.reviews_for_movie(params[:id])
    @reviews.each do |review|
      @users << User.find(review.user_id)
      @ratings << review.rating
    end
    @average_movie_rating=(@ratings.sum)/(@ratings.count) unless @ratings.empty?
  end

  def movie

    @users=Array.new
    @movie=Movie.find(:movie)
    @reviews=Review.reviews_for_movie(:movie)

    @reviews.each do |review|
      @users << User.find(review.user_id)
    end
  end

  def new
    @movie=Movie.new
  end

  def create
    @movie = Movie.new params[:movie]
      if gotcha_valid? && @movie.save
        flash[:notice] = 'Movie was successfully created.'
        redirect_to :action => "show", :id => @movie.id
      else
        render :action => "new"
      end
  end

  def create_from_tmdb
    if Movie.where(:tmdb_id => params[:id]).empty?
      @movie = Movie.new
      @movie.name=movie_title(params[:id])
      @movie.tmdb_id=params[:id]
      if @movie.save
        flash[:notice] = 'Movie was successfully created.'
        redirect_to :action => "show", :id => @movie.id
      else
        render :action => "index"
      end
    else
      @movie=Movie.where(:tmdb_id => params[:id]).first
      redirect_to :action => "show", :id => @movie.id
    end  

  end

  def dashboard
    #@movies=Movie.movies_by_average_rating
    @movies=Kaminari.paginate_array(Movie.movies_by_average_rating).page(params[:page]).per(10)
    @movies_men=Movie.movies_by_average_rating_men
    @movies_women=Movie.movies_by_average_rating_women
    @movies_youth=top_rated_by_youth(25)
    @current_movies=currently_talked_about
    @movies_dampsquibs=damp_squibs
    @movies_now_playing=now_playing
  end

end
