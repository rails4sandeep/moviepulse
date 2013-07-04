module MoviesHelper

	def top_rated_recent_releases
	    movies=Array.new
	    movie_hash=Hash.new(0)
	    reviews=Review.where(:rating => [4,5])
	    reviews.each do |review|
	      movies << Movie.find(review.movie_id) if Movie.find(review.movie_id).release.between?(Date.today-90,Date.today)
	    end

	    movies.each do |movie|
	    	movie_hash[movie] = movie_hash[movie] + 1
	    end
	    movie_hash.sort{|x,y| y[1] <=> x[1] }
	    movies=[]
	    movie_hash.each do |x,y|
	    	movies << x
	    end	
	    return movies
  end

  def top_rated_by_sex(sex)
	    movies=Array.new
	    reviews_men=Array.new
	    movie_hash=Hash.new(0)

	    reviews=Review.where(:rating => [4,5])
	    reviews.each do |review|
	    	reviews_men << review if (User.find(review.user_id)).sex==sex
	    end
	    reviews_men.each do |review|
	      movies << Movie.find(review.movie_id)
	    end

	    movies.each do |movie|
	    	movie_hash[movie] = movie_hash[movie] + 1
	    end
	    movie_hash.sort{|x,y| y[1] <=> x[1] }
	    movies=[]
	    movie_hash.each do |x,y|
	    	movies << x
	    end	
	    return movies
  end

  def top_rated_by_youth(age)
	    movies=Array.new
	    reviews_men=Array.new
	    movie_hash=Hash.new(0)

	    reviews=Review.where(:rating => [3,4])
	    reviews.each do |review|
	    	reviews_men << review if User.find(review.user_id).age.to_i.between?(18,age)
	    end
	    reviews_men.each do |review|
	      movies << Movie.find(review.movie_id)
	    end

	    movies.each do |movie|
	    	movie_hash[movie] = movie_hash[movie] + 1
	    end
	    movie_hash.sort{|x,y| y[1] <=> x[1] }
	    movies=[]
	    movie_hash.each do |x,y|
	    	movies << x
	    end	
	    return movies

  end

  def currently_talked_about
		movies=Array.new
	    reviews_latest=Array.new
	    movie_hash=Hash.new(0)
	    reviews=Review.where(:rating => [3,4])
	    reviews.each do |review|
	    	reviews_latest << review if review.created_at.to_date==Date.today
	    end
	    reviews_latest.each do |review|
	      movies << Movie.find(review.movie_id)
	    end
	    movies.each do |movie|
	    	movie_hash[movie] = movie_hash[movie] + 1
	    end
	    movie_hash.sort{|x,y| y[1] <=> x[1] }
	    movies=[]
	    movie_hash.each do |x,y|
	    	movies << x
	    end
	    return movies	
  end

  def damp_squibs
	    movies=Array.new
	    movie_hash=Hash.new(0)
	    reviews=Review.where(:rating => 1)
	    reviews.each do |review|
	      movies << Movie.find(review.movie_id)
	    end

	    movies.each do |movie|
	    	movie_hash[movie] = movie_hash[movie] + 1
	    end
	    movie_hash.sort{|x,y| y[1] <=> x[1] }
	    movies=[]
	    movie_hash.each do |x,y|
	    	movies << x
	    end	
	    return movies
  end
end
