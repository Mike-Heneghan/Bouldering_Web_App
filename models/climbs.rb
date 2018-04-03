require("pry")

require_relative("../db/sql_runner")

class Climb

  attr_reader :id, :route_id, :climber_id, :attempts_taken, :review

  def initialize( options )
    @id = options['id'].to_i
    @route_id = options['route_id'].to_i
    @climber_id = options['climber_id'].to_i
    @attempts_taken = options['attempts_taken'].to_i
    @review = options['review']

  end

  def save
    sql = "
    INSERT INTO climbs (route_id, climber_id, attempts_taken, review)
    VALUES ($1, $2, $3, $4)
    RETURNING id
    ;"

    values = [@route_id, @climber_id, @attempts_taken, @review]

    result = SqlRunner.run(sql, values)
    @id = result[0]["id"]
  end

  def self.all
    sql = "
    SELECT * FROM climbs
    ;"
    values = []
    result = SqlRunner.run(sql, values)
    climbs_objects = result.map { |climb| Climb.new(climb) }
    return climbs_objects
  end

  def self.find_by_id(id)
    sql = "
    SELECT * FROM climbs
    WHERE id = $1
    ;"

    values = [id]

    result = SqlRunner.run(sql,values)
    climb_object = result.map { |climb| Climb.new(climb)  }
    return climb_object[0]
  end

  def delete
    sql = "
    DELETE FROM climbs
    WHERE id = $1"

    values = [@id]

    SqlRunner.run(sql,values)
  end

  def update()
    sql ="
    UPDATE climbs
    SET (route_id, climber_id, attempts_taken, review) = ($1, $2, $3, $4)
    WHERE id = $5
    ;"

    values = [@route_id, @climber_id, @attempts_taken, @review, @id]
    SqlRunner.run(sql,values)
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
