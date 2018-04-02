require("pry")

require_relative("../db/sql_runner")

class Climber

  attr_reader :id, :name, :profile

  def initialize( options )
    @id = options['id']
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

end
