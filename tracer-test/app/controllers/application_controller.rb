class ApplicationController < ActionController::Base

  def index

    sp = SimpleProfiler.new(params[:trace])

    sp.start("loading")
    a = 0
    (1..100).each do |i|
      sp.start(:inner_i)
      (1..i).each do |j|
        a = a + 1
      end
      a = 0
      sp.stop(:inner_i)
    end
    sp.stop("loading")

    sp.start("sleep")
    some_method()
    sp.stop("sleep")

    report = sp.full_report

    p "REPORT:"
    p report.to_json

    render json: report
  end

  def some_method
    p "zzzZZZzzz"
    sleep 1
    p "wake me up when tests ends..."
  end
end
