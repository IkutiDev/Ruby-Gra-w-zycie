require_relative '../lib/Object.rb'
class Animal < Object
    attr_accessor :previous_sign,:alive
    def initialize(x=0, y=0, sign='0', previous_sign='0',alive=true)
        super(x,y)
        @sign = sign
        @previous_sign=previous_sign
    end
    def SetPreviousSign sign
        @previous_sign=sign
    end
    def GetPreviousSign
        return @previous_sign
    end
    def SetAlive bool
        @alive=bool
        if(bool==false)
            self.GetBoard.DeleteTheDead
        end
    end
    def GetAlive
        return @alive
    end
    def Walking (direction,moveAmount=1)
        #print direction.GetX.to_s+ " "+direction.GetY.to_s+" "+self.to_s+"\n"
        completed=false
        if(self.GetBoard.GetSign(direction.GetX,direction.GetY)=='0')
            if(self.GetPreviousSign=='0')
                # puts "I was standing on ground"
            elsif(self.GetPreviousSign=='g')
                # puts "I was standing on grass"
            end
            self.GetBoard.SetSign(self.GetX,self.GetY,self.GetPreviousSign)
            self.GetBoard.SetSign(direction.GetX,direction.GetY,self.GetSign)
            self.SetX(direction.GetX)
            self.SetY(direction.GetY)
            self.SetPreviousSign('0')
            completed=true
        elsif (board.GetSign(direction.GetX,direction.GetY)=='l')
            self.SetAlive(false)
            #print self.GetPreviousSign
            self.GetBoard.SetSign(self.GetX,self.GetY,self.GetPreviousSign)
            self.GetBoard.DeleteTheDead
            completed=true
        end
        return completed
    end
    def Action
        direction=Point.new
        direction=super()
        if(direction!=nil)
            self.Walking(direction)
        end
        return self.GetBoard.GetArray
    end
end