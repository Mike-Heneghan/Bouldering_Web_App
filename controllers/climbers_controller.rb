require("pry-byebug")
require("sinatra")
require("sinatra/contrib/all")

require_relative("../models/climber")

# index
get '/climbers' do
  @climbers = Climber.all()
  erb ( :"climbers/index" )
end

# new
get '/climbers/new' do
  erb ( :"climbers/new")
end

# create
post '/climbers' do
  climber = Climber.new(params)
  climber.save
  redirect to ("/climbers")
end

# show
get '/climbers/:id' do
  @climber = Climber.find_by_id(params['id'].to_i)
  @routes_and_attempts = @climber.find_routes_and_attempts()
  erb ( :"climbers/show" )
end

# delete
post '/climbers/:id/delete' do
  @climber = Climber.find_by_id(params['id'].to_i)
  @climber.delete()
  redirect to ("/climbers")
end

get '/climbers/:id/edit' do
  @climber = Climber.find_by_id(params['id'].to_i)
  erb ( :"climbers/edit")
end

post '/climbers/:id' do
  @climber = Climber.new(params)
  @climber.update()
  redirect to ("/climbers")
end

# | **URL** | **HTTP Verb** |  **Action**|
# |------------|-------------|------------|
# | /photos/         | GET       | index
# | /photos/new         | GET       | new
# | /photos          | POST      | create
# | /photos/:id      | GET       | show
# | /photos/:id/edit | GET       | edit
# | /photos/:id      | PATCH/PUT | update
# | /photos/:id      | DELETE    | destroy
