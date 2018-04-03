require("pry-byebug")
require("sinatra")
require("sinatra/contrib/all")

require_relative("../models/climbs")
require_relative("../models/route")
require_relative("../models/climber")

# index
get '/climbs' do
  @climbs = Climb.all()
  erb ( :"climbs/index" )
end

# New
get '/climbs/new' do
  @climbers = Climber.all
  @routes = Route.all
  erb(:"climbs/new")
end

# Create
post '/climbs' do
  climbs = Climb.new(params)
  climbs.save()
  redirect to ("/climbs")
end

# show
get '/climbs/:id' do
  @climb = Climb.find_by_id(params['id'].to_i)
  @route = Route.find_by_id(@climb.route_id)
  @climber = Climber.find_by_id(@climb.climber_id)
  erb ( :"climbs/show" )
end

# delete
post '/climbs/:id/delete' do
  @climb = Climb.find_by_id(params['id'].to_i)
  @climb.delete()
  redirect to ("/climbs")
end

# edit
get '/climbs/:id/edit' do
  @climb = Climb.find_by_id(params['id'].to_i)
  @route = Route.find_by_id(@climb.route_id)
  @climber = Climber.find_by_id(@climb.climber_id)
  @climbers = Climber.all()
  @routes = Route.all()
  erb ( :"climbs/edit")
end

# update
post '/climbs/:id' do
  @climb = Climb.new(params)
  @climb.update()
  redirect to ("/climbs")
end
