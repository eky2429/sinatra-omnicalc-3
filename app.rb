require "sinatra"
require "sinatra/reloader"

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
  erb(:umbrella_results)
end
