require_relative '../lib/AnimalClass.rb'
class Wolf < Animal
    def initialize(x=0, y=0, sign='0', previous_sign="0",alive=true)
        super(x,y,"w","0")
    end
    def Walking (direction, moveAmount=1)
        if(!(super(direction,moveAmount)))
            if(self.GetBoard.GetSign(direction.GetX,direction.GetY)=='g')
                # puts "I stood on grass!"
            self.GetBoard.SetSign(self.GetX,self.GetY,self.GetPreviousSign)
            self.GetBoard.SetSign(direction.GetX,direction.GetY,self.GetSign)
            self.SetX(direction.GetX)
            self.SetY(direction.GetY)

            self.SetPreviousSign 'g'
            end
            if(self.GetBoard.GetSign(direction.GetX,direction.GetY)=='s')
            self.GetBoard.SetSign(self.GetX,self.GetY,self.GetPreviousSign)
            self.GetBoard.SetSign(direction.GetX,direction.GetY,self.GetSign)
            self.SetX(direction.GetX)
            self.SetY(direction.GetY)
            self.EatSheep direction
            self.SetPreviousSign '0'
            end
        end
    end
    def EatSheep direction
        # puts "I ate sheep!"
        if(self.GetBoard.SearchObjectByClass(direction,Sheep)!=nil)
            self.GetBoard.SearchObjectByClass(direction,Sheep).SetAlive(false)
        end
    end
end