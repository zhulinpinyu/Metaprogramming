#https://innig.net/software/ruby/closures-in-ruby

######Section One

def example(num)
  puts
  puts "---------Example: #{num}----------"
end

example 1

def thrice
  yield
  yield
  yield
end

x = 5
puts "Before x value: #{x}"  # 5
thrice {x +=1}
puts "After x value: #{x}"   # 8


example 2

def thrice_with_local_x
  x = 100
  yield
  yield
  yield
  puts "thrice_with_local_x local x value #{x}"
end

x = 100
puts "Before x value: #{x}"  # 100
thrice_with_local_x {x +=100}
puts "After x value: #{x}"  # 400


example 3

thrice do
  y = 10
  puts "Is y defined inside the block where it is first set?"
  puts "Yes" if defined? y
end

puts "Is y defined in the outer context after being set in the block?"
puts "No!" unless defined? y

example 4

def six_times(&block)
  thrice(&block)
  thrice(&block)
end

x = 4
six_times {x +=1}
puts "Value of x after: #{x}" #10


example 5

def save_for_later(&b)
  @saved = b
end

save_for_later { puts "Welcome." }
@saved.call  #Welcome.
@saved.call  #Welcome.


######Section Two









