class MyClass < Array
  def my_method
    "Hi"
  end
end

#The Same as

c = Class.new(Array) do
  def my_method
    "Hi"
  end
end

p MyClass.new.my_method #Hi

p c.new.my_method #Hi
p c.name
Mc = c
#匿名class要赋值给常量 否则没有class名称
p Mc.name
