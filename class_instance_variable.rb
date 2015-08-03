class MyClass
  # class instance variable
  @my_var = 1
  
  def self.read
    @my_var
  end

  def write
    #instance variable
    @my_var = 2
  end

  def read
    #instance variable
    @my_var
  end
end

p MyClass.read
#改变类实例变量
MyClass.instance_eval { @my_var = 100 }
p MyClass.read

p "---" * 10

obj = MyClass.new
p obj.read
  obj.write
p obj.read