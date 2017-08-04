# Do not taunt RubyTestFile(TM)

def sum_to(n)
    return nil if n <= 0
    return 1 if n == 1
    n + sum_to(n - 1)
end

sum_to(5)  # => returns 15
sum_to(1)  # => returns 1
sum_to(9)  # => returns 45
sum_to(-8) # => return nil

def add_numbers(arr)
  return nil if arr.empty?
  return arr[0] if arr.length == 1
  arr.first + add_numbers(arr[1..-1])
end

add_numbers([1,2,3,4]) # => returns 10
add_numbers([3]) # => returns 3
add_numbers([-80,34,7]) # => returns -39
add_numbers([]) # returns nil

def gamma_fnc(arg)
  return nil if arg <= 0
  return 1 if arg <= 2
  factorial(arg - 1)
end

def factorial(arg)
  return 1 if arg <= 1
  arg * factorial(arg - 1)
end

gamma_fnc(0)  # => returns nil
gamma_fnc(1)  # => returns 1
gamma_fnc(4)  # => returns 6
gamma_fnc(8)  # => returns 5040

def ice_cream_shop(array,flavor)
  return false if array.length == 0
  return true if array[0] == flavor
  if array[0] != flavor then ice_cream_shop(array[1..-1],flavor) end
end

ice_cream_shop(['vanilla', 'strawberry'], 'blue moon')  # => returns false
ice_cream_shop(['pistachio', 'green tea', 'chocolate', 'mint chip'], 'green tea')  # => returns true
ice_cream_shop(['cookies n cream', 'blue moon', 'superman', 'honey lavender', 'sea salt caramel'], 'pistachio')  # => returns false
ice_cream_shop(['moose tracks'], 'moose tracks')  # => returns true
ice_cream_shop([], 'honey lavender')  # => returns false

def reverse(arg)
  return arg if arg.length <= 1
  reverse(arg[1..-1]) + arg[0]
end

reverse("house") # => "esuoh"
reverse("dog") # => "god"
reverse("atom") # => "mota"
reverse("q") # => "q"
reverse("id") # => "di"
reverse("") # => ""
