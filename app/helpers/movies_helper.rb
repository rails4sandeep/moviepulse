module MoviesHelper

	def top_rated_recent_releases
	    movies=Array.new
	    movie_hash=Hash.new(0)
	    reviews=Review.where(:rating => [4,5,6,7,8,9])
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

	    reviews=Review.where(:rating => [4,5,6,7,8,9])
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

	    reviews=Review.where(:rating => [4,5,6,7,8,9])
	    reviews.each do |review|
	    	reviews_men << review if User.find(review.user_id).age.to_i.between?(20,age)
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
	    return movies[0..4]

  end

  def currently_talked_about
		movies=Array.new
	    reviews_latest=Array.new
	    movie_hash=Hash.new(0)
	    reviews=Review.where(:rating => [4,5,6,7,8,9])
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
	    return movies[0..4]	
  end

  def damp_squibs
	    movies=Array.new
	    movie_hash=Hash.new(0)
	    reviews=Review.where(:rating => [1,2])
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
	    return movies[0..4]
  end

  def now_playing
  	movies=Array.new
  	@now_playing=Tmdb::Movie.now_playing
  	@now_playing.each do |movie|
  		begin
	  		movie_hash=Hash.new
  			movie_hash[:name]=movie['original_title']
  			movie_hash[:tmdb_id]=movie['id']
  			movies << movie_hash
  		end unless movie.nil?
  	end
  	return movies
  end

  def upcoming
  	movies=Array.new
  	@upcoming=Tmdb::Movie.upcoming
  	@upcoming.each do |movie|
  		begin
	  		movie_hash=Hash.new
  			movie_hash[:name]=movie['original_title']
  			movie_hash[:tmdb_id]=movie['id']
  			movies << movie_hash
  		end unless movie.nil?
  	end
  	return movies
  end

  def popular
  	movies=Array.new
  	@popular=Tmdb::Movie.popular
  	@popular.each do |movie|
  		begin
	  		movie_hash=Hash.new
  			movie_hash[:name]=movie['original_title']
  			movie_hash[:tmdb_id]=movie['id']
  			movies << movie_hash
  		end unless movie.nil?
  	end
  	return movies
  end

  def tmdb_top_rated
  	movies=Array.new
  	@tmdb_top_rated=Tmdb::Movie.top_rated
  	@tmdb_top_rated.each do |movie|
  		begin
	  		movie_hash=Hash.new
  			movie_hash[:name]=movie['original_title']
  			movie_hash[:tmdb_id]=movie['id']
  			movies << movie_hash
  		end unless movie.nil?
  	end
  	return movies
  end

def movie_title(movie_id)
    Tmdb::Movie.detail(movie_id).original_title
  end

def matching_movie_results(movie_name)
  Tmdb::Movie.find(movie_name)
end

end
