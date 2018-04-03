require("pry-byebug")
require("sinatra")
require("sinatra/contrib/all")

require_relative("../models/route")

# index
get '/routes' do
  @routes = Route.all()
  erb ( :"routes/index" )
end

# create
post '/routes' do
  route = Route.new(params)
  route.save
  redirect to ("/routes")
end

# show
get '/routes/:id' do
  @route = Route.find_by_id(params['id'].to_i)
  @climbers_and_attempts = @route.find_climbers_and_attempts()
  erb ( :"routes/show" )
end

# delete
post '/routes/:id/delete' do
  @route = Route.find_by_id(params['id'].to_i)
  @route.delete()
  redirect to ("/routes")
end

get '/routes/:id/edit' do
  @route = Route.find_by_id(params['id'].to_i)
  erb ( :"routes/edit")
end

post '/routes/:id' do
  @route = Route.new(params)
  @route.update()
  redirect to ("/routes")
end
