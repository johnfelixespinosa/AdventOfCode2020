# frozen_string_literal: true

# irb -r ./day4.rb
# Day4.new.part_one
# Day4.new.part_two

# byr iyr eyr hgt hcl ecl pid cid

class Day4
  VALID_EYE_COLORS = %w(amb blu brn gry grn hzl oth).freeze
  VALID_FIELDS = %w(byr iyr eyr hgt hcl ecl pid cid).freeze
  OPTIONAL_FIELDS = %w(cid).freeze
  REQUIRED_FIELDS = VALID_FIELDS - OPTIONAL_FIELDS

  def part_one
    acceptable_passports.count
  end

  def part_two
    validated_passports.count
  end

  def data
    data_file = File.read(File.expand_path("../day4.txt", __FILE__)).split("\n")
    data_file.push("")
  end

  def gathered_passports
    last_empty = 0
    passports_array = []

    data.each_with_index do |row, i|
      if row == ""
        passports_array << data[last_empty..(i - 1)]
        last_empty = i + 1
      end
    end

    passports_array.map do |pp|
      pp.map { |v| v.split(" ") }.flatten
    end
  end

  def acceptable_passports
    gathered_passports.select { |pp| acceptable?(pp) }
  end

  def validated_passports
    valid_passports.select { |pp| validated?(pp) }
  end

  def valid_passports
    acceptable_passports.map { |pp| pp.map{|v| v.split(":")}.to_h }
  end

  def validated?(pp)
    REQUIRED_FIELDS.all?{ |field| send("#{field}_valid?", pp[field]) }
  end

  def acceptable?(passport)
    required = %w(byr iyr eyr hgt hcl ecl pid)
    passport_hash = passport.map{|v| v.split(":")}.to_h
    keys_missing = required - passport_hash.keys

    keys_missing.empty?
  end

  private

  def byr_valid?(year)
    year.to_i.between?(1920, 2002)
  end

  def iyr_valid?(year)
    year.to_i.between?(2010, 2020)
  end

  def eyr_valid?(year)
    year.to_i.between?(2020, 2030)
  end

  def hgt_valid?(height)
    return hgt_cm_valid?(height.gsub("cm", "")) if height =~ /cm$/i
    return hgt_in_valid?(height.gsub("in", "")) if height =~ /in$/i

    false
  end

  def hgt_cm_valid?(height)
    height.to_i.between?(150, 193)
  end

  def hgt_in_valid?(height)
    height.to_i.between?(59, 76)
  end

  def hcl_valid?(hex_value)
    true if hex_value =~ /^#([a-fA-F0-9]{6}|[a-fA-F0-9]{3})$/i # I looked up the regex for validating color codes
  end

  def ecl_valid?(color)
    VALID_EYE_COLORS.include?(color)
  end

  def pid_valid?(id)
    id.size == 9
  end
end

puts "Part 1 answer: #{Day4.new.part_one}"
puts "Part 3 answer: #{Day4.new.part_two}"
