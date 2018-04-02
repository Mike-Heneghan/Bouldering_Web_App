require("pry")

require_relative("../db/sql_runner")

class Route

  attr_reader :id, :description, :difficulty, :hint, :img_link

  def initialize( options )
    @id = options['id'].to_i
    @description = options['description']
    @difficulty = options['difficulty'].to_i
    @hint = options['hint']
    @img_link = options['img_link']

  end

  def save
    sql = "
    INSERT INTO routes (description, difficulty, hint, img_link)
    VALUES ($1, $2, $3, $4)
    RETURNING id
    ;"

    values = [@description, @difficulty, @hint, @img_link]

    result = SqlRunner.run(sql, values)
    @id = result[0]["id"]
  end

  def self.all
    sql = "
    SELECT * FROM routes
    ;"
    values = []
    result = SqlRunner.run(sql, values)
    route_objects = result.map { |route| Route.new(route) }
    return route_objects
  end

end
