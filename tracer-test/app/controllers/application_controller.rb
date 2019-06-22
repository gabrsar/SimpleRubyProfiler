class ApplicationController < ActionController::Base

  def index
    should_trace = params[:trace]
    sp = SimpleProfiler.new(should_trace)

    # Simple usage
    sp.start
    x = 4
    Rails.logger.info("some random number = #{x}. choosen by a fair dice roll. guaranteed to be random.")
    sp.stop

    # Simple usage
    sp.start(:math_tables)
    (1..10).each do |t|
      sp.start
      math_table(t)
      sp.stop
    end
    sp.stop(:math_tables)

    # On an expensive task, with detailed steps
    sp.start(:load)
    data = File.read("./examples/big_file.txt")
    sp.stop(:load)

    count = {}
    sp.start(:parse_file)
    data.split('').each do |c|
      occurrences = count[c]
      count[c] = occurrences ? occurrences + 1 : 1
    end
    Rails.logger.info(count)
    sp.stop(:parse_file)

    # SLOWWWW method. Does a lot of things
    sp.start(:slow_method)
    value = compute_important_thing
    Rails.logger.info("response=#{value}")
    sp.stop(:slow_method)


    render json: sp.full_report
  end

  def math_table(n)
    lines = (1..10).map do |i|
      "#{n}x#{i}=#{n * i}"
    end
    lines.join("\n")
  end

  def compute_important_thing
    Rails.logger.info "working hard... please wait."
    sleep 2
    Rails.logger.info "done"
    42
  end
end
