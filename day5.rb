# frozen_string_literal: true

# irb -r ./day5.rb

TEST_FILE = "../day5b.txt"
REAL_FILE = "../day5.txt"

class BoardingPassList
  attr_accessor :pass_list

  def initialize(file)
    @pass_list = list(file)
  end

  def list(file)
    data_file = File.read(File.expand_path("#{file}", __FILE__)).split("\n")
  end
end

class BoardingPass
  attr_reader :code # @code="FFFBBFBLLR"
  attr_accessor :plane_rows # @plane_rows= [0..127]
  attr_accessor :plane_columns # @plane_columns= [0..7]
  attr_accessor :row, :column

  def initialize(code, plane_rows, plane_columns)
    @code = code
    @plane_rows = plane_rows
    @plane_columns = plane_columns
    @row = find_row(@code, @plane_rows)
    @column = find_column(@code, @plane_columns)
  end

  def find_row(code, plane_rows)
    lower = "F"
    upper = "B"
    codes = @code.split("").shift(7) # ["F", "F", "F", "B", "B", "F", "B"]

    codes.each do |code|
      var = @plane_rows
      if code == lower
        take_lower(var)
      else
        take_upper(var)
      end
    end
    @row ||= @plane_rows.first.to_i
  end

  def find_column(code, plane_columns)
    lower = "L"
    upper = "R"
    codes = @code.split("").pop(3) # ["R", "L", "R"]

    codes.each do |code|
      var = @plane_columns
      if code == lower
        take_lower(var)
      else
        take_upper(var)
      end
    end
    @column ||= @plane_columns.first.to_i
  end

  def take_lower(var)
    var.pop((var.size) / 2)
  end

  def take_upper(var)
    var.shift((var.size) / 2)
  end

  def calc_seat_id
    (@row * 8) + @column
  end
end

class Plane
  attr_accessor :rows, :columns , :pass_list, :seat_info

  def initialize(file = TEST_FILE)
    @pass_list = BoardingPassList.new(file).pass_list
    @rows = (0..127).to_a
    @columns = (0..7).to_a
    @seat_info = find_seat_info
  end

  def find_seat_info
    seat_info = []
    @pass_list.each do |pass|
      boarding_pass = BoardingPass.new(pass, (0..127).to_a, (0..7).to_a)
      id = boarding_pass.calc_seat_id
      row = boarding_pass.row
      column = boarding_pass.column
      seat_info << [id, row, column]
    end
    seat_info
  end

  def find_highest_seat_id
    @seat_info.sort.reverse.first.first
  end

  def seat_ids
    @seat_info.sort.map {|i| i.first.to_i }
  end

  def find_empty_seat_id
    expected_sum_of_seat_ids - sum_of_seat_ids
  end

  private

  def sum_of_seat_ids
    seat_ids.sum
  end

  def expected_sum_of_seat_ids
    sum_of_first_n_ints(seat_ids.max) - sum_of_first_n_ints(seat_ids.min - 1)
  end

  def sum_of_first_n_ints(seat_id)
    (seat_id * (seat_id + 1)) / 2
  end
end

plane = Plane.new(REAL_FILE)

puts "The plane has #{plane.rows.size} rows."
puts "The plane has #{plane.columns.size} columns."
puts "The plane has #{plane.columns.size * plane.rows.size} seats."
puts "The plane has #{plane.find_seat_info.size} seats taken."
puts "The plane's highest seat ID is #{plane.find_highest_seat_id}"
puts "There is an empty seat at seat ID #{plane.find_empty_seat_id}"
