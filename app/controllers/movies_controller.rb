class MoviesController < ApplicationController
  before_filter :authenticate_user!, :only => [:new, :create], :except => [:index,:show,:movie,:dashboard]
  include MoviesHelper

  def index
    @movies=Movie.all_movies#.order('name').page(params[:page]).per(5)
    #@movies.order('name').paginate(:page => params[:page])
    #@movies=Movie.order("name").page(params[:page]).per(5)
    @movies=Kaminari.paginate_array(@movies).page(params[:page]).per(10)
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

  def dashboard
    @movies=top_rated
    @movies_men=top_rated_by_sex('male')
    @movies_women=top_rated_by_sex('female')
    @movies_youth=top_rated_by_youth(25)
    @current_movies=currently_talked_about
    @movies_dampsquibs=damp_squibs
  end
end
