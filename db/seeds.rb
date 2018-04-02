require("pry")

require_relative("../models/climber")
require_relative("../models/route")
require_relative("../models/climbs")
require_relative("./sql_runner")

climber1 = Climber.new({'name' => 'Mike', 'profile' => 'Mike is a keen climber of intermediate level keen to improve.'})

climber1.save()
