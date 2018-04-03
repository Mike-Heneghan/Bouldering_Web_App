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

  def self.find_by_id(id)
    sql = "
    SELECT * FROM routes
    WHERE id = $1;"

    values = [id]

    result = SqlRunner.run(sql,values)
    route_found = result.map { |route| Route.new(route)}
    return route_found[0]
  end

  def delete
    sql = "
    DELETE FROM routes
    WHERE id = $1"

    values = [@id]

    SqlRunner.run(sql,values)
  end

  def update()
    sql ="
    UPDATE routes
    SET (description, difficulty, hint, img_link) = ($1, $2, $3, $4)
    WHERE id = $5
    ;"

    values = [@description, @difficulty, @hint, @img_link, @id]
    SqlRunner.run(sql,values)
  end

  def find_climbers_and_attempts
    sql = "
    SELECT climbers.id, climbers.name, climbs.attempts_taken, climbs.id as c_id
    FROM climbers INNER JOIN climbs
    ON climbers.id = climbs.climber_id
    WHERE climbs.route_id = $1
    ORDER BY climbs.attempts_taken ASC;"

    values = [@id]

    result = SqlRunner.run(sql,values)

  end

  # def find_routes_and_attempts()
  #   sql = "
  #   SELECT routes.id, routes.description, routes.difficulty, climbs.attempts_taken, climbs.id as c_id
  #   FROM routes INNER JOIN climbs
  #   ON routes.id = climbs.route_id
  #   WHERE climbs.climber_id = $1;"
  #
  #   values = [@id]
  #   result = SqlRunner.run(sql,values)
  #
  # end

end
