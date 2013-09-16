class Review < ActiveRecord::Base
  attr_accessible :rating, :review,:movie_id,:user_id
  belongs_to :movie
  belongs_to :user

  scope :reviews_for_movie,lambda {|id| where(:movie_id => id)}
  scope :reviews_for_user,lambda {|id| where(:user_id => id)}

  validates_presence_of :review,:rating,:message => "Your rating is sacrosanct"
  validates_length_of :review,:within => 1..200,:message => "Review must be between 1 and 200 characters"

  after_save :reset_user_ratings

  private

  def reset_user_ratings
    sum_all=0
    sum_men=0
    men_count=0
    sum_women=0
    women_count=0
    average_overall=0
    average_men=0
    average_women=0
    @movie=Movie.find(self.movie_id)
    reviews=Review.where(:movie_id => @movie.id)
    reviews.each do |review|
      sum_all = sum_all+review.rating
      sum_men = sum_men+review.rating if User.find(review.user_id).sex == 'male'
      men_count = men_count + 1 if User.find(review.user_id).sex == 'male'
      sum_women = sum_women+review.rating if User.find(review.user_id).sex == 'female'
      women_count = women_count + 1 if User.find(review.user_id).sex == 'female'
    end unless reviews.empty?
    average_overall=(sum_all/reviews.count) if reviews.count!=0
    average_men=sum_men/men_count if men_count!=0
    average_women=sum_women/women_count if women_count!=0
    @movie.average_rating=average_overall
    @movie.average_rating_men=average_men
    @movie.average_rating_women=average_women
    @movie.save

  end
end
