# Set Our Root Path
::ROOT = File.dirname( File.expand_path( __FILE__ ) )


use Rack::Static,
  :urls => ["/img", "/js", "/css", "/fonts", "index.html"],
  :root => "public"

run lambda { |env|
  [
    200,
    {
      'Content-Type'  => 'text/html',
      'Cache-Control' => 'public, max-age=86400'
    },
    File.open('public/index.html', File::RDONLY)
  ]
}
#
# # Serve our index file by default
# use Rack::Static , :urls => { "/" => "index.html" } , :root => "public"
#
# # Setup Rack
# run Rack::URLMap.new( {
#   "/"    => Rack::Directory.new( "public" ), # Serve our static content
# } )
