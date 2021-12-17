items = ['apples', 'corn', 'cabbage', 'wheat']

#1 

def gather(items)
  puts "Let's start gathering food."
  yield(items)
  puts "We've finished gathering!"
end

gather(items) do |*items ,item|
  puts items.join(', ')
  puts item
end

# Let's start gathering food.
# apples, corn, cabbage
# wheat
# We've finished gathering!

#2

items = ['apples', 'corn', 'cabbage', 'wheat']

def gather(items)
  puts "Let's start gathering food."
  yield(items)
  puts "We've finished gathering!"
end

gather(items) do |item1, *items, item2|
  puts item1
  puts items.join(', ')
  puts item2
end

# Let's start gathering food.
# apples
# corn, cabbage
# wheat
# We've finished gathering!

#3

items = ['apples', 'corn', 'cabbage', 'wheat']

def gather(items)
  puts "Let's start gathering food."
  yield(items)
  puts "We've finished gathering!"
end

gather(items) do |item, *items|
  puts item
  puts items.join(', ')
end

# Let's start gathering food.
# apples
# corn, cabbage, wheat
# We've finished gathering!

#4

items = ['apples', 'corn', 'cabbage', 'wheat']

def gather(items)
  puts "Let's start gathering food."
  yield(items)
  puts "We've finished gathering!"
end

gather(items) do |item1, item2, item3, item4|
  puts "#{item1}, #{item2}, #{item3}, and #{item4}"
end

# Let's start gathering food.
# apples, corn, cabbage, and wheat
# We've finished gathering!
