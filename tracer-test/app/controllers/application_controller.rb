class ApplicationController < ActionController::Base

  def xoxo
    st = SimpleProfiler.new
    st.start
    sleep(3.141516)
    st.stop
    Rails.logger.info("why my thing is slow: report=#{st.report}")
    render json: {}
  end

  def index
    should_trace = params[:trace]
    st = SimpleProfiler.new(should_trace)

    # Simple usage
    st.start
    x = 4
    Rails.logger.info("some random number = #{x}. choosen by a fair dice roll. guaranteed to be random.")
    st.stop

    # Simple usage
    st.start(:math_tables)
    (1..10).each do |t|
      st.start
      math_table(t)
      st.stop
    end
    st.stop(:math_tables)

    # On an expensive task, with detailed steps
    st.start(:load_file)
    data = File.read("./examples/big_file.txt")
    st.stop(:load_file)

    count = {}
    st.start(:parse_file)
    data.split('').each do |c|
      occurrences = count[c]
      count[c] = occurrences ? occurrences + 1 : 1
    end
    Rails.logger.info(count)
    st.stop(:parse_file)

    # SLOWWWW method. Does a lot of things
    st.start(:slow_method)
    value = compute_important_thing
    Rails.logger.info("response=#{value}")
    st.stop(:slow_method)


    render json: st.report
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
