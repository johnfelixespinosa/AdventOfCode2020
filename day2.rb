class Part1
  def data
    data_file = File.read(File.expand_path("../input.txt", __FILE__)).split("\n")
    data_expanded = data_file.map {|row| row * (row.size + 1)}
    data_expanded
  end

  def check_rows(data)
    tree_rows = []

    data.each_with_index do |row, index|
      if thats_a_tree(row, index)
        tree_rows << row
      end
    end
    tree_rows.size
  end

  def thats_a_tree(row, index)
    tree = "#"
    x_pos = (3 * index)

    row[x_pos] == tree
  end
end
