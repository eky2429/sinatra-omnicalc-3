require "sinatra"
require "sinatra/reloader"
require "http"

get("/") do
  "
  <h1>Welcome to Omnicalc 3!</h1>
  "
end

get("/umbrella") do
  erb(:umbrella)
end

post("/process_umbrella") do
  @user_location = params.fetch("user_location")
  input = @user_location.gsub(" ", "+")

  GMAPS_KEY = ENV.fetch("GMAPS_KEY")
  PIRATE_WEATHER_KEY = ENV.fetch("PIRATE_WEATHER_KEY")

  gmaps_url = "https://maps.googleapis.com/maps/api/geocode/json?address=#{input}&key=#{GMAPS_KEY}"
  gmaps_response = HTTP.get(gmaps_url)
  gmaps_info = JSON.parse(gmaps_response)
  gmaps_loc = gmaps_info.dig("results", 0, "geometry", "location")
  @lat = gmaps_loc.fetch("lat")
  @lon = gmaps_loc.fetch("lng")

  pweather_url = "https://api.pirateweather.net/forecast/#{PIRATE_WEATHER_KEY}/#{@lat},#{@lon}"
  pweather_response = HTTP.get(pweather_url)
  pweather_info = JSON.parse(pweather_response)
  @cur_temp = pweather_info.dig("currently", "temperature")
  @cur_summ = pweather_info.dig("currently", "summary")
  precip_perc = pweather_info.dig("currently", "precipProbability")
  precip_prob = (precip_perc * 100).round
  if precip_prob >= 10
    @message = "You might want to take an umbrella!"
  else
    @message = "You probably won't need an umbrella."
  end

  erb(:umbrella_results)
end

get("/message") do
  erb(:message)
end

get("/chat") do
  erb(:chat)
end
