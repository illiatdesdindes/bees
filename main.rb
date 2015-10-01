require 'rubygems'
require 'gosu'
require './bee'

class Window < Gosu::Window

	def initialize
	  super($window_width, $window_height, false)
	  self.caption = 'Bees foraging simulator'
	  @bg_image = Gosu::Image.new 'media/fond.png'
	  
	  @bees = []
	  10.times do
	    bee = Bee.new self, $hive_x, $hive_y
	    bee.warp $hive_x, $hive_y
	    bee.go_out
	    @bees << bee
	  end
	end
	
	def update
	  @bees.each { |bee| bee.update}
	end
	
	def draw
	  @bg_image.draw 0,0,0
	  @bees.each {|bee| bee.draw}
	end
	
  def button_down(id)
    if id == Gosu::Button::KbEscape
      close
    end
  end
	
end

$window_width, $window_height= 640, 480
$hive_x, $hive_y = $window_width/ 2, $window_height/ 2
window = Window.new
window.show
