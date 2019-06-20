class SimpleProfiler

  class Step
    @@root = nil

    def initialize(name)
      Step.root unless @@root

      @name = name
      @caller = get_caller(3)
      @calls = 0
      @time = 0
      @last_start_time = nil
      @last_end_time = nil
    end

    def self.root
      @@root = Rails.root.to_s
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
      @last_start_time = nil
      @last_end_time = nil
    end

    def report
      {name: @name, caller: @caller, calls: @calls, time: @time.round(6)}
    end

    def get_caller(lvl = 1)
      full_path = caller_locations[lvl]&.to_s || '?'
      full_path.split(@@root)[1]
    end
  end

  def initialize(run = true)
    @run = !!run
    @root = Rails.root.to_s
    @steps = {}
  end


  def start(step_name)
    return unless @run
    step = @steps[step_name] || Step.new(step_name)
    step.start
    @steps[step_name] = step
  end

  def stop(step_name)
    return false unless @run
    step = @steps[step_name]
    return false unless step
    step.stop
    true
  end


  def simple_report
    return nil unless @run
    steps = @steps.to_a
    fastest = slowest = hottest = steps[0][1]

    @steps.each do |_, v|
      slowest = v if v.time > slowest.time
      fastest = v if v.time < fastest.time
      hottest = v if v.calls > hottest.calls
    end

    {
      fastest: fastest.name,
      slowest: slowest.name,
      hottest: hottest.name
    }
  end


  def full_report

    return nil unless @run

    {
      steps: @steps.map {|_, v| v.report}
    }

  end

end
