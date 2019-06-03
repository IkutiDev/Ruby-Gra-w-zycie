require_relative '../lib/Object.rb'
class Grass < Object
    attr_accessor :health
    def initialize(x=0, y=0, sign='0', health=0)
        super(x,y,"g")
        @health=health
        if(health<=0)
            r=Random.new
            @health = r.rand(1..20).to_i
        end
    end
    def SetHealth health
        @health=health
        if(health<=0)
            self.GetBoard.DeleteTheDead
        end
    end
    def GetHealth
        return @health
    end
    def DecreaseHealth
        @health = health.to_i-1
        self.GetBoard.DeleteTheDead
    end
    def Action
        self.DecreaseHealth
        direction=Point.new
        direction=super
        if(direction!=nil)
         r=Random.new
         if(r.rand(1..100)>60)
            self.Reproduce direction
         end
        end
        return self.GetBoard.GetArray
    end
    def Reproduce direction
        if(self.GetBoard.GetSign(direction.GetX,direction.GetY)=='0')
            grass = Grass.new(direction.GetX,direction.GetY)
            board.AddObject grass
        end
    end
end