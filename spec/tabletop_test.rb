require 'minitest/autorun'
require 'minitest/spec'
require_relative '../lib/tabletop'

describe TableTop do

  #:reset
  describe "#create" do

    describe "when no parameters specified"  do
      it "creates 5x5 table" do
        table = TableTop.new
        table.rows.must_equal 5
        table.cols.must_equal 5
      end
    end

    describe "when row parameter specified"  do
      it "creates rowx5 table" do
        table = TableTop.new(7)
        table.rows.must_equal 7
        table.cols.must_equal 5
      end
    end

    describe "when row col parameter specified"  do
      it "creates rowxcol table" do
        table = TableTop.new(7, 7)
        table.rows.must_equal 7
        table.cols.must_equal 7
      end
    end

    describe "when a non positive row or col is specified"  do
      it "changes the non positive row to 5" do
        table = TableTop.new(0, 7)
        table.rows.must_equal 5
        table.cols.must_equal 7
      end

      it "changes the non positive col to 5" do
        table = TableTop.new(7, 0)
        table.rows.must_equal 7
        table.cols.must_equal 5
      end
    end
  end

  describe "#is_point_inside?" do
    
    before do
      @table = TableTop.new
    end

    describe "when point lies outside the table" do
      it "returns false" do
        @table.is_point_inside?(6,6).must_equal false
        @table.is_point_inside?(-1,1).must_equal false
        @table.is_point_inside?(40,-200).must_equal false
        @table.is_point_inside?(5,5).must_equal false
      end
    end

    describe "when point lies within the table" do
      it "returns true" do
        @table.is_point_inside?(1,1).must_equal true
        @table.is_point_inside?(0,0).must_equal true
        @table.is_point_inside?(3,4).must_equal true
        @table.is_point_inside?(4,4).must_equal true
      end
    end
  end
end