require "sinatra"
require "sinatra/reloader"
require "http"

get("/") do
  "
  <h1>Welcome to your Sinatra App!</h1>
  <p>Define some routes in app.rb</p>
  "
end

get("/umbrella") do
  erb(:umbrella)
end

get("/process_umbrella") do
  @user_location = params.fetch("user_location")

  GMAPS_KEY = ENV.fetch("GMAPS_KEY")
  PIRATE_WEATHER_KEY = ENV.fetch("PIRATE_WEATHER_KEY")

  gmaps_url = "https://maps.googleapis.com/maps/api/geocode/json?address=" + input + "&key=" + GMAPS_KEY
  gmaps_response = HTTP.get(gmaps_url)
  gmaps_info = JSON.parse(gmaps_response)
  @gmaps_loc = gmaps.info.dig("results", 0, "geometry", "location")
  @lat = @gmaps_loc.fetch("lat")
  @lon = @gmaps_loc.fetch("lng")


  pirate_weather_info = JSON.parse(HTTP.get("https://api.pirateweather.net/forecast/#{PIRATE_WEATHER_KEY}/#{latitude},#{longitude}"))
  
latitude = google_maps_info.fetch("lat")
  HTTP.get()
  erb(:umbrella_results)
end
