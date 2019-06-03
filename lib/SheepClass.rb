require_relative '../lib/AnimalClass.rb'
class Sheep < Animal
    attr_accessor :hadReproduced 
    def initialize(x=0, y=0, sign='0', previous_sign='0',alive=true)
        super(x,y,"s","0")
        @hadReproduced=false
    end
    def GetHadReproduced
        return @hadReproduced
    end
    def SetHadReproduced bool
        @hadReproduced = bool
    end
    def Walking (direction, moveAmount=1)
        if(!(super(direction,moveAmount)))
            if(self.GetBoard.GetSign(direction.GetX,direction.GetY)=='g')
            self.GetBoard.SetSign(self.GetX,self.GetY,self.GetPreviousSign)
            self.GetBoard.SetSign(direction.GetX,direction.GetY,self.GetSign)
            self.SetX(direction.GetX)
            self.SetY(direction.GetY)
                self.EatGrass direction
                self.SetPreviousSign '0'
            end
        end
    end
    def CheckIfCanReproduce (random=true)
        canReproduce=false
        secondSheepPosition=Point.new
        if(!(self.GetX<=0) and self.GetBoard.GetSign(self.GetX-1,self.GetY)=='s')
                canReproduce=true
                secondSheepPosition.SetX(self.GetX-1)
                secondSheepPosition.SetY(self.GetY)
        elsif (!(self.GetY<=0) and self.GetBoard.GetSign(self.GetX,self.GetY-1)=='s')
                canReproduce=true
                secondSheepPosition.SetX(self.GetX)
                secondSheepPosition.SetY(self.GetY-1)
        elsif(self.GetX+1<self.GetBoard.GetWidth and self.GetX!=self.GetBoard.GetWidth and self.GetBoard.GetSign(self.GetX+1,self.GetY)=='s')
                canReproduce=true
                secondSheepPosition.SetX(self.GetX+1)
                secondSheepPosition.SetY(self.GetY)
        elsif (self.GetY+1<self.GetBoard.GetHeight and self.GetY!=self.GetBoard.GetHeight and self.GetBoard.GetSign(self.GetX,self.GetY+1)=='s')
                canReproduce=true
                secondSheepPosition.SetX(self.GetX)
                secondSheepPosition.SetY(self.GetY+1)                
        end
        if(canReproduce and self.GetHadReproduced==false)
            self.SetHadReproduced(true)
            if(self.GetBoard.SearchObjectByClass(secondSheepPosition,Sheep)!=nil)
                self.GetBoard.SearchObjectByClass(secondSheepPosition,Sheep).SetHadReproduced(true)
            end
         if(random==true)
            r=Random.new
            if(r.rand(1..100)>60)
            newSheepPosition=self.CheckForEmptySpace(secondSheepPosition)
            if(newSheepPosition!=nil)
                self.Reproduce(newSheepPosition)
            end
            end
        else
            newSheepPosition=self.CheckForEmptySpace(secondSheepPosition)
            if(newSheepPosition!=nil)
                self.Reproduce(newSheepPosition)
            end
         end
     end
         
    end
    def CheckForEmptySpace secondSheepPosition
        position=nil
        if(!(self.GetX<=0) and self.GetBoard.GetSign(self.GetX-1,self.GetY)=='0')
            position=Point.new(self.GetX-1,self.GetY)
        elsif (!(self.GetY<=0) and self.GetBoard.GetSign(self.GetX,self.GetY-1)=='0')
            position=Point.new(self.GetX,self.GetY-1)
        elsif(self.GetX+1<self.GetBoard.GetWidth and self.GetX!=self.GetBoard.GetWidth and self.GetBoard.GetSign(self.GetX+1,self.GetY)=='0')
            position=Point.new(self.GetX+1,self.GetY)
        elsif (self.GetY+1<self.GetBoard.GetHeight and self.GetY!=self.GetBoard.GetHeight and self.GetBoard.GetSign(self.GetX,self.GetY+1)=='0')
            position=Point.new(self.GetX,self.GetY+1)               
        elsif (!(secondSheepPosition.GetX<=0) and self.GetBoard.GetSign(secondSheepPosition.GetX-1,secondSheepPosition.GetY)=='0')
            position=Point.new(secondSheepPosition.GetX-1,secondSheepPosition.GetY)
        elsif (!(secondSheepPosition.GetY<=0) and self.GetBoard.GetSign(secondSheepPosition.GetX,secondSheepPosition.GetY-1)=='0')
            position=Point.new(secondSheepPosition.GetX,secondSheepPosition.GetY-1)
        elsif (secondSheepPosition.GetX+1<self.GetBoard.GetWidth and secondSheepPosition.GetX!=self.GetBoard.GetWidth and self.GetBoard.GetSign(secondSheepPosition.GetX+1,secondSheepPosition.GetY)=='0')
            position=Point.new(secondSheepPosition.GetX+1,secondSheepPosition.GetY)
        elsif (secondSheepPosition.GetY+1<self.GetBoard.GetHeight and secondSheepPosition.GetY!=self.GetBoard.GetHeight and self.GetBoard.GetSign(secondSheepPosition.GetX,secondSheepPosition.GetY+1)=='0')
            position=Point.new(secondSheepPosition.GetX,secondSheepPosition.GetY+1)
        end
        return position
    end
    def Reproduce newSheepPosition
            sheep = Sheep.new(newSheepPosition.GetX,newSheepPosition.GetY)
            board.AddObject sheep
    end
    def EatGrass direction
        # puts "I ate grass!"
        if(self.GetBoard.SearchObjectByClass(direction,Grass)!=nil)
            self.GetBoard.SearchObjectByClass(direction,Grass).SetHealth(0)
        end
    end
end