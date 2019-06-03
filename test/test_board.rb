require_relative '../lib/BoardClass'
require 'minitest/spec'
require 'minitest/autorun'

class TestBoard < Minitest::Test
    describe 'boards(10x10) tests with minitest' do
        before do
            @board = Board.new
            @board.CreateEmpty 10,10
        end

        it 'empty board' do
            arr = Array.new(10) {Array.new(10)}
            for i in 0..9
                for j in 0..9
                    arr[i][j] = "0"
                end
            end
            (@board.GetArray).must_equal arr
        end

        it 'add object to board' do
            object = Object.new(5,5,'g')
            @board.AddObject object
            (@board.GetSign(5,5)).must_equal 'g'
        end

        it 'add object to board - neg' do
            object = Object.new(5,5,'g')
            @board.AddObject object
            (@board.GetSign(5,5)).wont_equal '0'
        end

        it 'add object to board - fail beyond the board' do
            object = Object.new(15,15,'g')
            proc{@board.AddObject object}.must_raise ArgumentError
        end

        it 'add object to board - fail occupied field' do
            object = Object.new(5,5,'g')
            @board.AddObject object
            proc{@board.AddObject object}.must_raise ArgumentError
        end

        after do
            @board = nil
        end
    end

    describe 'boards(2x2) tests with minitest' do
        before do
            @board = Board.new
            @board.CreateEmpty 2,2
        end

        it 'add random object' do
            object = Object.new(1,1,'g')
            @board.AddObject object
            object = Object.new(0,1,'w')
            @board.AddObject object
            object = Object.new(1,0,'l')
            @board.AddObject object
            @board.AddRandomObject
            (@board.GetSign(0,0)).wont_equal '0'
        end

        it 'add random object - more' do
            @board.AddRandomObject
            @board.AddRandomObject
            @board.AddRandomObject
            @board.AddRandomObject
            (@board.GetSign(0,0)).wont_equal '0' and (@board.GetSign(0,1)).wont_equal '0' and (@board.GetSign(1,0)).wont_equal '0' and (@board.GetSign(1,1)).wont_equal '0'
        end

        after do
            @board = nil
        end
    end

    describe 'boards(3x3) tests with minitest' do
        before do
            @board = Board.new
            @board.CreateEmpty 3,3
        end

         # grass
         it 'search object - direction' do
            grass = Grass.new(0,0)
            @board.AddObject grass
            direction = Point.new(0,0)
            (@board.SearchObject direction).must_equal grass
        end

        it 'search object - direction - neg' do
            object = Object.new(0,0,'0')
            @board.AddObject object
            grass = Grass.new(0,0)
            @board.AddObject grass
            direction = Point.new(0,0)
            (@board.SearchObject direction).wont_equal object
        end

        it 'search object - direction2' do
            grass = Grass.new(0,0)
            @board.AddObject grass
            direction = Point.new(0,1)
            grass.Reproduce direction
            ((@board.SearchObject direction).GetSign).must_equal 'g'
        end

        it 'search object - direction2 - neg' do
            grass = Grass.new(0,0)
            @board.AddObject grass
            direction = Point.new(0,1)
            grass.Reproduce direction
            ((@board.SearchObject direction).GetSign).wont_equal '0'
        end

        it 'search object - direction and class of the object - true/false' do
            grass = Grass.new(0,0)
            @board.AddObject grass
            direction = Point.new(0,0)
            (@board.SearchObjectByClassYN direction,Grass).must_equal true
        end

        it 'search object - direction and class of the object - true/false - neg' do
            grass = Grass.new(0,0)
            @board.AddObject grass
            direction = Point.new(0,0)
            (@board.SearchObjectByClassYN direction,Grass).wont_equal false
        end

        it 'search object - direction and class of the object' do
            object = Object.new(0,0,'0')
            @board.AddObject object
            grass = Grass.new(0,0)
            @board.AddObject grass
            direction = Point.new(0,0)
            (@board.SearchObjectByClass direction,Grass).must_equal grass
        end

        it 'search object - direction and class of the object - neg' do
            object = Object.new(0,0,'0')
            @board.AddObject object
            grass = Grass.new(0,0)
            @board.AddObject grass
            direction = Point.new(0,0)
            (@board.SearchObjectByClass direction,Grass).wont_equal object
        end

        # wolf
        it 'search object - direction' do
            wolf = Wolf.new(0,0)
            @board.AddObject wolf
            direction = Point.new(0,0)
            (@board.SearchObject direction).must_equal wolf
        end

        it 'search object - direction - neg' do
            object = Object.new(0,0,'0')
            @board.AddObject object
            wolf = Wolf.new(0,0)
            @board.AddObject wolf
            direction = Point.new(0,0)
            (@board.SearchObject direction).wont_equal object
        end

        it 'search object - direction2' do
            wolf = Wolf.new(0,0)
            @board.AddObject wolf
            direction = Point.new(0,1)
            wolf.Walking direction
            ((@board.SearchObject direction).GetSign).must_equal 'w'
        end

        it 'search object - direction2 - neg' do
            wolf = Wolf.new(0,0)
            @board.AddObject wolf
            direction = Point.new(0,1)
            wolf.Walking direction
            ((@board.SearchObject direction).GetSign).wont_equal '0'
        end

        it 'search object - direction and class of the object - true/false' do
            wolf = Wolf.new(0,0)
            @board.AddObject wolf
            direction = Point.new(0,0)
            (@board.SearchObjectByClassYN direction,Wolf).must_equal true
        end

        it 'search object - direction and class of the object - true/false - neg' do
            wolf = Wolf.new(0,0)
            @board.AddObject wolf
            direction = Point.new(0,0)
            (@board.SearchObjectByClassYN direction,Wolf).wont_equal false
        end

        it 'search object - direction and class of the object' do
            object = Object.new(0,0,'0')
            @board.AddObject object
            wolf = Wolf.new(0,0)
            @board.AddObject wolf
            direction = Point.new(0,0)
            (@board.SearchObjectByClass direction,Wolf).must_equal wolf
        end

        it 'search object - direction and class of the object - neg' do
            object = Object.new(0,0,'0')
            @board.AddObject object
            wolf = Wolf.new(0,0)
            @board.AddObject wolf
            direction = Point.new(0,0)
            (@board.SearchObjectByClass direction,Wolf).wont_equal object
        end

        # sheep
        it 'search object - direction' do
            sheep = Sheep.new(0,0)
            @board.AddObject sheep
            direction = Point.new(0,0)
            (@board.SearchObject direction).must_equal sheep
        end

        it 'search object - direction - neg' do
            object = Object.new(0,0,'0')
            @board.AddObject object
            sheep = Sheep.new(0,0)
            @board.AddObject sheep
            direction = Point.new(0,0)
            (@board.SearchObject direction).wont_equal object
        end

        it 'search object - direction2' do
            sheep = Sheep.new(0,0)
            @board.AddObject sheep
            direction = Point.new(0,1)
            sheep.Walking direction
            ((@board.SearchObject direction).GetSign).must_equal 's'
        end

        it 'search object - direction2 - neg' do
            sheep = Sheep.new(0,0)
            @board.AddObject sheep
            direction = Point.new(0,1)
            sheep.Walking direction
            ((@board.SearchObject direction).GetSign).wont_equal '0'
        end

        it 'search object - direction and class of the object - true/false' do
            sheep = Sheep.new(0,0)
            @board.AddObject sheep
            direction = Point.new(0,0)
            (@board.SearchObjectByClassYN direction,Sheep).must_equal true
        end

        it 'search object - direction and class of the object - true/false - neg' do
            sheep = Sheep.new(0,0)
            @board.AddObject sheep
            direction = Point.new(0,0)
            (@board.SearchObjectByClassYN direction,Sheep).wont_equal false
        end

        it 'search object - direction and class of the object' do
            object = Object.new(0,0,'0')
            @board.AddObject object
            sheep = Sheep.new(0,0)
            @board.AddObject sheep
            direction = Point.new(0,0)
            (@board.SearchObjectByClass direction,Sheep).must_equal sheep
        end

        it 'search object - direction and class of the object - neg' do
            object = Object.new(0,0,'0')
            @board.AddObject object
            sheep = Sheep.new(0,0)
            @board.AddObject sheep
            direction = Point.new(0,0)
            (@board.SearchObjectByClass direction,Sheep).wont_equal object
        end

        after do
            @board = nil
        end
    end

    describe 'boards tests with minitest' do
        before do
            @board = Board.new
        end

        after do
            @board = nil
        end

        it 'empty board - fail not square' do
            proc{@board.CreateEmpty(1,2)}.must_raise ArgumentError
        end

        it 'load from file - empty board' do
            @board.LoadFromFile "board.txt"
            arr = Array.new(5) {Array.new(5)}
            for i in 0..4
                for j in 0..4
                    arr[i][j] = "0"
                end
            end
            (@board.GetArray).must_equal arr
        end

        it 'load from file' do
            @board.LoadFromFile "board3.txt"
            arr = Array.new(5) {Array.new(5)}
            for i in 0..4
                for j in 0..4
                    arr[i][j] = "0"
                end
            end
            arr[0][1] = "w"
            arr[0][3] = "w"
            arr[1][2] = "l"
            arr[1][3] = "l"
            arr[2][2] = "l"
            arr[2][3] = "l"
            arr[3][1] = "g"
            arr[3][2] = "g"
            arr[3][3] = "g"
            arr[4][1] = "s"
            arr[4][3] = "s"
            (@board.GetArray).must_equal arr
        end

        it 'load from file - fail incorrect name' do
            proc{@board.LoadFromFile "boarddd.txt"}.must_raise ArgumentError
        end

        it 'load from file - fail not square' do
            proc{@board.LoadFromFile "board2.txt"}.must_raise ArgumentError
        end

        it 'add sign to object' do
            object = Object.new(1,1,'a')
            object.SetSign 'b'
            (object.GetSign).must_equal 'b'
        end
    
        it 'fail - wrong board size' do
            proc{(@board.CreateEmpty 0,0)}.must_raise ArgumentError
        end
    
        it 'fail - wrong board size again' do
            proc{(@board.CreateEmpty -4,-4)}.must_raise ArgumentError
        end
    
        it 'fail - bad point values' do
            proc{(point=Point.new(-8,-9))}.must_raise ArgumentError
        end
    end
end