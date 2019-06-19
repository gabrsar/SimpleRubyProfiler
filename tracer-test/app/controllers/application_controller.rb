class ApplicationController < ActionController::Base

  def index

    t = SimpleTracer.new

    t.step_start("loading")
    a = 0
    (1..100).each do |i|
      (1..i).each do |_|
        a = a + 1
      end
      a = 0
    end
    t.step_end("loading")

    t.step_start(:slow_method)
    some_method()
    t.step_end(:slow_method)

    logger.info(t.report.to_json)

    render json: {response: 'oi'}
  end

  def some_method
    p "start sleep"
    sleep 3
    p "end sleep"
  end
end
