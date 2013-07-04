
class Movie < ActiveRecord::Base
  attr_accessible :name,:release,:actors,:director,:music,:description,:media,:movie
  mount_uploader :movie, MovieUploader
  has_many :reviews

  #scopes
  scope :all_movies,Movie.all
  scope :movie_details,lambda {|id| where(:id => id)}
  scope :movies_by_average_rating,Movie.order('average_rating DESC')
  scope :movies_by_average_rating_men,Movie.order('average_rating_men DESC')
  scope :movies_by_average_rating_women,Movie.order('average_rating_women DESC')

  #validations
  validates_presence_of :name,:release,:actors,:director,:music,:description, :on => :create, :message => "can't be blank"
  #validates_presence_of :actors, :on => :create, :message => "can't be blank"
  
  
end
