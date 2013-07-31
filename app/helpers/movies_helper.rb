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

def matching_movie_results(movie_name)
  Tmdb::Movie.find(movie_name)
end

def movie_title(movie_id)
  Tmdb::Movie.detail(movie_id).original_title
end

def movie_tmdb_id(movie)
  movie.id
end

def movie_description(movie)
  movie.tagline
end

def movie_cast(movie)
  cast_str=""
  cast_list=Tmdb::Movie.casts(movie_tmdb_id(movie))
  cast_list.each do |cast|
    cast_str=cast_str+','+ cast['name']
  end
  cast_str[1..-1]
end

def movie_average_rating(movie)
  movie.vote_average
end

def movie_no_of_votes(movie)
  movie.vote_count
end

def movie_au_release_date(movie)
  au_release_date=''
  releases=Tmdb::Movie.releases(movie_tmdb_id(movie))['countries']
  releases.each do |rel|
    if !rel['iso_3166_1'].nil?
      au_release_date=rel['release_date'] if rel['iso_3166_1']=='AU'
    end
  end
  return au_release_date
end

def movie_image_url(movie)
  configuration = Tmdb::Configuration.new
  image=Tmdb::Movie.images(movie_tmdb_id(movie)).first
  puts "#{image.inspect}"
  return configuration.base_url+'w342'+image['file_path']
end

def movie_trailer_url(movie)
  configuration = Tmdb::Configuration.new
  trailer=Tmdb::Movie.trailers(movie_tmdb_id(movie))['youtube'][0]['source']
  return 'youtube.com/embed/'+trailer
end



end
