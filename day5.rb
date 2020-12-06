# frozen_string_literal: true

# irb -r ./day5.rb

TEST_FILE = "../day5b.txt"
FILE      = "../day5.txt"


class BoardingPassList
  attr_accessor :manifest

  def initialize(file)
    @manifest = list(file)
  end

  def list(file)
    data_file = File.read(File.expand_path("#{file}", __FILE__)).split("\n")
  end
end

class Plane
  attr_accessor :rows

  def initialize(manifest)
    @rows = (0..manifest.size - 1).to_a
  end

end

bpl = BoardingPassList.new(TEST_FILE)
plane = Plane.new(bpl.manifest)

puts "This plane has #{plane.rows.size} rows."
puts "The manifest reads #{bpl.manifest}"
