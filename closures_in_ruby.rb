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


#https://innig.net/software/ruby/closures-in-ruby
######Section Two

example 6

def save_for_later(&b)
  @saved = Proc.new(&b) #same as: @saved = b
end

save_for_later { puts "Hello again." }
@saved.call

example 7

@saved_proc_new = Proc.new { puts "I'm declared on spot with Proc.new" }
@saved_proc_new.call

example 8

@saved_proc_new = Proc.new {puts "I'm declared with Proc.new"}
@saved_proc = proc {puts "I'm declared with proc"}
@saved_lambda = lambda {puts "I'm declared with lambda"}

def some_method
  puts "I'm declared as a method."
end

@method_as_closure = method(:some_method)

@saved_proc_new.call
@saved_proc.call
@saved_lambda.call
@method_as_closure.call


#https://innig.net/software/ruby/closures-in-ruby
###Section Three Closures and Control Flow

example 9

def f(closure)
  puts
  puts "About to call closure"
  result = closure.call
  puts "Closure returned: #{result}"
  "Value from f"
end

puts "f returned: " + f(Proc.new {"Value from Proc.new"})
puts "f returned: " + f(proc {"Value from proc"})
puts "f returned: " + f(lambda {"Value from lambda"})

def another_method
  "Value from method"
end
puts "f returned: " + f(method(:another_method))


example 10

begin
  f(Proc.new{return "Value from Proc.new"})
rescue Exception => e
  puts "Failed with #{e.class}: #{e}"
end

example 11

def g
  result = f(Proc.new{return "Value from Proc.new"})
  puts "f returned: "+ result  #never executed
  "Value from g" #never executed
end

puts "g returned: #{g}"

example 12

def make_proc_new
  begin
    Proc.new {return "Value from Proc.new"}
  ensure
    puts "make_proc_new exited"
  end
end

begin
  puts make_proc_new.call
rescue Exception => e
  puts "Failed with #{e.class}: #{e}"
end

example 13

def g
  result = f(lambda{return "Value from lambda"})
  puts "f returned: " + result
  "Value from g"
end

puts "g returned: #{g}"

example 14

def make_lambda
  begin
    lambda { return "Value from lambda" }
  ensure
    puts "make_lambda exited"
  end
end

puts make_lambda.call

example 15

def g
  result = f(proc{return "Value from proc"})
  puts "f returned: " + result
  "Value from g"
end

puts "g returned: #{g}"

###https://innig.net/software/ruby/closures-in-ruby
###Section 4: Closures and Arity
example 16

puts "One-arg lambda:"
puts lambda{|x|}.arity
puts "Three-arg lambda:"
puts lambda{|x,y,z|}.arity

puts "No-args lambda:"
puts lambda{}.arity
puts "Varargs lambda:"
puts lambda{|*args|}.arity

example 17

def call_with_too_many_args(closure)
  begin
    puts "closure arity: #{closure.arity}"
    closure.call(1,2,3,4,5,6)
    puts "Too many args worked"
  rescue Exception => e
    puts "Too many args threw exception #{e.class}: #{e}"
  end
end

def two_arg_method(x,y)
end

puts; puts "Proc.new:"; call_with_too_many_args(Proc.new{|x,y|})
puts; puts "proc:"; call_with_too_many_args(proc{|x,y|})

#lambda and method 会严格做数据检查
puts; puts "lambda:"; call_with_too_many_args(lambda{|x,y|})
puts; puts "Method:"; call_with_too_many_args(method(:two_arg_method))

def call_with_too_few_args(closure)
  begin
    puts "closure arity: #{closure.arity}"
    closure.call
    puts "Too few args worked"
  rescue Exception => e
    puts "Too few args threw exception #{e.class}: #{e}"
  end
end

puts; puts "Proc.new:"; call_with_too_few_args(Proc.new{|x,y|})
puts; puts "proc:"; call_with_too_few_args(proc{|x,y|})

#lambda and method 会严格做数据检查
puts; puts "lambda:"; call_with_too_few_args(lambda{|x,y|})
puts; puts "Method:"; call_with_too_few_args(method(:two_arg_method))

example 18

def one_arg_method(x)
end

puts; puts "Proc.new:"; call_with_too_many_args(Proc.new{|x|})
puts; puts "proc:"; call_with_too_many_args(proc{|x|})
puts; puts "lambda:"; call_with_too_many_args(lambda{|x|})
puts; puts "Method:"; call_with_too_many_args(method(:one_arg_method))
puts; puts "Proc.new:"; call_with_too_few_args(Proc.new{|x|})
puts; puts "proc:"; call_with_too_few_args(proc{|x|})
puts; puts "lambda:"; call_with_too_few_args(lambda{|x|})
puts; puts "Method:"; call_with_too_few_args(method(:one_arg_method))

example 19

def no_arg_method
end

puts; puts "Proc.new:"; call_with_too_many_args(Proc.new{||})
puts; puts "proc:"; call_with_too_many_args(proc{||})
puts; puts "lambda:"; call_with_too_many_args(lambda{||})
puts; puts "Method:"; call_with_too_many_args(method(:no_arg_method))












