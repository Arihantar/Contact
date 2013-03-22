require 'rubygems'
require 'sitemap_generator'

SitemapGenerator::Sitemap.default_host = 'http://www.example.com'
SitemapGenerator::Sitemap.create do
  add '/home', :changefreq => 'daily', :priority => 0.9
  add '/contact_us', :changefreq => 'weekly'
  add('/index.html', :video => {
  :thumbnail_loc => 'http://www.example.com/video1_thumbnail.png',
  :title => 'Title',
  :description => 'Description',
  :content_loc => 'http://www.example.com/cool_video.mpg',
  :tags => %w[one two three],
  :category => 'Category'
})
end
SitemapGenerator::Sitemap.ping_search_engines # called for you when you use the rake task
