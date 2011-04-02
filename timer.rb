class Timer
  def initialize task_time, step_time
    @task_time = task_time * 1000
    @step_time = step_time * 1000
    @task_timer
    @step_timer
  end
  
  def start
    @task_timer = @task_time + Gosu::milliseconds
    @step_timer = @step_time + Gosu::milliseconds
  end
  
  def finish?
    @task_timer < Gosu::milliseconds
  end
  
  def next?
    if @step_timer < Gosu::milliseconds
      @step_timer = @step_time + Gosu::milliseconds
      return true
    end
    false
  end
end
