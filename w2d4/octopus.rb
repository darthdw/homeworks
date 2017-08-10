# Octopus Problems! :D
#
# Important Fact: Octopi are awesome, and questions concerning them are the best.

# Sluggish Octopus
#
# Find the longest fish in O(n^2) time. Do this by comparing all fish lengths to
# all other fish lengths

# Idea: O(n^2) is Bubble Sort and Nested Loops. Let's nested loop (cause I'm mad
# at bubble sort)

OCEAN = ['fish', 'fiiish', 'fiiiiish', 'fiiiish', 'fffish', 'ffiiiiisshh',
         'fsh', 'fiiiissshhhhhh']

def sluggish_octopus(array)
  meal = ""
  array.each do |fish|
    counter = 0
    while counter < array.length
      if fish.length > meal.length
         meal = fish
      end
    counter += 1
    end
  end
  meal
end

# Dominant Octopus
#
# Find the longest fish in O(n log n) time. Hint: You saw a sorting algorithm
# that runs in O(n log n) in the Sorting Demo. Remember that Big O is classified
# by the dominant term.

# Idea: That's pretty obvious, right? Merge Sort time.

def dominant_octopus(array)
  fish_food = octopus_army(array)
  fish_food.first
end

def octopus_army(array)
  mid = array.length
  left = array.take(mid)
  right = array.drop(mid)

  left_sorted = octopus_army(left)
  right_sorted = octopus_army(right)

  octopus_friend(left_sorted, right_sorted)
end

def octopus_friend(left, right)

  meal_truck = []

  until left.empty? || right.empty?
    meal_truck << ( left.first.length > right.first.length ? left.shift : right.shift )
  end

  meal_truck + left + right
end

# NB: Octopus don't give a damn about a proc.

# Clever Octopus
#
# Find the longest fish in O(n) time. The octopus can hold on to the longest fish
# that you have found so far while stepping through the array only once.

# Weird. Is this just setting a variable, then iterating?

def clever_octopus(array)
  longest = ""
  array.each do |fish|
    if fish.length > longest.length
      longest = fish
    end
  end
  longest
end

# ....This seems too easy.

p clever_octopus(OCEAN)
p sluggish_octopus(OCEAN)
# p dominant_octopus(OCEAN) #Stack overflow. Ugh. Where did I mess up? :/

tiles = ["up", "right-up", "right", "right-down", "down", "left-down", "left",  "left-up" ]

def octopus_dance_one (dir, tiles)
  tiles.each_with_index do |tile, index|
    return index if tile == dir
  end
end

# That's easy enough.

# Different Data Structure is a dead give-away. Hash.

OCTOPUS_DANCE_STEPS = { "up" => 0, "right-up" => 1, "right"=> 2, "right-down" => 3,
    "down" => 4, "left-down" => 5, "left" => 6, "left-up" => 7 }

def octopus_dance_two (dir, tiles)
  tiles[dir]
end
