require_relative '../lib/BoardClass'
require_relative '../lib/Point'
require 'minitest/spec'
require 'minitest/autorun'

class TestSheep < Minitest::Test
    describe 'sheep tests with minitest' do
        before do
            @board = Board.new
        end

        after do
            @board = nil
        end
        it 'set and get reproduced - true' do
            sheep = Sheep.new(0,0)
            sheep.SetHadReproduced true
            (sheep.GetHadReproduced).must_equal true
        end
    
        it 'set and get reproduced - true neg' do
            sheep = Sheep.new(0,0)
            sheep.SetHadReproduced true
            (sheep.GetHadReproduced).wont_equal false
        end
    
        it 'set and get reproduced - false' do
            sheep = Sheep.new(0,0)
            sheep.SetHadReproduced false
            (sheep.GetHadReproduced).must_equal false
        end
    
        it 'set and get reproduced - false neg' do
            sheep = Sheep.new(0,0)
            sheep.SetHadReproduced false
            (sheep.GetHadReproduced).wont_equal true
        end
end
    describe 'sheep tests with minitest with board from file' do
        before do
            @board = Board.new
            @board.LoadFromFile "board.txt"
        end

        after do
            @board = nil
        end
        it 'add sheep to board' do
            sheep = Sheep.new(0,0)
            @board.AddObject sheep
            (@board.GetSign(0,0)).must_equal 's'
            (@board.GetObjectList).must_include sheep
        end
end
    describe 'sheep tests with minitest with empty board 3x3' do
        before do
            @board = Board.new
            @board.CreateEmpty 3,3
        end

        after do
            @board = nil
        end
        it 'sheep go under water' do
            sheep = Sheep.new(0,0)
            @board.AddObject sheep
            lake = Lake.new(0,1)
            @board.AddObject lake
            direction = Point.new(0,1)
            sheep.Walking direction
            (@board.GetSign(0,0)).must_equal '0'
            (@board.GetSign(0,1)).must_equal 'l'
            (@board.GetObjectList).wont_include sheep
        end

        it 'sheep eat grass' do
            sheep = Sheep.new(0,1)
            @board.AddObject sheep
            grass = Grass.new(0,0)
            @board.AddObject grass
            direction = Point.new(0,0)
            sheep.Walking direction
            (@board.GetSign(0,0)).must_equal 's'
            (@board.GetSign(0,1)).must_equal '0'
            (@board.GetObjectList).must_include sheep
            (@board.GetObjectList).wont_include grass
        end
        it 'new sheep2' do
            sheep = Sheep.new(0,0)
            @board.AddObject sheep
            sheep = Sheep.new(2,2)
            @board.AddObject sheep
            @board.TurnByInt 1 
            (@board.GetObjectList.length).must_equal 2
        end
end
    describe 'sheep tests with minitest with empty board 1x1' do
        before do
            @board = Board.new
            @board.CreateEmpty 1,1
        end

        after do
            @board = nil
        end
        it 'fail - bad direction1' do
            sheep = Sheep.new(0,0)
            direction = Point.new(0,1)
            proc{(sheep.Walking direction)}.must_raise ArgumentError
        end
        it 'fail - bad direction2' do
            sheep = Sheep.new(0,0)
            direction = Point.new(1,0)
            proc{(sheep.Walking direction)}.must_raise ArgumentError
        end
end
    describe 'sheep tests with minitest with empty board 2x2' do
        before do
            @board = Board.new
            @board.CreateEmpty 2,2
        end

        after do
            @board = nil
        end
        it 'fail - bad direction3' do
            sheep = Sheep.new(0,0)
            direction = Point.new(1,1)
            proc{(sheep.Walking direction)}.must_raise ArgumentError
        end

        it 'fail - bad direction4' do
            proc{(sheep = Sheep.new(0,-1))}.must_raise ArgumentError
        end

        it 'fail - bad direction5' do
            proc{(sheep = Sheep.new(-1,0))}.must_raise ArgumentError
        end

        it 'fail - bad direction6' do
            proc{(sheep = Sheep.new(-1,-1))}.must_raise ArgumentError
        end
        it 'new sheep' do
            sheep = Sheep.new(0,0)
            @board.AddObject sheep
            sheep = Sheep.new(1,0)
            @board.AddObject sheep
            direction = Point.new(1,1)
            sheep.Reproduce direction
            (@board.SearchObjectByClassYN direction,Sheep).must_equal true
        end
    
        it 'new sheep - neg' do
            sheep = Sheep.new(0,0)
            @board.AddObject sheep
            sheep = Sheep.new(1,0)
            @board.AddObject sheep
            direction = Point.new(1,1)
            sheep.Reproduce direction
            (@board.SearchObjectByClassYN direction,Sheep).wont_equal false
        end
it 'check empty space' do
            sheep = Sheep.new(0,0)
            @board.AddObject sheep
            sheep = Sheep.new(1,1)
            @board.AddObject sheep
            sheep = Sheep.new(1,0)
            @board.AddObject sheep
            direction = Point.new(1,1)
            empty = Point.new(0,1)
            proc{((sheep.CheckForEmptySpace direction).GetX).must_equal empty.GetX and ((sheep.CheckForEmptySpace direction).GetY).must_equal empty.getY}
        end
    
        it 'check empty space 2' do
            sheep = Sheep.new(0,0)
            @board.AddObject sheep
            sheep = Sheep.new(1,1)
            @board.AddObject sheep
            sheep = Sheep.new(1,0)
            @board.AddObject sheep
            direction = Point.new(0,0)
            empty = Point.new(0,1)
            proc{((sheep.CheckForEmptySpace direction).GetX).must_equal empty.GetX and ((sheep.CheckForEmptySpace direction).GetY).must_equal empty.getY}
        end

        it 'sheep meet the wolf - sheep cant stand on wolf place' do
            sheep = Sheep.new(0,0)
            @board.AddObject sheep
            wolf = Wolf.new(0,1)
            @board.AddObject wolf
            direction = Point.new(0,1)
            sheep.Walking direction
            ((@board.SearchObject direction).GetSign).wont_equal 's'
        end
        
        it 'reproduce' do
            sheep = Sheep.new(0,0)
            @board.AddObject sheep
            sheep = Sheep.new(1,0)
            @board.AddObject sheep
            grass = Grass.new(0,1)
            @board.AddObject grass
            sheep.CheckIfCanReproduce(false)
            direction = Point.new(1,1)
            ((@board.SearchObject direction).GetSign).must_equal 's'
        end
    
        it 'reproduce - fail' do
            sheep = Sheep.new(0,0)
            @board.AddObject sheep
            grass = Grass.new(0,1)
            @board.AddObject grass
            sheep.CheckIfCanReproduce(false)
            direction = Point.new(1,0)
            ((@board.SearchObject direction).GetSign).wont_equal 's'
        end
    
        it 'reproduce - fail because of grass' do
            sheep = Sheep.new(0,0)
            @board.AddObject sheep
            sheep = Sheep.new(1,0)
            @board.AddObject sheep
            grass = Grass.new(0,1)
            @board.AddObject grass
            grass = Grass.new(1,1)
            @board.AddObject grass
            sheep.CheckIfCanReproduce(false)
            direction = Point.new(1,1)
            direction2 = Point.new(0,1)
            proc{((@board.SearchObject direction).GetSign).wont_equal 's' and ((@board.SearchObject direction2).GetSign).wont_equal 's'}
        end
    
        it 'reproduce - fail because of lake' do
            sheep = Sheep.new(0,0)
            @board.AddObject sheep
            sheep = Sheep.new(1,0)
            @board.AddObject sheep
            lake = Lake.new(0,1)
            @board.AddObject lake
            lake = Lake.new(1,1)
            @board.AddObject lake
            sheep.CheckIfCanReproduce(false)
            (@board.GetObjectList.length).must_equal 2
        end
end            
end