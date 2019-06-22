class SimpleProfiler

  class Step

    PRECISION = 6

    def initialize(name)

      @name = name
      @caller = SimpleProfiler.get_caller(3)
      @calls = 0
      @time = 0
      @last_start_time = nil
      @last_end_time = nil
      @max = 0
    end

    def name
      @name
    end

    def calls
      @calls
    end

    def caller
      @caller
    end

    def time
      @time
    end

    def start
      @last_start_time = Time.now
      @calls += 1
    end

    def stop
      return unless @last_start_time
      @last_end_time = Time.now
      duration = @last_end_time - @last_start_time
      @time += duration
      @max = duration if duration > @max
      @last_start_time = nil
      @last_end_time = nil
    end

    def report

      name = @name == @caller ? nil : @name
      avg = @calls > 1 ? (@time / @calls).round(PRECISION) : nil
      max = @max if @calls > 1
      calls = @calls > 1 ? @calls : nil

      {
        name: name,
        caller: @caller,
        calls: calls,
        time: @time.round(PRECISION),
        avg: avg,
        max: max
      }.select {|_, v| v}
    end

  end

  def initialize(run = true)
    @@root = Rails.root.to_s
    @run = !!run
    @root = Rails.root.to_s
    @steps = {}
    @stack = []
  end

  def self.get_caller(lvl)
    full_path = caller_locations[lvl]&.to_s || "#{@@root}?"
    full_path = full_path.tr("`'", '')
    full_path.split(@@root)[1]
  end

  def start(step_name_opt = nil)
    return unless @run

    step_name = get_new_name(step_name_opt)
    step = @steps[get_new_name(step_name)] || Step.new(step_name)
    @steps[step_name] = step
    @stack.push(step_name)
    step.start
  end

  def stop(step_name_opt = nil)
    return false unless @run
    step_name = get_name(step_name_opt)
    step = @steps[step_name]
    return false unless step
    step.stop
    @stack.pop
    true
  end

  def report
    return nil unless @run
    {
      steps: @steps.map do |_, v|
        v.stop
        v.report
      end
    }
  end

  private

  def get_new_name(name)
    if name
      name
    else
      SimpleProfiler.get_caller(2)
    end
  end

  def get_name(name)
    if name
      name
    elsif @stack.size > 0
      @stack.last
    else
      nil
    end
  end
end
