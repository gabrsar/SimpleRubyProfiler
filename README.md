# Simple Ruby Profiler 
### Simpler than you're lazy
---
## What it does?
It helps you find why your Rails app is terrible slow.

## O_o How do I use it?
```ruby
sp = SimpleProfiler.new
sp.start
slow_method(tons, of, parameters)
sp.stop
puts("report=#{sp.report}")
```
```log
report={:steps=>[{:caller=>"/your_ruby_file.rb:5:in simple_test", :time=>3.141516}]}
```

## Do you have more examples?
Look that from [other example](./examples/example.rb):
![](http://www.gabrielsaraiva.com.br/img/project_aux/SimpleRubyProfiler/example.png)

## WOW. How do I get it?
Copy ![this file](./simple_profiler.rb) into your model folder. Be happy.

## Q&A 
- Wow only one file? - Yep.
- No Gems? - Soon.
- Does it have tests? Not yet. There is a button for Pull Requests up there. Feel free to press it.
- Do you will make tests for it? Yes. Soon.

- Oh. Can I use that in my company project that takes two ages to generate that fucking slow report? - Yep.
- Do I/they need to pay you something? - No.
- Can I change it? - Yep.
- Do I need to put your name on it? - No.
- Do I need to tell someone I'm using it? - Would be nice to make a PR and ask for reviews before put it into production.
- Can I say that I made this to my boss? - No. I made it. You just copied ;)
- Can I say it if I improve this? - You can say you make it better. Feel free to share with me if you want to.
