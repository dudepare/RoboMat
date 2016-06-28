require 'minitest/autorun'
require 'minitest/spec'
require_relative '../lib/compass'

describe Compass do
  
  describe "#create" do
    describe "when created" do
      it "has current direction of zero" do
        compass = Compass.new
        compass.current.must_equal 0
      end
    end
  end

  describe "#rotate_left", "#where" do
    describe "when initial direction is North, and call rotate_left" do
      it "rotates a quarter turn, faces West" do
        compass = Compass.new
        compass.set_direction('N')
        compass.rotate_left
        compass.where.must_equal 'W'
      end
    end

    describe "when initial direction is West, and call rotate_left" do
      it "rotates a quarter turn, faces South" do
        compass = Compass.new
        compass.set_direction('W')
        compass.rotate_left
        compass.where.must_equal 'S'
      end
    end

    describe "when initial direction is South, and call rotate_left" do
      it "rotates a quarter turn, faces East" do
        compass = Compass.new
        compass.set_direction('S')
        compass.rotate_left
        compass.where.must_equal 'E'
      end
    end

    describe "when initial direction is East, and call rotate_left" do
      it "completes a full turn, faces North again" do
        compass = Compass.new
        compass.set_direction('E')
        compass.rotate_left
        compass.where.must_equal 'N'
      end
    end
  end

  describe "#rotate_right", "#where" do
    describe "when initial direction is North, and call rotate_right" do
      it "rotates a quarter turn, faces East" do
        compass = Compass.new
        compass.set_direction('N')
        compass.rotate_right
        compass.where.must_equal 'E'
      end
    end
    
    describe "when initial direction is East, and call rotate_right" do
      it "rotates a quarter turn, faces South" do
        compass = Compass.new
        compass.set_direction('E')
        compass.rotate_right
        compass.where.must_equal 'S'
      end
    end

    describe "when initial direction is South, and call rotate_right" do
      it "rotates a quarter turn, faces West" do
        compass = Compass.new
        compass.set_direction('S')
        compass.rotate_right
        compass.where.must_equal 'W'
      end
    end

    describe "when initial direction is West, and call rotate_right" do
      it "completes a full turn, faces North again" do
        compass = Compass.new
        compass.set_direction('W')
        compass.rotate_right
        compass.where.must_equal 'N'
      end
    end
  end

  describe "#coordinates" do
    describe "when our direction is facing North" do
      it "is equal to x is 0, y is 1" do
        compass = Compass.new
        compass.set_direction('N')
        x , y = compass.coordinates
        x.must_equal 0
        y.must_equal 1
      end
    end

    describe "when our direction is facing East" do
      it "is equal to x is 1, y is 0" do
        compass = Compass.new
        compass.set_direction('E')
        x , y = compass.coordinates
        x.must_equal 1
        y.must_equal 0
      end
    end

    describe "when our direction is facing South" do
      it "is equal to x is 0, y is -1" do
        compass = Compass.new
        compass.set_direction('S')
        x , y = compass.coordinates
        x.must_equal 0
        y.must_equal -1
      end
    end

    describe "when our direction is facing West" do
      it "is equal to x is -1, y is 0" do
        compass = Compass.new
        compass.set_direction('W')
        x , y = compass.coordinates
        x.must_equal -1
        y.must_equal 0
      end
    end

  end

end