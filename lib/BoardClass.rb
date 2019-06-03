require_relative '../lib/WolfClass.rb'
require_relative '../lib/SheepClass.rb'
require_relative '../lib/GrassClass.rb'
require_relative '../lib/LakeClass.rb'
require 'io/console'
# kolorowanie składani przy wyświetlaniu
# class String
#   # colorization
#   def colorize(color_code)
#     "\e[#{color_code}m#{self}\e[0m"
#   end
#   def white
#     colorize(1)
#   end
#   def blue
#     colorize(34)
#   end
#   def green
#     colorize(32)
#   end
#   def red
#     colorize(31)
#   end
# end
class Board < Object
    attr_accessor :height, :width, :arr, :object_list
    def LoadFromFile file_name
        if(!(File.file?(file_name)))
            raise ArgumentError, "incorrect name of file" 
        end
        self.CheckSize file_name
        height = self.GetHeight
        width = self.GetWidth
        self.CreateEmpty height,width
        file = File.open(file_name, "r") 
        for i in 0..height-1
            line = file.gets
            for j in 0..width-1
                case line[j]
                when "w"
                    wolf = Wolf.new(i,j)
                    self.AddObject wolf
                when "s" 
                    sheep = Sheep.new(i,j)
                    self.AddObject sheep
                when "g" 
                    grass = Grass.new(i,j)
                    self.AddObject grass
                when "l"
                    lake = Lake.new(i,j)
                    self.AddObject lake
                end
            end
        end
        file.close()
        self.GetBoard
    end

    # def Print
    #     height = self.GetHeight
    #     #puts height
    #     width = self.GetWidth
    #     #puts width
    #     for i in 0..height-1
    #         for j in 0..width-1
    #             if(@arr[i][j] == "0")
    #                 print(". ")
    #             else
    #                 if @arr[i][j]=="g"
    #                     print(@arr[i][j].green + ' ')
    #                 elsif @arr[i][j]=="s"
    #                     print(@arr[i][j].white + ' ')
    #                 elsif @arr[i][j]=="l"
    #                     print(@arr[i][j].blue + ' ')
    #                 elsif @arr[i][j]=="w"
    #                     print(@arr[i][j].red + ' ')
    #                 else
    #                     print(@arr[i][j] + ' ')
    #                 end
                    
    #             end
    #         end
    #         print("\n")
    #     end
    # end

    def AddObject object
        x = object.GetX
        y = object.GetY
        sign = object.GetSign
        height = self.GetHeight
        width = self.GetWidth
        object.SetBoard(self)
        if (x < 0 || x > height || y < 0 || y > width)
            raise ArgumentError, "beyond the board" 
        elsif self.GetSign(x,y) != "0"
            raise ArgumentError, "occupied field"
        end
        @arr[x][y] = sign
        if(sign=="w" || sign=="s" || sign=="g")
            @object_list.push(object)
        end
    end

    def CreateEmpty height, width
        if(width<=0 || height<=0)
            raise ArgumentError, "Wrong board size!"
        end 
        if height != width
            raise ArgumentError, "board is not square!"
        end
        self.SetHeight height
        self.SetWidth width
        @arr = Array.new(height) {Array.new(width)}
        @object_list = []
        for i in 0..height-1
            for j in 0..width-1
                object = Object.new(i,j)
                @arr[i][j] = '0'
                self.AddObject object
            end
        end
    end
    def SetSign x,y,sign
        @arr[x][y]=sign
    end
    def GetSign x, y
        return @arr[x][y]
    end
    def GetArray
        return @arr
    end

    def AddRandomObject
        # 1 - wolf, 2 - sheep, 3 - grass, 4 - lake
        r = Random.new
        a = r.rand(1..4)
        height = self.GetHeight - 1
        width = self.GetWidth - 1
        counter = 0
        begin
            x = r.rand(0..height)
            y = r.rand(0..width)
            counter += 1
            if counter > 20
                for i in 0..height
                    for j in 0..width
                        if self.GetSign(i,j) == "0"
                            x = i
                            y = j
                            break
                        end
                    end
                end
            end
        end while self.GetSign(x,y) != "0"
        case a
        when 1
            wolf = Wolf.new(x,y)
            self.AddObject wolf
        when 2 
            sheep = Sheep.new(x,y)
            self.AddObject sheep
        when 3 
            grass = Grass.new(x,y)
            self.AddObject grass
        when 4
            lake = Lake.new(x,y)
            self.AddObject lake
        end
    end
    def GetObjectList
        return @object_list
    end
    def SetHeight height
        @height = height
    end
    def GetHeight
        return @height
    end
    def SetWidth width
        @width = width
    end
    def GetWidth
        return @width
    end
    def SearchObject direction
        objectFound=nil
        for i in 0..object_list.length-1
            if(object_list[i].GetX==direction.GetX and object_list[i].GetY==direction.GetY)
                objectFound=object_list[i]
                break
            end
        end
        return objectFound
    end
    def SearchObjectByClassYN direction,objectName
        found=false
        for i in 0..object_list.length-1
            if(object_list[i].GetX==direction.GetX and object_list[i].GetY==direction.GetY and object_list[i].class==objectName)
                found=true
                break
            end
        end
        return found
    end
    def SearchObjectByClass direction,objectName
        objectFound=nil
        for i in 0..object_list.length-1
            if(object_list[i].GetX==direction.GetX and object_list[i].GetY==direction.GetY and object_list[i].class==objectName)
                objectFound=object_list[i]
                break
            end
        end
        return objectFound
    end
    def CheckSize file_name
        height = 0
        file = File.open(file_name, "r") 
        while(line = file.gets) do
            line = line.gsub(/[\n]/, '')
            height += 1
            width = line.length
        end
        file.close()
        if height != width
            raise ArgumentError, "board is not square!"
        end
        self.SetHeight height
        self.SetWidth width
    end
    def TurnByInt int
        for i in 0..int.to_i-1
            self.Turn i
        end
    end

    # dodatkowe opcje tury, z których można skorzystać
    # def TurnByTime (int,time=1.0)
    #     for i in 0..int.to_i-1
    #         self.Turn i
    #         t1 = Time.now
    #         if i<int.to_i-1
    #         begin
    #             t2 = Time.now
    #             delta = t2 - t1
    #         end while delta < time
    #     end
    #     end
    # end
    # def TurnByButton(nextTurnButton=27,endProgramButton=13)
    #     i=0
    #     endProgram=false
    #     until endProgram==true do
    #         input = STDIN.getch
    #         if input.ord==endProgramButton
    #             self.Turn i
    #         elsif input.ord==nextTurnButton
    #             endProgram=true
    #         else
    #             puts input.ord
    #         end
    #         i=i+1
    #     end
    # end
    def DeleteTheDead
        for i in 0..object_list.length-1
            if( @object_list[i].class==Grass)
                if(@object_list[i].health<=0)
                    if(arr[@object_list[i].GetX][@object_list[i].GetY]=='g')
                    arr[@object_list[i].GetX][@object_list[i].GetY]='0'
                end
                if(arr[@object_list[i].GetX][@object_list[i].GetY]=='w')
                    if(SearchObjectByClass(Point.new(@object_list[i].GetX,@object_list[i].GetY),Wolf)!=nil)
                        SearchObjectByClass(Point.new(@object_list[i].GetX,@object_list[i].GetY),Wolf).SetPreviousSign('0')
                    end
                end
                    @object_list.delete_at(i)
                end
            elsif (@object_list[i].class==Sheep or @object_list[i].class==Wolf)
                if(@object_list[i].alive==false)
                @object_list.delete_at(i)
            end
            end
        end
    end

    # dodatkowa opcja wypisywania wykorzystywana tylko przy tworzeniu gry
    # def DebugPrint
    #     for i in 0..height-1
    #         for j in 0..width-1
    #             if(SearchObjectByClass(Point.new(i,j),Wolf)!=nil)
    #                 print SearchObjectByClass(Point.new(i,j),Wolf).to_s + " " + i.to_s + " " + j.to_s + "\n"
    #             end
    #         end
    #     end
    #     for i in 0..height-1
    #         for j in 0..width-1
    #             if(SearchObjectByClass(Point.new(i,j),Grass)!=nil)
    #                 print SearchObjectByClass(Point.new(i,j),Grass).to_s + " " + i.to_s + " " + j.to_s + "\n"
    #                 puts SearchObjectByClass(Point.new(i,j),Grass).health
    #             end
    #         end
    #     end
    #     for i in 0..height-1
    #         for j in 0..width-1
    #             if(SearchObjectByClass(Point.new(i,j),Sheep)!=nil)
    #                 print SearchObjectByClass(Point.new(i,j),Sheep).to_s + " " + i.to_s + " " + j.to_s + "\n"
    #             end
    #         end
    #     end
    # end
    def Turn counter
        grassCounter=0
        wolfCounter=0
        sheepCounter=0
        for i in 0..object_list.length-1#Action of resetting sheep status
            if(@object_list[i]!=nil and @object_list[i].class==Sheep)
               @object_list[i].SetHadReproduced(false) 
            end
        end
        for i in 0..object_list.length-1#Action of moving and eating and grass reproducing
            if(@object_list[i]!=nil)
            @arr = @object_list[i].Action
            if(@object_list[i].class==Grass)
                grassCounter=grassCounter+1
            end
            if(@object_list[i].class==Wolf)
                wolfCounter=wolfCounter+1
            end
            if(@object_list[i].class==Sheep)
                sheepCounter=sheepCounter+1
            end
        end
        end
        for i in 0..object_list.length-1 #Action of sheep reproducing and wolf eating sheeps near him
            if(@object_list[i]!=nil and @object_list[i].class==Sheep)
               @object_list[i].CheckIfCanReproduce 
            end
        end
        
        # self.Print
    end
end
