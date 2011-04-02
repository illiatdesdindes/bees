require './timer'

class Bee
	# :go_out, :go_in, :wait
	def initialize(window, home_x, home_y)
	  @image = Gosu::Image.new(window, 'media/bee.png')
	  # vx: vitesse en x, dx: destination en x
	  @x = @y = @vx = @vy = @dx = @dy = @angle = 0.0
	  @home_x = home_x
	  @home_y = home_y
	  @task = :waiting
	  @timer = Timer.new 6, 1
	end
	
	def update
	  new_task if @task == :waiting
	  send @task
	  move
	end
	
	def warp(x, y)
	  @x, @y = x, y
	end
	
	def task (task)
	  @task = task
	end
	
	def task
	  @task
	end
	
	def new_task
	
	end
	
	def destination(x, y)
	  @dx, @dy = x, y
	  @angle = Gosu::angle(@x, @y, @dx, @dy)
	end
	
	def rand_direction
	  # la direction est prise suivant une courbe de chance de type x-cube
	  x = (rand) * 2 - 1
	  x3 = x*x*x
	  @angle += x3 * 180
	end
	
	def arrived?
	  #if @dx.to_i == @x.to_i and @dy.to_i == @y.to_i then
	  if Gosu::distance(@x,@y, @dx,@dy) < 1.0
	    true
	  else 
	    false
	  end
	end	
	
	def move  
	  #@angle = Gosu::angle(@x, @y, @dx, @dy)
	  @vx = Gosu::offset_x(@angle, 0.9)
	  @vy = Gosu::offset_y(@angle, 0.9)
	  
	  @x += @vx
	  @y += @vy
	  @x = @x % $window_width
	  @y = @y % $window_height
	  
	end
	
	def go_out
	  unless @task == :go_out 
	    #destination rand($window_width), rand($window_height)
	    @angle = rand 360
	    @timer.start
	    @task = :go_out
	  end
	  rand_direction if @timer.next?
	  go_in if @timer.finish?
	end
	
	def go_in
	  unless @task == :go_in
	    destination @home_x, @home_y 
	    @task = :go_in
	  end
	  go_out if arrived?
	end
	
	def draw
	  @image.draw_rot(@x, @y, 1, @angle)
	end
end
