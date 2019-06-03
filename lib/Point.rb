class Point
    attr_accessor :x,:y
    def initialize(x=0, y=0)
        if(x < 0 || y < 0 )
            raise ArgumentError, "bad values"
        end
        @x = x
        @y = y
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
end