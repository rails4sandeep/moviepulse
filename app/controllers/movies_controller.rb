class MoviesController < ApplicationController
  before_filter :authenticate_admin!, :only => [:new, :create], :except => [:index,:show,:movie,:dashboard,:create_from_tmdb,:suggest,:suggest_movies]
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
        #flash[:notice] = 'Movie was successfully created.'
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
    #@movies=Kaminari.paginate_array(Movie.movies_by_average_rating).page(params[:page]).per(10)
    #@movies_men=top_rated_by_sex('male')
    #@movies_women=top_rated_by_sex('female')
    #@movies_youth=top_rated_by_youth(40)
    #@current_movies=currently_talked_about
    #@movies_dampsquibs=damp_squibs
    @movies_now_playing=now_playing
    #@movies_now_playing_au=Movie.movies_now_playing_australia
    @movies_upcoming=upcoming
    @movies_popular=popular
    #@movies_tmdb_top_rated=tmdb_top_rated
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def update
    @movie = Movie.find(params[:id])
      if @movie.update_attributes(params[:movie])
        redirect_to @movie, notice: 'Movie was successfully updated.' 
      else
        render action: "edit"
      end
    
  end

  def import
    logger.debug("inside movies import--->#{params[:file].inspect}")
    require 'csv'
    @lines = []
    Movie.update_all("now_playing_au=0")
    uploaded_io=params[:file]
    File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'w') do |file|
        file.write(uploaded_io.read)
      end
    File.foreach(Rails.root.join('public', 'uploads', uploaded_io.original_filename)){|line| logger.debug line}
    lines=IO.readlines(Rails.root.join('public', 'uploads', uploaded_io.original_filename))
    lines.each{|l| logger.debug l}
      lines.each do |line|
      movie_id=line.split(',').first
      movie_name=line.split(',').last
      if Movie.where(:tmdb_id => movie_id).empty?
        @movie=Movie.new
        @movie.tmdb_id=movie_id
        @movie.name=movie_name
        @movie.now_playing_au=1
        @movie.save
      else
        @movie=Movie.where(:tmdb_id => movie_id).first
        @movie.now_playing_au=1
        @movie.save
      end
    end
    redirect_to action: "index", notice: 'Australia Movie Release Data Imported'
  end

  def upload
    
  end

  #def suggest

  #end

  def suggest
     @suggest_results=suggested_movie_results(params[:name]) unless params[:name].nil?
     @name = params[:name]
  end

end
