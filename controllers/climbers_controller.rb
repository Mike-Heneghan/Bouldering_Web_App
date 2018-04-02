require("pry-byebug")
require("sinatra")
require("sinatra/contrib/all")

require_relative("../models/climber")

get '/climbers' do
  @climbers = Climber.all()
  erb ( :"climbers/index" )
end
