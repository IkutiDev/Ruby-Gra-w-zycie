require_relative '../lib/BoardClass'
require_relative '../lib/Point'
require 'minitest/spec'
require 'minitest/autorun'

class TestWolf < Minitest::Test
    describe 'wolf(1x1) tests with minitest' do
        before do
            @board = Board.new
            @board.CreateEmpty 1,1
        end

        it 'fail - bad direction1' do
            wolf = Wolf.new(0,0)
            direction = Point.new(0,1)
            proc{(wolf.Walking direction)}.must_raise ArgumentError
        end
        it 'fail - bad direction2' do
            wolf = Wolf.new(0,0)
            direction = Point.new(1,0)
            proc{(wolf.Walking direction)}.must_raise ArgumentError
        end

        after do
            @board = nil
        end
    end

    describe 'wolf(2x2) tests with minitest' do
        before do
            @board = Board.new
            @board.CreateEmpty 2,2
        end

        it 'fail - bad direction3' do
            wolf = Wolf.new(0,0)
            direction = Point.new(1,1)
            proc{(wolf.Walking direction)}.must_raise ArgumentError
        end

        it 'fail - bad direction4' do
            proc{(wolf = Wolf.new(0,-1))}.must_raise ArgumentError
        end

        it 'fail - bad direction5' do
            proc{(wolf = Wolf.new(-1,0))}.must_raise ArgumentError
        end

        it 'fail - bad direction6' do
            proc{(wolf = Wolf.new(-1,-1))}.must_raise ArgumentError
        end

        after do
            @board = nil
        end
    end

    describe 'wolf(3x3) tests with minitest' do
        before do
            @board = Board.new
            @board.CreateEmpty 3,3
        end

        it 'wolf go under water' do
            wolf = Wolf.new(0,0)
            @board.AddObject wolf
            lake = Lake.new(0,1)
            @board.AddObject lake
            direction = Point.new(0,1)
            wolf.Walking direction
            (@board.GetSign(0,0)).must_equal '0'
            (@board.GetSign(0,1)).must_equal 'l'
            (@board.GetObjectList).wont_include wolf
        end

        it 'wolf eats sheep' do
            sheep = Sheep.new(0,0)
            wolf = Wolf.new(0,1)
            @board.AddObject sheep
            @board.AddObject wolf
            direction = Point.new(0,0)
            wolf.Walking direction
            (@board.GetSign(0,0)).must_equal 'w'
            (@board.GetSign(0,1)).must_equal '0'
            (@board.GetObjectList).must_include wolf 
            (@board.GetObjectList).wont_include sheep
        end

        after do
            @board = nil
        end
    end

    describe 'wolf tests with minitest' do
        before do
            @board = Board.new
        end

        after do
            @board = nil
        end

        it 'add wolf to board' do
            @board.LoadFromFile "board.txt"
            wolf = Wolf.new(0,0)
            @board.AddObject wolf
            (@board.GetSign(0,0)).must_equal 'w'
            (@board.GetObjectList).must_include wolf
        end
    end
end