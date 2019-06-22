# Simple Ruby Tracer 
### Simpler than you're lazy
---
## What it does?
It helps you find why your Rails app is terrible slow.

## O_o How do I use it?
```ruby
sp = SimpleTracer.new
sp.start
slow_method(tons, of, parameters)
sp.stop
Rails.logger.info("report=#{sp.report}")
```
```log
report={:steps=>[{:caller=>"/app/controllers/some_controller.rb:5:in slow_action", :time=>3.141516}]}
```

## Do you have more examples?
Look that from other example:
[BEAULTIFUL IMAGE HERE]
