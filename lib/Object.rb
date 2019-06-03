require_relative '../lib/Point.rb'
class Object
    attr_accessor :x, :y, :sign, :board
    def initialize(x=0, y=0, sign='0',board=nil)
        if(x<0 || y<0)
            raise ArgumentError, "bad values of initialize"
        end
        @x = x
        @y = y
        @sign = sign
        @board = board
    end
    def GetX
        return @x
    end
    def SetX x
        @x = x
    end
    def GetY
        return @y
    end
    def SetY y
        @y = y
    end
    def GetSign
        return @sign
    end
    def SetSign sign
        @sign = sign
    end
    def SetBoard board
        @board=board
    end
    def GetBoard
        return @board
    end
    def Action
        if (x < 0 || y < 0 || x > @board.GetHeight || y >= @board.GetWidth)
            raise ArgumentError, "bad values of point"
        end
        r=Random.new
        a=r.rand(1..4)
        case a 
            when 1
                if(!(@x<=0))
                    return Point.new(@x-1,@y)
                end
            when 2
                if(!(@y<=0))
                    return Point.new(@x,@y-1)
                end
            when 3
                if(@x+1<@board.GetWidth and @x!=@board.GetWidth)
                    return Point.new(@x+1,@y)
                end
            when 4
                if(@y+1<@board.GetHeight and @y!=@board.GetHeight)
                    return Point.new(@x,@y+1)
                end
        end
    end

end
