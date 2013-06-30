class Review < ActiveRecord::Base
  attr_accessible :rating, :review,:movie_id,:user_id
  belongs_to :movie
  belongs_to :user

  scope :reviews_for_movie,lambda {|id| where(:movie_id => id)}

  validates_presence_of :review,:rating,:message => "Your rating is sacrosanct"
  validates_length_of :review,:within => 1..140,:message => "Review must be between 1 and 140 characters"
	  
end
