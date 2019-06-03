require_relative '../lib/BoardClass'
require_relative '../lib/Point'
describe 'grass tests with rspec' do
    before {@board = Board.new}

    it 'add grass to board' do
        @board.LoadFromFile "data/board.txt"
        grass = Grass.new(0,0)
        @board.AddObject grass
        expect(@board.GetSign(0,0)).to eq('g')
        expect(@board.GetObjectList).to include(grass)
    end
    
    it 'set and get health' do
        grass = Grass.new(0,0)
        grass.SetHealth 2
        expect(grass.GetHealth).to eq(2)
    end

    after {@board = nil}
end

describe 'grass tests with rspec board(1x1)' do
    before {@board = Board.new
        @board.CreateEmpty 1,1}

    it 'fail - bad direction1' do
        grass = Grass.new(0,0)
        direction = Point.new(0,1)
        expect{(grass.Reproduce direction)}.to raise_error(ArgumentError)
    end

    it 'fail - bad direction2' do
        grass = Grass.new(0,0)
        direction = Point.new(1,0)
        expect{(grass.Reproduce direction)}.to raise_error(ArgumentError)
    end
    after {@board = nil}
end

describe 'grass tests with rspec board(3x3)' do
    before {@board = Board.new
        @board.CreateEmpty 3,3}
    it 'grass doesnt die when wolf step on' do
        grass = Grass.new(0,0)
        wolf = Wolf.new(0,1)
        @board.AddObject grass
        @board.AddObject wolf
        direction = Point.new(0,0)
        wolf.Walking direction
        direction = Point.new(0,1)
        wolf.Walking direction
        expect(@board.GetSign(0,0)).to eq('g')
    end

    it 'growing grass' do
        grass = Grass.new(0,0)
        @board.AddObject grass
        direction = Point.new(0,1)
        grass.Reproduce direction
        expect(@board.GetSign(0,1)).to eq('g')
    end

    it 'decrease health' do
        grass = Grass.new(0,0)
        @board.AddObject grass
        grass.SetHealth 2
        grass.DecreaseHealth
        expect(grass.GetHealth).to eq(1)
    end

    it 'grass die when wolf step on and became old' do
        grass = Grass.new(0,0)
        wolf = Wolf.new(0,1)
        @board.AddObject grass
        @board.AddObject wolf
        direction = Point.new(0,0)
        wolf.Walking direction
        grass.SetHealth 0
        direction = Point.new(0,1)
        wolf.Walking direction
        expect(@board.GetSign(0,0)).to eq('0')
        expect(@board.GetObjectList).not_to include(grass)
    end

    after {@board = nil}
end

describe 'grass tests with rspec board(2x2)' do
    before {@board = Board.new
        @board.CreateEmpty 2,2}

    it 'fail - bad direction3' do
        grass = Grass.new(0,0)
        direction = Point.new(1,1)
        expect{(grass.Reproduce direction)}.to raise_error(ArgumentError)
    end

    it 'became old' do
        grass = Grass.new(0,0)
        @board.AddObject grass
        grass.SetHealth 0
        expect(@board.GetSign(0,0)).to eq('0')
        expect(@board.GetObjectList).not_to include(grass)
    end
    after {@board = nil}
end