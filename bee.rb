class Bee
	# :go_out, :go_in, :wait
	def initialize(fenetre, home_x, home_y)
	  @image = Gosu::Image.new(fenetre, 'media/bee.png')
	  # vx: vitesse en x, dx: destination en x
	  @x = @y = @vx = @vy = @dx = @dy = @angle = 0.0
	  @home_x = home_x
	  @home_y = home_y
	  @task = :waiting
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
	  @angle = Gosu::angle(@x, @y, @dx, @dy)
	  @vx = Gosu::offset_x(@angle, 0.9)
	  @vy = Gosu::offset_y(@angle, 0.9)
	  
	  @x += @vx
	  @y += @vy
	  
	end
	
	def go_out
	  unless @task == :go_out 
	    destination rand($window_width), rand($window_height)
	    @task = :go_out
	  end
	  go_in if arrived?
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
