require_relative 'simple_profiler.rb'

def run_example
  st = SimpleProfiler.new(true)

# Simple usage
  st.start
  x = 4
  puts("some random number = #{x}. choosen by a fair dice roll. guaranteed to be random.")
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
  puts(count)
  st.stop(:parse_file)

# SLOWWWW method. Does a lot of things
  st.start(:slow_method)
  value = compute_important_thing
  puts("response=#{value}")
  st.stop(:slow_method)

  puts st.report

end

def math_table(n)
  lines = (1..10).map do |i|
    "#{n}x#{i}=#{n * i}"
  end
  lines.join("\n")
end

def compute_important_thing
  puts "working hard... please wait."
  sleep 2
  puts "done"
  42
end


run_example
