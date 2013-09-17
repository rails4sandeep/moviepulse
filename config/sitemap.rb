# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "http://www.moviepulse.info"
#SitemapGenerator::Sitemap.adapter = SitemapGenerator::WaveAdapter.new
#SitemapGenerator::Sitemap.sitemaps_host = ENV['SITEMAP_HOST']
SitemapGenerator::Sitemap.public_path = 'shared/'
SitemapGenerator::Sitemap.sitemaps_path = 'sitemaps/'

SitemapGenerator::Sitemap.create do

  add '/movies/dashboard'
  add '/users/sign_in'
  add '/users/sign_up'
  add '/movies'
  add '/faqs'
  add '/credits'
  add '/faqs/privacy'
  add '/reviews/show'
  add '/users/edit'
    Movie.find_each do |movie|
      add movie_path(movie), lastmod: movie.updated_at
    end
    
    Review.find_each do |review|
      add review_path(review), lastmod: review.updated_at
    end

  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  #
  # Examples:
  #
  # Add '/articles'
  #
  #   add articles_path, :priority => 0.7, :changefreq => 'daily'
  #
  # Add all articles:
  #
  #   Article.find_each do |article|
  #     add article_path(article), :lastmod => article.updated_at
  #   end
end
