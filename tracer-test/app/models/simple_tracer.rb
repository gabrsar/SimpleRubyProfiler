class SimpleTracer

  def initialize
    @root = Rails.root.to_s
    @steps = {}
    @start_time = Time.zone.now
    @end_time = nil

  end

  def get_caller(lvl = 2)
    full_path = caller_locations[lvl]&.to_s || 'caller_not_defined'
    full_path.split(@root)[1]
  end

  def step_start(step_name)
    start_time = Time.zone.now
    @steps[step_name] = {
      caller: get_caller(1),
      sequence: @steps.size + 1,
      name: step_name,
      start: start_time
    }
  end

  def step_end(step_name)
    end_time = Time.zone.now
    @end_time = end_time
    step = @steps[step_name]
    unless step
      return false
    end
    step[:end] = end_time

    step[:duration] = time_diff(step[:start], step[:end])
    true
  end

  def step_report(step_name)
    unless @end_time
      @end_time = Time.zone.now
    end
    @steps[step_name]
  end

  def time_diff(start_time, end_time)
    (end_time - start_time).round(4)
  end

  def report
    {
      steps: @steps,
      total_time: time_diff(@start_time, @end_time)
    }
  end
end

