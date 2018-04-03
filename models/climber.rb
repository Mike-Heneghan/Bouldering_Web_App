require("pry")

require_relative("../db/sql_runner")
require_relative("../models/climbs")
require_relative("../models/route")


class Climber

  attr_reader :id, :name, :profile

  def initialize( options )
    @id = options['id'].to_i
    @name = options['name']
    @profile = options['profile']

  end

  def save
    sql = "
    INSERT INTO climbers (name, profile)
    VALUES ($1, $2)
    RETURNING id
    ;"

    values = [@name, @profile]

    result = SqlRunner.run(sql, values)
    @id = result[0]["id"]
  end

  def self.all
    sql = "
    SELECT * FROM climbers
    ;"
    values = []
    result = SqlRunner.run(sql, values)
    climber_objects = result.map { |climber| Climber.new(climber) }
    return climber_objects
  end

  def self.find_by_id(id)
    sql = "
    SELECT * FROM climbers
    WHERE id = $1;"

    values = [id]

    result = SqlRunner.run(sql,values)
    climber_found = result.map { |climber| Climber.new(climber)}
    return climber_found[0]
  end

  def delete
    sql = "
    DELETE FROM climbers
    WHERE id = $1"

    values = [@id]

    SqlRunner.run(sql,values)
  end

  def update()
    sql ="
    UPDATE climbers
    SET (name, profile) = ($1, $2)
    WHERE id = $3
    ;"

    values = [@name, @profile, @id]
    SqlRunner.run(sql,values)
  end

  def find_routes_and_attempts()
    sql = "
    SELECT routes.id, routes.description, routes.difficulty, climbs.attempts_taken, climbs.id as c_id
    FROM routes INNER JOIN climbs
    ON routes.id = climbs.route_id
    WHERE climbs.climber_id = $1;"

    values = [@id]
    result = SqlRunner.run(sql,values)

  end

  # def find_climbs()
  #   sql = "
  #   SELECT * FROM climbs
  #   WHERE climber_id = $1"
  #
  #   values = [@id]
  #
  #   result = SqlRunner.run(sql,values)
  #   climbs_objects = result.map { |climb| Climb.new(climb)  }
  #   return climb_objects
  # end


end
