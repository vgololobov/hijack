#!/usr/bin/ruby

class MyObject
  def initialize(i)
    @i = i
  end
end

puts Process.pid
n = 10000
loop do
  (n+=1).times {|i| MyObject.new(i)}
  GC.start
end
