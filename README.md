# Simple Ruby Tracer 
### Simpler than you're lazy
---
## What it does?
It helps you find why your Rails app is terrible slow.

## O_o How do I use it?
```ruby
st = SimpleTracer.new
st.start
slow_method(tons, of, parameters)
st.stop
Rails.logger.info("report=#{st.report}")
```
```log
report={:steps=>[{:caller=>"/app/controllers/some_controller.rb:5:in slow_action", :time=>3.141516}]}
```

## Do you have more examples?
Look that from other example:
[BEAULTIFUL IMAGE HERE]
