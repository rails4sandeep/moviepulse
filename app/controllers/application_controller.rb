class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_search

  def set_search
  	@search=Movie.search(params[:q])
    if params[:q].nil? then
      @search=Movie.search(params[:q])
      @movie_results=[]
    else
      @search=Movie.search(params[:q])
      @movie_results=@search.result
    end
  end

end
