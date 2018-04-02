require("pry")

require_relative("../models/climber")
require_relative("../models/route")
require_relative("../models/climbs")
require_relative("./sql_runner")

climber1 = Climber.new({'name' => 'Mike', 'profile' => 'Mike is a keen climber of intermediate level keen to improve.'})

climber1.save()

route1 = Route.new({
  'description' => 'Pink Overhang',
  'difficulty' => '4',
  'hint' => 'Try dropping left knee on lowest hold.',
  'img_link' => 'public'
  })

route1.save()

climb1 = Climb.new({
  'route_id' => route1.id,
  'climber_id' => climber1.id,
  'attempts_taken' => '7',
  'review' => 'The route was harder than expected. Great dyno midway though.'
  })

climb1.save()
