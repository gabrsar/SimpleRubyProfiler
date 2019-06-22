# Simple Ruby Profiler 
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
Look that from [other example](https://github.com/gabrsar/SimpleRubyTracer/blob/master/tracer-test/app/controllers/application_controller.rb):
![](https://github.com/gabrsar/SimpleRubyTracer/blob/master/tracer-test/github_images/example.png)

## WOW. How do I get it?
Copy ![this file](https://github.com/gabrsar/SimpleRubyTracer/blob/master/tracer-test/app/models/simple_profiler.rb) into your model folder. Be happy.

## Q&A
- Can you please stick to a pattern? Tracer or Profiler? - Soon. I'm still deciding. 
- Wow only one file? - Yep.
- No Gems? - No. We're lazy remember?
- Does it have tests? Not yet. There is a button for Pull Requests up there. Feel free to press it.
- Do you will make tests for it? Yes. Soon.

- Oh. Can I use that in my company project that takes two ages to generate that fucking slow report? - Yep.
- Do I/they need to pay you something? - No.
- Can I change it? - Yep.
- Do I need to put your name on it? - No.
- Do I need to tell someone I'm using it? - Would be nice to make a PR and ask for reviews before put it into production.
- Can I say that I made this to my boss? - No. I made it. You just copied ;)
- Can I say it if I improve this? - You can say you make it better. Feel free to share with me if you want to.
