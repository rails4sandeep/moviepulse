class ReviewsController < ApplicationController
  before_filter :authenticate_user!, :only => [:new, :create,:update,:edit,:destroy], :except => [:show]

  def new
    @movie=Movie.find(params[:movie])
    @review=Review.new({:movie_id => @movie.id})
  end

  def create
    @review=Review.create
    @user=current_user
    @review.user_id=@user.id
    @review.movie_id=params[:movie_id]
    @review.rating=params[:rating]
    @review.review=params[:review]
    if @review.save
      flash[:notice] = 'Movie was successfully created.'
      redirect_to :controller => "movies",:action => "show",:id => @review.movie_id
    else
      @movie=Movie.find(@review.movie_id)
      render :action => "new",:movie => @movie
    end  
   end

  def edit
    #@movie=Movie.find(params[:movie])
    @review=Review.find(params[:id])
    @movie=Movie.find(@review.movie_id)
  
  end

  def update
    @review = Review.find(params[:id])
     if @review.update_attributes(params[:review])
      redirect_to :controller => "movies", :action => "show", :id => @review.movie_id
    else
      @movie=Movie.find(@review.movie_id)
      render :action => "edit",:movie => @movie
    end
  end

  def destroy
    @review=Review.find(params[:id])
    @review.destroy
    redirect_to :controller => "movies", :action => "show", :id => @review.movie_id
  end

  def show
    @user=current_user
    @movies=[]
    @reviews=Review.where(:user_id => @user.id)
    @reviews.each do |review|
      @movies << Movie.find(review.movie_id)
    end
  end


end
