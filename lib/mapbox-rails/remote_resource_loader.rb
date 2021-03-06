require 'thor'

class RemoteResourceLoader < Thor
  include Thor::Actions

  desc 'fetch source files', 'fetch source files from the MapBox S3 storage'
  def fetch
    self.destination_root = 'vendor/assets'
    get "http://api.tiles.mapbox.com/mapbox.js/v1.6.1/mapbox.uncompressed.js", "javascripts/mapbox.js"
    get "http://api.tiles.mapbox.com/mapbox.js/v1.6.1/mapbox.css", "stylesheets/mapbox.css"
    get "http://api.tiles.mapbox.com/mapbox.js/v1.6.1/images/layers.png", "images/layers.png"
    get "http://api.tiles.mapbox.com/mapbox.js/v1.6.1/images/marker-icon.png", "images/marker-icon.png"
    get "http://api.tiles.mapbox.com/mapbox.js/v1.6.1/images/marker-shadow.png", "images/marker-shadow.png"
    get "http://api.tiles.mapbox.com/mapbox.js/v1.6.1/images/icons-000000.png", "images/icons-000000.png"
    get "http://api.tiles.mapbox.com/mapbox.js/v1.6.1/images/icons-ffffff.png", "images/icons-ffffff.png"
    get "http://api.tiles.mapbox.com/mapbox.js/v1.6.1/images/icons-000000@2x.png", "images/icons-000000@2x.png"
    get "http://api.tiles.mapbox.com/mapbox.js/v1.6.1/images/icons-ffffff@2x.png", "images/icons-ffffff@2x.png"
  end

  desc 'convert css to scss file', 'convert css to scss file by sass-convert'
  def convert
    self.destination_root = 'vendor/assets'
    inside destination_root do
      run('sass-convert -F css -T scss stylesheets/mapbox.css stylesheets/mapbox.css.scss')
      gsub_file 'stylesheets/mapbox.css.scss', 'url(./images/icons-000000.png)', 
        "image-url('icons-000000.png')"
      gsub_file 'stylesheets/mapbox.css.scss', 'url(./images/icons-ffffff.png)', 
        "image-url('icons-ffffff.png')"
      gsub_file 'stylesheets/mapbox.css.scss', 'url(./images/icons-000000@2x.png)', 
        "image-url('icons-000000@2x.png')"
      gsub_file 'stylesheets/mapbox.css.scss', 'url(./images/icons-ffffff@2x.png)', 
        "image-url('icons-ffffff@2x.png')"
    end
  end

  desc 'clean up useless files', 'clean up useless files'
  def cleanup
    self.destination_root = 'vendor/assets'
    remove_file 'stylesheets/mapbox.css'
  end
end
