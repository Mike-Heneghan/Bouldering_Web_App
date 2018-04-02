require("pry-byebug")
require("sinatra")
require("sinatra/contrib/all")

require_relative("../models/climber")

# index
get '/climbers' do
  @climbers = Climber.all()
  erb ( :"climbers/index" )
end
#
# # new
# get '/climbers/new' do
#   erb ( :"climbers/new")
# end
#
# # create
# post '/climbers' do
#
# end
