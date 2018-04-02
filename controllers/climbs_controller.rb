require("pry-byebug")
require("sinatra")
require("sinatra/contrib/all")

require_relative("../models/climbs")

# index
get '/climbs' do
  @climbs = Climb.all()
  erb ( :"climbs/index" )
end
