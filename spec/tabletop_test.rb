require 'minitest/autorun'
require 'minitest/spec'
require_relative '../tabletop'

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

  describe "#max_col", "#max_row" do
  
    describe "when no parameters are specified" do
      it "returns 4" do
        table = TableTop.new
        table.max_col.must_equal 4
        table.max_row.must_equal 4
      end
    end

    describe "when non positive col is specified" do
      it "returns 4" do
        table = TableTop.new(0, -2)
        table.max_col.must_equal 4
        table.max_row.must_equal 4
      end
    end

    describe "when positive col is specified" do
      it "returns one less than the col" do
        table = TableTop.new(15, 20)
        table.max_col.must_equal 19
        table.max_row.must_equal 14
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

  describe "#set_position", "#reset" do

    before do
      @table = TableTop.new
    end

    describe "when a valid row, col are specified" do

      it "clears the table, sets the row, col bit to 1" do
        @table.set_position(0,0)
        count = 0
        @table.rows.times do | row | 
          @table.cols.times do | col |
            if @table.grid[row][col] == 1
              count += 1
            end 
          end
        end
        count.must_equal 1
        col = @table.convert_x(0)
        row = @table.convert_y(0)
        @table.grid[row][col].must_equal 1
      end
    end

    describe "when a invalid row, col are specified" do

      it "clears the table" do
        @table.set_position(-1,6)
        count = 0
        @table.rows.times do | row | 
          @table.cols.times do | col |
            if @table.grid[row][col] == 0
              count += 1
            end 
          end
        end
        count.must_equal 5*5
      end
    end
  end
end
