
require 'gosu'
require './bee'

class Window < Gosu::Window

	def initialize
	  super($window_width, $window_height, false)
	  self.caption = 'Bees foraging simulator'
	  @bee = Bee.new self, $hive_x, $hive_y
	  @bee.warp $hive_x, $hive_y
	end
	
	def update
	  @bee.go_out
	  @bee.move
	end
	
	def draw
	  @bee.draw
	end
	
end

$window_width, $window_height= 640, 480
$hive_x, $hive_y = $window_width/ 2, $window_height/ 2
window = Window.new
window.show
