file = File.open("input.txt")
input = file.readlines.map(&:chomp)

@mins_array = []
@max_array = []
@letter = []
@code = []

def get_mins(input)
  mins_array = []
  input.each do |i|
    x = i.split('-')[0]
    mins_array << x
  end
  @mins_array ||= mins_array
end

def get_maxes(input)
  max_array = []
  input.each do |i|
    x = i.split('-')[1]
    max_array << x
  end
  max_array2 = []
  max_array.each do |i|
    y = i.split(' ')[0]
    max_array2 << y
  end
  max_array2
end

def get_l(input)
  l_array = []
  input.each do |i|
    x = i.split(' ')[1]
    l_array << x
  end
  l_array2 = []
  l_array.each do |i|
    y = i.split(':')[0]
    l_array2 << y
  end
  l_array2
end

def get_c(input)
  c_array = []
  input.each do |i|
    x = i.split(': ')[1]
    c_array << x
  end
  c_array
end

def compute(mins, maxes, letters, codes)
  input_array = mins.zip(maxes, letters, codes)
  input_array
end

def find_trues(array)
  true_array = []
  array.each do |a|
    a.combination(4).detect do |mins,maxs,letter,code|
      if code.include?(letter) && code_has_min(code, mins, letter) && code_has_max(code, maxs, letter)
      true_array << code
      end
    end
  end
  true_array
end

def code_has_min(c, m, l)
  x = c.scan(l)
  x.size >= m.to_i
end

def code_has_max(c, m, l)
  x = c.scan(l)
  x.size <= m.to_i
end

def detect_trues(array)
  true_array = []
  array.each do |a|
    a.combination(4).detect do |mins,maxs,letter,code|
      if code.include?(letter)
        yes = 0
        if pos_check(code, mins, letter)
          yes + 1
          if pos_check(code, maxs, letter)
            yes + 1
          end
        end
        if yes == 1
          true_array << code
        end
      end
    end
  end
  true_array
end

def detect_trues2(array)
  true_array = []
  array.each do |a|
    a.combination(4).detect do |mins,maxs,letter,code|
      if pos_check(code, maxs, letter)
      true_array << code
      end
    end
  end
  true_array
end

def pos_check(c, p, l)
  pos = p.to_i - 1
  return true if c[pos] == l

  false
end
