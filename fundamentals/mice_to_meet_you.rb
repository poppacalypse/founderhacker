
# WEEK 1 
def get_mice_names(mice)
  arr = []
  mice.each do |mouse|
    arr << mouse.name
  end
  arr
end

# WEEK 2 
def get_names(mice, arr=[])
  mice.each do |mouse|
    arr << mouse.name
  end
  arr
end

# WEEK 3 
def names(mice)
  mice.map do |mouse|
    mouse.name
  end
end

# WEEK 4 
def names(mice)
  mice.map {|mouse| mouse.name}
end

# WEEK 5 
def names(mice)
  mice.map(&:name)
end


