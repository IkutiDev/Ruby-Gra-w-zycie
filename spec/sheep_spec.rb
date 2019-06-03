require_relative '../lib/BoardClass'
require_relative '../lib/Point'
describe 'sheep tests with rspec' do
    before {@board = Board.new}
    it 'set and get reproduced - true' do
        sheep = Sheep.new(0,0)
        sheep.SetHadReproduced true
        expect(sheep.GetHadReproduced).to eq(true)
    end

    it 'set and get reproduced - true neg' do
        sheep = Sheep.new(0,0)
        sheep.SetHadReproduced true
        expect(sheep.GetHadReproduced).not_to eq(false)
    end

    it 'set and get reproduced - false' do
        sheep = Sheep.new(0,0)
        sheep.SetHadReproduced false
        expect(sheep.GetHadReproduced).to eq(false)
    end

    it 'set and get reproduced - false neg' do
        sheep = Sheep.new(0,0)
        sheep.SetHadReproduced false
        expect(sheep.GetHadReproduced).not_to eq(true)
    end
    after {@board = nil}    
end
describe 'sheep tests with rspec with board from file' do
    before {@board = Board.new 
        @board.LoadFromFile "data/board.txt"}

    it 'add sheep to board' do
        sheep = Sheep.new(0,0)
        @board.AddObject sheep
        expect(@board.GetSign(0,0)).to eq('s')
        expect(@board.GetObjectList).to include(sheep)
    end
    after {@board = nil}
end
describe 'sheep tests with rspec with board empty 3x3' do
    before {@board = Board.new 
        @board.CreateEmpty 3,3}
    it 'sheep goes under water' do
        
        sheep = Sheep.new(0,0)
        @board.AddObject sheep
        lake = Lake.new(0,1)
        @board.AddObject lake
        direction = Point.new(0,1)
        sheep.Walking direction
        expect(@board.GetSign(0,0)).to eq('0')
        expect(@board.GetSign(0,1)).to eq('l')
        expect(@board.GetObjectList).not_to include(sheep)
    end

    it 'sheep eats grass' do
        sheep = Sheep.new(0,1)
        @board.AddObject sheep
        grass = Grass.new(0,0)
        @board.AddObject grass
        direction = Point.new(0,0)
        sheep.Walking direction
        expect(@board.GetSign(0,0)).to eq('s')
        expect(@board.GetSign(0,1)).to eq('0')
        expect(@board.GetObjectList).to include(sheep)
        expect(@board.GetObjectList).not_to include(grass)
    end
    it 'new sheep2' do
        sheep = Sheep.new(0,0)
        @board.AddObject sheep
        sheep = Sheep.new(2,2)
        @board.AddObject sheep
        @board.TurnByInt 1 
        expect(@board.GetObjectList.length).to eq(2)
    end
    after {@board = nil}
end
describe 'sheep tests with rspec with board empty 1x1' do
    before {@board = Board.new 
        @board.CreateEmpty 1,1}
    it 'fail - bad direction1' do
        sheep = Sheep.new(0,0)
        direction = Point.new(0,1)
        expect{(sheep.Walking direction)}.to raise_error(ArgumentError)
    end
    it 'fail - bad direction2' do
        sheep = Sheep.new(0,0)
        direction = Point.new(1,0)
        expect{(sheep.Walking direction)}.to raise_error(ArgumentError)
    end
    after {@board = nil}
end
describe 'sheep tests with rspec with board empty 2x2' do
    before {@board = Board.new 
        @board.CreateEmpty 2,2}
    it 'fail - bad direction3' do
        sheep = Sheep.new(0,0)
        direction = Point.new(1,1)
        expect{(sheep.Walking direction)}.to raise_error(ArgumentError)
    end

    it 'fail - bad direction4' do
        expect{(sheep = Sheep.new(0,-1))}.to raise_error(ArgumentError)
    end

    it 'fail - bad direction5' do
        expect{(sheep = Sheep.new(-1,0))}.to raise_error(ArgumentError)
    end

    it 'fail - bad direction6' do
        expect{(sheep = Sheep.new(-1,-1))}.to raise_error(ArgumentError)
    end

    it 'new sheep' do
        sheep = Sheep.new(0,0)
        @board.AddObject sheep
        sheep = Sheep.new(1,0)
        @board.AddObject sheep
        direction = Point.new(1,1)
        sheep.Reproduce direction
        expect(@board.SearchObjectByClassYN direction,Sheep).to eq(true)
    end

    it 'new sheep - neg' do
        sheep = Sheep.new(0,0)
        @board.AddObject sheep
        sheep = Sheep.new(1,0)
        @board.AddObject sheep
        direction = Point.new(1,1)
        sheep.Reproduce direction
        expect(@board.SearchObjectByClassYN direction,Sheep).not_to eq(false)
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
        expect{((sheep.CheckForEmptySpace direction).GetX).to eq(empty.GetX) and ((sheep.CheckForEmptySpace direction).GetY).to eq(empty.getY)}
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
        expect{((sheep.CheckForEmptySpace direction).GetX).to eq(empty.GetX) and ((sheep.CheckForEmptySpace direction).GetY).to eq(empty.getY)}
    end

    it 'sheep meet the wolf - sheep cant stand on wolf place' do
        sheep = Sheep.new(0,0)
        @board.AddObject sheep
        wolf = Wolf.new(0,1)
        @board.AddObject wolf
        direction = Point.new(0,1)
        sheep.Walking direction
        expect((@board.SearchObject direction).GetSign).not_to eq('s')
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
        expect((@board.SearchObject direction).GetSign).to eq('s')
    end

    it 'reproduce - fail' do
        sheep = Sheep.new(0,0)
        @board.AddObject sheep
        grass = Grass.new(0,1)
        @board.AddObject grass
        sheep.CheckIfCanReproduce(false)
        direction = Point.new(1,0)
        expect((@board.SearchObject direction).GetSign).not_to eq('s')
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
        expect{((@board.SearchObject direction).GetSign).not_to eq('s') and ((@board.SearchObject direction2).GetSign).not_to eq('s')}
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
        expect(@board.GetObjectList.length).to eq(2)
    end
    after {@board = nil}
end