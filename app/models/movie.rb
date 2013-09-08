
class Movie < ActiveRecord::Base
  attr_accessible :name,:release,:actors,:director,:music,:description,:media,:movie,:poster_url,:thumb_url,:tmdb_id,
  :movie_description,:movie_tagline,:movie_average_rating,:trailer_url,:movie_average_rating,:movie_au_release_date,
  :movie_genres,:movie_production_companies,:movie_runtime,:now_playing_au
  mount_uploader :movie, MovieUploader
  #mount_uploader :remote_movie_url, MovieUploader
  has_many :reviews

  #scopes
  scope :all_movies,Movie.all
  scope :movie_details,lambda {|id| where(:id => id)}
  scope :movies_by_average_rating,Movie.where('average_rating IS NOT NULL').order('average_rating DESC').limit(5)
  scope :movies_by_average_rating_men,Movie.where('average_rating IS NOT NULL').order('average_rating_men DESC').limit(5)
  scope :movies_by_average_rating_women,Movie.where('average_rating IS NOT NULL').order('average_rating_women DESC').limit(5)
  scope :movies_now_playing_australia,Movie.where(:now_playing_au => 1).order('updated_at DESC').limit(25)

  
  #validations
  #validates_presence_of :name,:release,:actors,:director,:music,:description, :on => :create, :message => "can't be blank"
  #validates_presence_of :actors, :on => :create, :message => "can't be blank"

def movie_title(movie_id)
  Tmdb::Movie.detail(movie_id).original_title
end

def movie_tmdb_id(movie)
  movie.id
end

def movie_description
  @movie_description=Tmdb::Movie.detail(self.tmdb_id).overview
end

def movie_tagline
  @movie_tagline=Tmdb::Movie.detail(self.tmdb_id).tagline
end

def movie_cast
  cast_str=""
  cast_list=Tmdb::Movie.casts(self.tmdb_id)
  cast_list.each do |cast|
  cast_str=cast_str+','+ cast['name']
  end
  @movie_cast=cast_str[1..-1]
end

def movie_average_rating
  @movie_average_rating=Tmdb::Movie.detail(self.tmdb_id).vote_average
end

def movie_no_of_votes(movie)
  @movie_no_of_votes=Tmdb::Movie.detail(self.tmdb_id).vote_count
end

def movie_au_release_date
  au_release_date=''
  releases=Tmdb::Movie.releases(self.tmdb_id)['countries']
  releases.each do |rel|
    if !rel['iso_3166_1'].nil?
      au_release_date=rel['release_date'] if rel['iso_3166_1']=='AU'
    end
  end
  @movie_au_release_date=au_release_date
end

def poster_url
  configuration = Tmdb::Configuration.new
  if Tmdb::Movie.detail(self.tmdb_id).poster_path.nil?
    poster_path=''
  else
    poster_path=Tmdb::Movie.detail(self.tmdb_id).poster_path
  end  
    @poster_url=configuration.base_url+'w342'+poster_path
end

def thumb_url
  configuration = Tmdb::Configuration.new
  if Tmdb::Movie.detail(self.tmdb_id).poster_path.nil?
    @thumb_url=configuration.base_url+'w154'+''
  else  
    @thumb_url=configuration.base_url+'w154'+Tmdb::Movie.detail(self.tmdb_id).poster_path
  end  
end

def trailer_url
  configuration = Tmdb::Configuration.new
  trailer=Tmdb::Movie.trailers(self.tmdb_id)['youtube'][0]['source']
  @trailer_url='youtube.com/embed/'+trailer
end

def movie_genres
  genres_str=""
  genres_list=Tmdb::Movie.detail(self.tmdb_id).genres
  genres_list.each do |genre|
  genres_str=genres_str+','+ genre['name']
  end
  @movie_genres=genres_str[1..-1]
end

def movie_production_companies
  prod_companies_str=""
  companies_list=Tmdb::Movie.detail(self.tmdb_id).production_companies
  companies_list.each do |company|
  prod_companies_str=prod_companies_str+','+ company['name']
  end
  @movie_production_companies=prod_companies_str[1..-1]
end

def movie_runtime
  @movie_runtime=Tmdb::Movie.detail(self.tmdb_id).runtime
end

end

