
class Movie < ActiveRecord::Base
  attr_accessible :name,:release,:actors,:director,:music,:description,:media,:movie,:poster_url,:thumb_url,:tmdb_id,
  :movie_description,:movie_tagline,:movie_average_rating,:trailer_url,:movie_average_rating,:movie_au_release_date
  mount_uploader :movie, MovieUploader
  #mount_uploader :remote_movie_url, MovieUploader
  has_many :reviews

  #scopes
  scope :all_movies,Movie.all
  scope :movie_details,lambda {|id| where(:id => id)}
  scope :movies_by_average_rating,Movie.order('average_rating DESC').limit(5)
  scope :movies_by_average_rating_men,Movie.order('average_rating_men DESC').limit(5)
  scope :movies_by_average_rating_women,Movie.order('average_rating_women DESC').limit(5)

  
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
  image=Tmdb::Movie.images(self.tmdb_id).first
  @poster_url=configuration.base_url+'w342'+image['file_path']
end

def thumb_url
  configuration = Tmdb::Configuration.new
  image=Tmdb::Movie.images(self.tmdb_id).first
  @thumb_url=configuration.base_url+'w185'+image['file_path']
end

def trailer_url
  configuration = Tmdb::Configuration.new
  trailer=Tmdb::Movie.trailers(self.tmdb_id)['youtube'][0]['source']
  @trailer_url='youtube.com/embed/'+trailer
end


end

