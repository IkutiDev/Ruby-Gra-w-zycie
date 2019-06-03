require_relative '../lib/BoardClass'
describe 'boards(10x10) tests with rspec' do
    before {@board = Board.new
            @board.CreateEmpty 10,10}

    it 'empty board' do
        arr = Array.new(10) {Array.new(10)}
        for i in 0..9
            for j in 0..9
                arr[i][j] = "0"
            end
        end
        expect(@board.GetArray).to eq(arr)
    end

    it 'add object to board' do
        object = Object.new(5,5,'g')
        @board.AddObject object
        expect(@board.GetSign(5,5)).to eq('g')
    end

    it 'add object to board - neg' do
        object = Object.new(5,5,'g')
        @board.AddObject object
        expect(@board.GetSign(5,5)).not_to eq('0')
    end

    it 'add object to board - fail beyond the board' do
        object = Object.new(15,15,'g')
        expect{(@board.AddObject object)}.to raise_error(ArgumentError)
    end
    it 'add object to board - fail occupied field' do
        object = Object.new(5,5,'g')
        @board.AddObject object
        expect{(@board.AddObject object)}.to raise_error(ArgumentError)
    end

    after {@board = nil}
end

describe 'boards(2x2) tests with rspec' do
    before {@board = Board.new
            @board.CreateEmpty 2,2}

    it 'add random object' do
        object = Object.new(1,1,'g')
        @board.AddObject object
        object = Object.new(0,1,'w')
        @board.AddObject object
        object = Object.new(1,0,'l')
        @board.AddObject object
        @board.AddRandomObject
        expect(@board.GetSign(0,0)).not_to eq('0')
    end
    it 'add random object - more' do
        @board.AddRandomObject
        @board.AddRandomObject
        @board.AddRandomObject
        @board.AddRandomObject
        expect{(@board.GetSign(0,0)).not_to eq('0') and (@board.GetSign(0,1)).not_to eq('0') and (@board.GetSign(1,0)).not_to eq('0') and (@board.GetSign(1,1)).not_to eq('0')}
    end

    after {@board = nil}
end

describe 'boards(3x3) tests with rspec' do
    before {@board = Board.new
            @board.CreateEmpty 3,3}

    # grass
    it 'search object - direction' do
        grass = Grass.new(0,0)
        @board.AddObject grass
        direction = Point.new(0,0)
        expect(@board.SearchObject direction).to eq(grass)
    end

    it 'search object - direction - neg' do
        object = Object.new(0,0,'0')
        @board.AddObject object
        grass = Grass.new(0,0)
        @board.AddObject grass
        direction = Point.new(0,0)
        expect(@board.SearchObject direction).not_to eq(object)
    end

    it 'search object - direction2' do
        grass = Grass.new(0,0)
        @board.AddObject grass
        direction = Point.new(0,1)
        grass.Reproduce direction
        expect((@board.SearchObject direction).GetSign).to eq('g')
    end

    it 'search object - direction2 - neg' do
        grass = Grass.new(0,0)
        @board.AddObject grass
        direction = Point.new(0,1)
        grass.Reproduce direction
        expect((@board.SearchObject direction).GetSign).not_to eq('0')
    end

    it 'search object - direction and class of the object - true/false' do
        grass = Grass.new(0,0)
        @board.AddObject grass
        direction = Point.new(0,0)
        expect(@board.SearchObjectByClassYN direction,Grass).to eq(true)
    end

    it 'search object - direction and class of the object - true/false - neg' do
        grass = Grass.new(0,0)
        @board.AddObject grass
        direction = Point.new(0,0)
        expect(@board.SearchObjectByClassYN direction,Grass).not_to eq(false)
    end

    it 'search object - direction and class of the object' do
        object = Object.new(0,0,'0')
        @board.AddObject object
        grass = Grass.new(0,0)
        @board.AddObject grass
        direction = Point.new(0,0)
        expect(@board.SearchObjectByClass direction,Grass).to eq(grass)
    end

    it 'search object - direction and class of the object - neg' do
        object = Object.new(0,0,'0')
        @board.AddObject object
        grass = Grass.new(0,0)
        @board.AddObject grass
        direction = Point.new(0,0)
        expect(@board.SearchObjectByClass direction,Grass).not_to eq(object)
    end

    # wolf
    it 'search object - direction' do
        wolf = Wolf.new(0,0)
        @board.AddObject wolf
        direction = Point.new(0,0)
        expect(@board.SearchObject direction).to eq(wolf)
    end

    it 'search object - direction - neg' do
        object = Object.new(0,0,'0')
        @board.AddObject object
        wolf = Wolf.new(0,0)
        @board.AddObject wolf
        direction = Point.new(0,0)
        expect(@board.SearchObject direction).not_to eq(object)
    end

    it 'search object - direction2' do
        wolf = Wolf.new(0,0)
        @board.AddObject wolf
        direction = Point.new(0,1)
        wolf.Walking direction
        expect((@board.SearchObject direction).GetSign).to eq('w')
    end

    it 'search object - direction2 - neg' do
        wolf = Wolf.new(0,0)
        @board.AddObject wolf
        direction = Point.new(0,1)
        wolf.Walking direction
        expect((@board.SearchObject direction).GetSign).not_to eq('0')
    end

    it 'search object - direction and class of the object - true/false' do
        wolf = Wolf.new(0,0)
        @board.AddObject wolf
        direction = Point.new(0,0)
        expect(@board.SearchObjectByClassYN direction,Wolf).to eq(true)
    end

    it 'search object - direction and class of the object - true/false - neg' do
        wolf = Wolf.new(0,0)
        @board.AddObject wolf
        direction = Point.new(0,0)
        expect(@board.SearchObjectByClassYN direction,Wolf).not_to eq(false)
    end

    it 'search object - direction and class of the object' do
        object = Object.new(0,0,'0')
        @board.AddObject object
        wolf = Wolf.new(0,0)
        @board.AddObject wolf
        direction = Point.new(0,0)
        expect(@board.SearchObjectByClass direction,Wolf).to eq(wolf)
    end

    it 'search object - direction and class of the object - neg' do
        object = Object.new(0,0,'0')
        @board.AddObject object
        wolf = Wolf.new(0,0)
        @board.AddObject wolf
        direction = Point.new(0,0)
        expect(@board.SearchObjectByClass direction,Wolf).not_to eq(object)
    end

    # sheep
    it 'search object - direction' do
        sheep = Sheep.new(0,0)
        @board.AddObject sheep
        direction = Point.new(0,0)
        expect(@board.SearchObject direction).to eq(sheep)
    end

    it 'search object - direction - neg' do
        object = Object.new(0,0,'0')
        @board.AddObject object
        sheep = Sheep.new(0,0)
        @board.AddObject sheep
        direction = Point.new(0,0)
        expect(@board.SearchObject direction).not_to eq(object)
    end

    it 'search object - direction2' do
        sheep = Sheep.new(0,0)
        @board.AddObject sheep
        direction = Point.new(0,1)
        sheep.Walking direction
        expect((@board.SearchObject direction).GetSign).to eq('s')
    end

    it 'search object - direction2 - neg' do
        sheep = Sheep.new(0,0)
        @board.AddObject sheep
        direction = Point.new(0,1)
        sheep.Walking direction
        expect((@board.SearchObject direction).GetSign).not_to eq('0')
    end

    it 'search object - direction and class of the object - true/false' do
        sheep = Sheep.new(0,0)
        @board.AddObject sheep
        direction = Point.new(0,0)
        expect(@board.SearchObjectByClassYN direction,Sheep).to eq(true)
    end

    it 'search object - direction and class of the object - true/false - neg' do
        sheep = Sheep.new(0,0)
        @board.AddObject sheep
        direction = Point.new(0,0)
        expect(@board.SearchObjectByClassYN direction,Sheep).not_to eq(false)
    end

    it 'search object - direction and class of the object' do
        object = Object.new(0,0,'0')
        @board.AddObject object
        sheep = Sheep.new(0,0)
        @board.AddObject sheep
        direction = Point.new(0,0)
        expect(@board.SearchObjectByClass direction,Sheep).to eq(sheep)
    end

    it 'search object - direction and class of the object - neg' do
        object = Object.new(0,0,'0')
        @board.AddObject object
        sheep = Sheep.new(0,0)
        @board.AddObject sheep
        direction = Point.new(0,0)
        expect(@board.SearchObjectByClass direction,Sheep).not_to eq(object)
    end        

    after {@board = nil}
end

describe 'boards tests with rspec' do
    before {@board = Board.new}
    
    it 'empty board - fail not square' do
        expect{(@board.CreateEmpty(1,2))}.to raise_error(ArgumentError)
    end
    
    it 'load from file - empty board' do
        @board.LoadFromFile "data/board.txt"
        arr = Array.new(5) {Array.new(5)}
        for i in 0..4
            for j in 0..4
                arr[i][j] = "0"
            end
        end
        expect(@board.GetArray).to eq(arr)
    end
    it 'load from file' do
        @board.LoadFromFile "data/board3.txt"
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
        expect(@board.GetArray).to eq(arr)
    end
    it 'load from file - fail incorrect name' do
        expect{(@board.LoadFromFile "data/boarddd.txt")}.to raise_error(ArgumentError)
    end
    it 'load from file - fail not square' do
        expect{(@board.LoadFromFile "data/board2.txt")}.to raise_error(ArgumentError)
    end

    it 'add sign to object' do
        object = Object.new(1,1,'a')
        object.SetSign 'b'
        expect(object.GetSign).to eq('b')
    end

    it 'fail - wrong board size' do
        expect{(@board.CreateEmpty 0,0)}.to raise_error(ArgumentError)
    end

    it 'fail - wrong board size again' do
        expect{(@board.CreateEmpty -4,-4)}.to raise_error(ArgumentError)
    end

    it 'fail - bad point values' do
        expect{(point=Point.new(-8,-9))}.to raise_error(ArgumentError)
    end

    after {@board = nil}
end
