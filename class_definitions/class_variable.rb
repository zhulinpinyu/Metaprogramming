class C
  @@v = 1
end

class D < C
  def my_method
    @@v
  end
end

p D.new.my_method

@@v = 3

class MyClass
  @@v = 5
end

p @@v
