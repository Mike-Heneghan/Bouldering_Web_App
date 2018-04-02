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

end
