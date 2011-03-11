class Bee
	def initialize(fenetre, home_x, home_y)
	  @image = Gosu::Image.new(fenetre, 'media/bee.png')
	  # vx: vitesse en x, dx: destination en x
	  @x = @y = @vx = @vy = @dx = @dy = @angle = 0.0
	  @home_x = home_x
	  @home_y = home_y
	  @task
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
	# :go_out, :go_in, :wait
	def destination(x, y, task)
	  @dx, @dy = x, y
	  @task = task
	end
	
	def destination?
	  if @dx.to_i == @x.to_i and @dy.to_i == @y.to_i then
	    @task = :go_in
	    true
	  else 
	    false
	  end
	end	
	
	def move  
	  @angle = Gosu::angle(@x, @y, @dx, @dy)
	  @vx = Gosu::offset_x(@angle, 0.5)
	  @vy = Gosu::offset_y(@angle, 0.5)
	  
	  @x += @vx
	  @y += @vy
	  
	end
	
	def go_out
	  @dx = rand $window_width
	  @dy = rand $window_height
	end
	
	def go_in
	  destination @home_x, @home_y
	end
	
	def draw
	  @image.draw_rot(@x, @y, 1, @angle)
	end
end
