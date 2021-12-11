# Building methods that take blocks

Build a "times" method from scratch

```ruby
#method definition
def times(num)
  counter = 0
  
  while counter < num
    yield(counter)
    counter += 1
  end
  
  num
end

# method invocation
# block passed in with #times method is invoked by the yield keyword in the method definition
times(5) do |current_num|
  puts current_num
end

# 0
# 1
# 2
# 3
# 4
# => 5
```

---

Build an "each" method from scratch

```ruby
# Method definition
def each(arr)
  counter = 0
  
  while counter < arr.size
    yield(arr[counter])
    counter += 1
  end
  
  arr
end

# method invocation
# block passed in with #times method is invoked by the yield keyword in the method definition
each([1, 2, 3, 4, 5]) do |element|
  puts element * 2
end
# 2
# 4
# 6
# 8
# 10
# => [1, 2, 3, 4, 5]
```

---

- Build an "select" method from scratch

```ruby
# Method definition
def new_select(arr)
  counter = 0
  new_arr = []
  
  while counter < arr.size
    # return value of block used to check for truthiness
    if yield(arr[counter])
      new_arr << arr[counter]
    end
    
    counter += 1
  end
  
  new_arr
end

array = [1, 2, 3, 4, 5]

# method invocations
# block passed in with #times method is invoked by the yield keyword in the method definition
p new_select(array) { |num| num.odd? } == [1, 3, 5] # true
p new_select(array) { |num| puts num } == [] # outputs 1, 2, 3, 4, 5 and returns true
p new_select(array) { |num| num + 1 } == [1, 2, 3, 4, 5] # true
```

---

Build an "reduce" method from scratch

```ruby
def reduce(arr, default=nil)
  accumulator = (default ? default : arr.first)
  counter = (default ? 0 : 1)
  
  while counter < arr.size
    accumulator = yield(accumulator, arr[counter])
    counter += 1
  end
  
  accumulator
end

array = [1, 2, 3, 4, 5]


p reduce(array) { |acc, num| acc + num } == 15
p reduce(array, 10) { |acc, num| acc + num } == 25
p reduce(['a', 'b', 'c']) { |acc, value| acc += value } == 'abc'
p reduce([[1, 2], ['a', 'b']]) { |acc, value| acc + value } == [1, 2, 'a', 'b']
# p reduce(array) { |acc, num| acc + num if num.odd? }  # => NoMethodError
```

---