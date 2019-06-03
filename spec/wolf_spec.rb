require_relative '../lib/BoardClass'
require_relative '../lib/Point'
describe 'wolf(1x1) tests with rspec' do
    before {@board = Board.new
            @board.CreateEmpty 1,1}

    it 'fail - bad direction1' do
        @board.CreateEmpty 1,1
        wolf = Wolf.new(0,0)
        direction = Point.new(0,1)
        expect{(wolf.Walking direction)}.to raise_error(ArgumentError)
    end
    it 'fail - bad direction2' do
        @board.CreateEmpty 1,1
        wolf = Wolf.new(0,0)
        direction = Point.new(1,0)
        expect{(wolf.Walking direction)}.to raise_error(ArgumentError)
    end

    after {@board = nil}
end

describe 'wolf(2x2) tests with rspec' do
    before {@board = Board.new
            @board.CreateEmpty 2,2}

    it 'fail - bad direction3' do
        @board.CreateEmpty 2,2
        wolf = Wolf.new(0,0)
        direction = Point.new(1,1)
        expect{(wolf.Walking direction)}.to raise_error(ArgumentError)
    end

    it 'fail - bad direction4' do
        @board.CreateEmpty 2,2
        expect{(wolf = Wolf.new(0,-1))}.to raise_error(ArgumentError)
    end

    it 'fail - bad direction5' do
        @board.CreateEmpty 2,2
        expect{(wolf = Wolf.new(-1,0))}.to raise_error(ArgumentError)
    end

    it 'fail - bad direction6' do
        @board.CreateEmpty 2,2
        expect{(wolf = Wolf.new(-1,-1))}.to raise_error(ArgumentError)
    end

    after {@board = nil}
end

describe 'wolf(3x3) tests with rspec' do
    before {@board = Board.new
            @board.CreateEmpty 3,3}

    it 'wolf goes under water' do
        @board.CreateEmpty 3,3
        wolf = Wolf.new(0,0)
        @board.AddObject wolf
        lake = Lake.new(0,1)
        @board.AddObject lake
        direction = Point.new(0,1)
        wolf.Walking direction
        expect(@board.GetSign(0,0)).to eq('0')
        expect(@board.GetSign(0,1)).to eq('l')
        expect(@board.GetObjectList).not_to include(wolf)
    end

    it 'wolf eats sheep' do
        @board.CreateEmpty 3,3
        sheep = Sheep.new(0,0)
        wolf = Wolf.new(0,1)
        @board.AddObject sheep
        @board.AddObject wolf
        direction = Point.new(0,0)
        wolf.Walking direction
        expect(@board.GetSign(0,0)).to eq('w')
        expect(@board.GetSign(0,1)).to eq('0')
        expect(@board.GetObjectList).to include(wolf)
        expect(@board.GetObjectList).not_to include(sheep)
    end

    after {@board = nil}
end

describe 'wolf tests with rspec' do
    before {@board = Board.new}

    it 'add wolf to board' do
        @board.LoadFromFile "data/board.txt"
        wolf = Wolf.new(0,0)
        @board.AddObject wolf
        expect(@board.GetSign(0,0)).to eq('w')
        expect(@board.GetObjectList).to include(wolf)
    end

    after {@board = nil}
end