require_relative '../lib/BoardClass'
require_relative '../lib/Point'
require 'minitest/spec'
require 'minitest/autorun'

class TestGrass < Minitest::Test
    describe 'grass tests with minitest' do
        before do
            @board = Board.new
        end

        after do
            @board = nil
        end

        it 'add grass to board' do
            @board.LoadFromFile "board.txt"
            grass = Grass.new(0,0)
            @board.AddObject grass
            (@board.GetSign(0,0)).must_equal 'g'
            (@board.GetObjectList).must_include grass
        end

        it 'set and get health' do
            grass = Grass.new(0,0)
            grass.SetHealth 2
            (grass.GetHealth).must_equal 2
        end

    end
end

describe 'grass tests with minitest board 3x3' do
    before do
        @board = Board.new
        @board.CreateEmpty 3,3
    end

    after do
        @board = nil
    end

    it 'grass doesnt die when wolf step on' do
        grass = Grass.new(0,0)
        wolf = Wolf.new(0,1)
        @board.AddObject grass
        @board.AddObject wolf
        direction = Point.new(0,0)
        wolf.Walking direction
        direction = Point.new(0,1)
        wolf.Walking direction
        (@board.GetSign(0,0)).must_equal 'g'
    end

    it 'growing grass' do
        grass = Grass.new(0,0)
        @board.AddObject grass
        direction = Point.new(0,1)
        grass.Reproduce direction
        (@board.GetSign(0,1)).must_equal 'g'
    end

    it 'decrease health' do
        grass = Grass.new(0,0)
        @board.AddObject grass
        grass.SetHealth 2
        grass.DecreaseHealth
        (grass.GetHealth).must_equal 1
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
        (@board.GetSign(0,0)).must_equal '0'
        (@board.GetObjectList).wont_include grass
    end
end

describe 'grass tests with minitest board 2x2' do
    before do
        @board = Board.new
        @board.CreateEmpty 2,2
    end

    after do
        @board = nil
    end

    it 'fail - bad direction3' do
        grass = Grass.new(0,0)
        direction = Point.new(1,1)
        proc{(grass.Reproduce direction)}.must_raise ArgumentError
    end

    it 'became old' do
        grass = Grass.new(0,0)
        @board.AddObject grass
        grass.SetHealth 0
        (@board.GetSign(0,0)).must_equal '0'
        (@board.GetObjectList).wont_include grass
    end
end

describe 'grass tests with minitest board 1x1' do
    before do
        @board = Board.new
        @board.CreateEmpty 1,1
    end

    after do
        @board = nil
    end

    it 'fail - bad direction1' do
        grass = Grass.new(0,0)
        direction = Point.new(0,1)
        proc{(grass.Reproduce direction)}.must_raise ArgumentError
    end
    it 'fail - bad direction2' do
        grass = Grass.new(0,0)
        direction = Point.new(1,0)
        proc{(grass.Reproduce direction)}.must_raise ArgumentError
    end

end