require("pry-byebug")
require("sinatra")
require("sinatra/contrib/all")

require_relative("../models/route")

# index
get '/routes' do
  @routes = Route.all()
  erb ( :"routes/index" )
end
