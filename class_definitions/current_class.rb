class C
  def m1
    def m2; end
  end
end

class D < C; end

obj = D.new
p obj.m1 #:m2
p C.instance_methods(false) #[:m1, :m2]
