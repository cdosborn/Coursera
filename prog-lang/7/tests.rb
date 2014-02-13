require_relative './hw7'
puts "hw7 tests"

def real_close(r1,r2)
  (r1-r2).abs < 0.00001
end
def real_close_point(x1,y1,x2,y2)
  real_close(x1,x2) and real_close(y1,y2)
end
puts "Point tests:"
p = Point.new(3.0,1.0).intersect(VerticalLine.new(3.0))
p2 = Point.new(3.0,1.0)
puts real_close_point(p.x,p.y,p2.x,p2.y)

puts "Let tests:"
p = Let.new("test1", Point.new(0.0,1.9),Var.new("test1"))
pt = p.eval_prog([])
p2 = Point.new(0.0,1.9)
puts real_close_point(pt.x,pt.y,p2.x,p2.y)

p = Let.new("a", LineSegment.new(0.0,0.0,0.0,2.0),Intersect.new(Var.new("a"),Point.new(0.0,1.0))).preprocess_prog.eval_prog([])
puts real_close_point(p.x,p.y,0.0,1.0)

