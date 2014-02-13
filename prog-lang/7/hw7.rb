# University of Washington, Programming Languages, Homework 7, hw7.rb
# (See also ML code.)

# a little language for 2D geometry objects

# each subclass of GeometryExpression, including subclasses of GeometryValue,
#  needs to respond to messages preprocess_prog and eval_prog
#
# each subclass of GeometryValue additionally needs:
#   * shift
#   * intersect, which uses the double-dispatch pattern
#   * intersectPoint, intersectLine, and intersectVerticalLine for 
#       for being called by intersect of appropriate clases and doing
#       the correct intersection calculuation
#   * (We would need intersectNoPoints and intersectLineSegment, but these
#      are provided by GeometryValue and should not be overridden.)
#   *  intersectWithSegmentAsLineResult, which is used by 
#      intersectLineSegment as described in the assignment
#
# you can define other helper methods, but will not find much need to

# Note: geometry objects should be immutable: assign to fields only during
#       object construction

# Note: For eval_prog, represent environments as arrays of 2-element arrays
# as described in the assignment

class GeometryExpression  
  # do *not* change this class definition
  Epsilon = 0.00001
end

class GeometryValue < GeometryExpression
  # do *not* change methods in this class definition
  # you can add methods if you wish

  private
  # some helper methods that may be generally useful
  def real_close(r1,r2) 
      (r1 - r2).abs < GeometryExpression::Epsilon
  end
  def real_close_point(x1,y1,x2,y2) 
      real_close(x1,x2) and real_close(y1,y2)
  end
  # two_points_to_line could return a Line or a VerticalLine
  def two_points_to_line(x1,y1,x2,y2) 
      if real_close(x1,x2)
        VerticalLine.new x1
      else
        m = (y2 - y1).to_f / (x2 - x1)
        b = y1 - m * x1
        Line.new(m,b)
      end
  end
  # returns true if point can be found on line
  def point_on_line?(point,line)
    real_close(line.m * point.x + line.b,point.y)
  end

  public
  # returns true if x is between bounds 
  def inbetween?(x,bound1,bound2)
    (bound1 - Epsilon <= x and x <= bound2 + Epsilon) or
    (bound2 - Epsilon <= x and x <= bound1 + Epsilon)
  end

  # we put this in this class so all subclasses can inherit it:
  # the intersection of self with a NoPoints is a NoPoints object
  def intersectNoPoints np
    np # could also have NoPoints.new here instead
  end

  # we put this in this class so all subclasses can inhert it:
  # the intersection of self with a LineSegment is computed by
  # first intersecting with the line containing the segment and then
  # calling the result's intersectWithSegmentAsLineResult with the segment
  def intersectLineSegment seg
    line_result = intersect(two_points_to_line(seg.x1,seg.y1,seg.x2,seg.y2))
    line_result.intersectWithSegmentAsLineResult seg
  end
end

class NoPoints < GeometryValue
  # do *not* change this class definition: everything is done for you
  # (although this is the easiest class, it shows what methods every subclass
  # of geometry values needs)

  # Note: no initialize method only because there is nothing it needs to do
  def eval_prog env 
    self # all values evaluate to self
  end
  def preprocess_prog
    self # no pre-processing to do here
  end
  def shift(dx,dy)
    self # shifting no-points is no-points
  end
  def intersect other
    other.intersectNoPoints self # will be NoPoints but follow double-dispatch
  end
  def intersectPoint p
    self # intersection with point and no-points is no-points
  end
  def intersectLine line
    self # intersection with line and no-points is no-points
  end
  def intersectVerticalLine vline
    self # intersection with line and no-points is no-points
  end
  # if self is the intersection of (1) some shape s and (2) 
  # the line containing seg, then we return the intersection of the 
  # shape s and the seg.  seg is an instance of LineSegment
  def intersectWithSegmentAsLineResult seg
    self
  end
end


class Point < GeometryValue
  # Note: You may want a private helper method like the local
  # helper function inbetween in the ML code
  attr_reader :x, :y
  def initialize(x,y)
    @x = x
    @y = y
  end

  # *add* methods to this class -- do *not* change given code and do not
  # override any methods
  def eval_prog env 
    self
  end

  def preprocess_prog
    self
  end

  def shift(dx,dy)
    Point.new(x+dx,y+dy)
  end

  def intersect other
    other.intersectPoint(self)
  end

  def intersectPoint p
    if real_close_point(x,y,p.x,p.y) 
      self
    else
      NoPoints.new()
    end
  end

  def intersectLine line
    if point_on_line?(self,line) 
      self 
    else
      NoPoints.new()
    end
  end

  def intersectVerticalLine vline
    # evaluation of a vertical line is no different than a point
    self.intersectPoint(Point.new(vline.x,self.y))
  end

  # if self is the intersection of (1) some shape s and (2) 
  # the line containing seg, then we return the intersection of the 
  # shape s and the seg.  seg is an instance of LineSegment
  # Check that the self (a point) which is on a line coincident with
  # the segment is within the bounds of the segment
  def intersectWithSegmentAsLineResult seg
    x_inbound = inbetween?(x,seg.x1,seg.x2)
    y_inbound = inbetween?(y,seg.y1,seg.y2)
    if (x_inbound and y_inbound)
      self 
    else
      NoPoints.new()
    end
  end
end

class Line < GeometryValue
  # *add* methods to this class -- do *not* change given code and do not
  # override any methods
  attr_reader :m, :b 
  def initialize(m,b)
    @m = m
    @b = b
  end

  def eval_prog env 
    self
  end

  def preprocess_prog
    self
  end

  def shift(dx,dy)
    Line.new(m,b+dy-m*dx)
  end

  def intersect other
    other.intersectLine(self)
  end

  def intersectPoint p
    p.intersectLine(self)
  end

  def intersectLine line
    if (real_close(m,line.m) and real_close(b,line.b)) # coincident lines
      self 
    elsif real_close(m,line.m)                         # parallel lines
      NoPoints.new() 
    else                                               # intersecting lines
      x = (line.b - b)/(m - line.m)
      y = m * x + b 
      Point.new(x,y)
    end
  end

  def intersectVerticalLine vline
    Point.new(vline.x,m*vline.x+b)
  end

  # if self is the intersection of (1) some shape s and (2) 
  # the line containing seg, then we return the intersection of the 
  # shape s and the seg.  seg is an instance of LineSegment
  def intersectWithSegmentAsLineResult seg
    seg 
  end
end

class VerticalLine < GeometryValue
  # *add* methods to this class -- do *not* change given code and do not
  # override any methods
  attr_reader :x
  def initialize x
    @x = x
  end

  def eval_prog env 
    self
  end

  def preprocess_prog
    self
  end

  def shift(dx,dy)
    VerticalLine.new(x+dx)
  end

  def intersect other
    other.intersectVerticalLine(self)
  end

  def intersectPoint p
    p.intersectVerticalLine(self)
  end

  def intersectLine line 
    line.intersectVerticalLine(self)
  end

  def intersectVerticalLine vline
    if real_close(x,vline.x)
      self
    else
      NoPoints.new()
    end
  end

  # if self is the intersection of (1) some shape s and (2) 
  # the line containing seg, then we return the intersection of the 
  # shape s and the seg.  seg is an instance of LineSegment
  def intersectWithSegmentAsLineResult seg
    seg 
  end
end

class LineSegment < GeometryValue
  # *add* methods to this class -- do *not* change given code and do not
  # override any methods
  # Note: This is the most difficult class.  In the sample solution,
  #  preprocess_prog is about 15 lines long and 
  # intersectWithSegmentAsLineResult is about 40 lines long
  attr_reader :x1, :y1, :x2, :y2
  def initialize (x1,y1,x2,y2)
    @x1 = x1
    @y1 = y1
    @x2 = x2
    @y2 = y2
  end

  def eval_prog env 
    self
  end

  def preprocess_prog
    if (real_close_point(x1,y1,x2,y2))
      Point.new(x1,y1)
    else
      x1_big = x1 > x2
      xs_eql = real_close(x1,x2)
      y1_big = y1 - Epsilon > y2
      if (x1_big or (xs_eql and y1_big)) 
        LineSegment.new(x2,y2,x1,y1)
      else
        LineSegment.new(x1,y1,x2,y2) #Is this a trivial case to make a copy
      end
    end
  end

  def shift(dx,dy)
    LineSegment.new(x1+dx,y1+dy,x2+dx,y2+dy)
  end

  def intersect other
    other.intersectLineSegment(self)
  end

  def intersectPoint p
    p.intersectLineSegment self
  end

  def intersectLine line
    line.intersectLineSegment self
  end

  def intersectVerticalLine vline
    vline.intersectLineSegment self 
  end

  # if self is the intersection of (1) some shape s and (2) 
  # the line containing seg, then we return the intersection of the 
  # shape s and the seg.  seg is an instance of LineSegment
  def intersectWithSegmentAsLineResult seg
    if real_close(seg.x1,seg.x2) # invariance enforces that the segments are collinear 
      if (seg.y1 < y1)           # segments on vertical line
        seg_a = seg              # ensures seg_a begins lower than seg_b
        seg_b = self
      else
        seg_a = self
        seg_b = seg
      end

      a_start = seg_a.y1
      a_end = seg_a.y2
      b_start = seg_b.y1
      b_end = seg_b.y2

      if real_close(a_end,b_start)            # segments touch
        Point.new(x,a_end) 
      elsif a_end < b_start                   # disjointed
        NoPoints.new()
      elsif a_end > b_start and b_end < a_end # inside
        seg_b
      else                                    # overlap
        LineSegment.new(x1,b_start,x1,a_end)
      end

    else                                      # both segments are on a non-linear line 
      if (seg.x1 < x1)
        seg_a = seg
        seg_b = self
      else
        seg_a = self
        seg_b = seg
      end

      a_start = seg_a.x1
      a_end = seg_a.x2
      b_start = seg_b.x1
      b_end = seg_b.x2

      if real_close(a_end,b_start)            # segments touch
        Point.new(a_end,seg_a.y2)                                                                 
      elsif a_end < b_start # disjointed      # disjointed
        NoPoints.new()                                                                            
      elsif a_end > b_start and b_end < a_end # inside
        seg_b                                                                                     
      else                                    # overlap
        LineSegment.new(b_start,seg_b.y1,a_end,seg_a.y2)                                          
      end
    end
  end
end

# Note: there is no need for getter methods for the non-value classes

class Intersect < GeometryExpression
  # *add* methods to this class -- do *not* change given code and do not
  # override any methods
  def initialize(e1,e2)
    @e1 = e1
    @e2 = e2
  end

  def eval_prog env 
    e1_eval = @e1.eval_prog env
    e2_eval = @e2.eval_prog env
    e1_eval.intersect(e2_eval)
  end

  def preprocess_prog
    Intersect.new(@e1.preprocess_prog,@e2.preprocess_prog)
  end
end

class Let < GeometryExpression
  # *add* methods to this class -- do *not* change given code and do not
  # override any methods
  def initialize(s,e1,e2)
    @s = s
    @e1 = e1
    @e2 = e2
  end

  def eval_prog env 
    e1_eval = @e1.eval_prog(env)
    new_env = env + [[@s,e1_eval]]
    @e2.eval_prog(new_env)
  end

  def preprocess_prog
    Let.new(@s,@e1.preprocess_prog,@e2.preprocess_prog)
  end
end

class Var < GeometryExpression
  # *add* methods to this class -- do *not* change given code and do not
  # override any methods
  def initialize s
    @s = s
  end
  
  def eval_prog env 
    found = false
    value = NoPoints.new()
    env.each {|val_pair| 
      if (val_pair[0] == @s and !found) 
        value = val_pair[1]
        found = true
      end
    } 
    value
  end

  def preprocess_prog
    self
  end
end

class Shift < GeometryExpression
  # *add* methods to this class -- do *not* change given code and do not
  # override any methods
  def initialize(dx,dy,e)
    @dx = dx
    @dy = dy
    @e = e
  end

  def eval_prog env  
    @e.eval_prog(env).shift(@dx,@dy)
  end

  def preprocess_prog
    Shift.new(@dx,@dy,@e.preprocess_prog)
  end
end
