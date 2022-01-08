# Write a program that can generate the lyrics of the 99 Bottles of Beer song. 
# See the test suite for the entire song.

# - explicit

# - implicit
#   #verse
#     - if num = 1 => use singular bottle in the string
#     - num > 1 or == 0 plural of bottle => bottles
#     - no negative numbers allowed
#     - counting down (decrementing)
#     - interpolation is required
#     - when the argument is 0
#       return 
#         "No more bottles of beer on the wall, no more bottles of beer.\n" \
#         "Go to the store and buy some more, 99 bottles of beer on the wall.\n"
    
#   #verses
#     - based on range between the two argument
#     - 
#     - 

# Examples
#   - BeerSong.verse(99)
#     "99 bottles of beer on the wall, 99 bottles of beer.\n" \
#     "Take one down and pass it around, 98 bottles of beer on the wall.\n"
    
#     # the second line has one bottle less
    
#   - BeerSong.verse(1)
#   "1 bottle of beer on the wall, 1 bottle of beer.\n" \
#   "Take it down and pass it around, no more bottles of beer on the wall.\n"
    
#     # use bottle in the firstline and new string in the second line
  
#   -  BeerSong.verse(0)
#   "No more bottles of beer on the wall, no more bottles of beer.\n" \
#   "Go to the store and buy some more, 99 bottles of beer on the wall.\n"

# Data structure
#   - Integer --------> string, array

# Algorithm
# ---
#   - self.verse(number)
#     if number < 1
#       "No more bottles of beer on the wall, no more bottles of beer.\n" \
#       "Go to the store and buy some more, 99 bottles of beer on the wall.\n"
#     elsif number == 1
#       "1 bottle of beer on the wall, 1 bottle of beer.\n" \
#       "Take it down and pass it around, no more bottles of beer on the wall.\n"
#     else
#       "#{number} bottles of beer on the wall, 99 bottles of beer.\n" \
#       "Take one down and pass it around, #{number - 1} bottles of beer on the wall.\n"
#     end
  
#   - self.verses(num1, num2)
#     - initialize string_array = []
#     - initialize arr = create a range from num1 .... num2 and store the collection in an array
#     - iterate over arr and for each `number` do 
#       - string_array << self.verse(number)
#     - join("\n") 
    
#   - self.lyrics
#     - self.verses(99, 0)

# <<-HEREDOC
# 1 bottle of beer on the wall, 1 bottle of beer.
# Take it down and pass it around, no more bottles of beer on the wall.

# 1 bottle of beer on the wall, 1 bottle of beer.
# Take it down and pass it around, no more bottles of beer on the wall.
# HEREDOC
  
# class BeerSong
  
#   def self.verse(number)
#     if number < 1
#       "No more bottles of beer on the wall, no more bottles of beer.\n" \
#       "Go to the store and buy some more, 99 bottles of beer on the wall.\n"
#     elsif number == 1
#       "1 bottle of beer on the wall, 1 bottle of beer.\n" \
#       "Take it down and pass it around, no more bottles of beer on the wall.\n"
#     elsif number == 2
#       "#{number} bottles of beer on the wall, #{number} bottles of beer.\n" \
#       "Take one down and pass it around, #{number - 1} bottle of beer on the wall.\n"
#     else
#       "#{number} bottles of beer on the wall, #{number} bottles of beer.\n" \
#       "Take one down and pass it around, #{number - 1} bottles of beer on the wall.\n"
#     end
#   end
  
#   def self.verses(num1, num2)
#     (num2..num1).to_a.reverse.each_with_object([]) do |num, output|
#       output << BeerSong.verse(num)
#     end.join("\n")
#   end
  
#   def self.lyrics
#     BeerSong.verses(99, 0)
#   end
# end

class BeerSong
  def self.lesser_than_one
    "No more bottles of beer on the wall, no more bottles of beer.\n" \
    "Go to the store and buy some more, 99 bottles of beer on the wall.\n"
  end
  
  def self.equal_to_one
    "1 bottle of beer on the wall, 1 bottle of beer.\n" \
    "Take it down and pass it around, no more bottles of beer on the wall.\n"
  end
  
  def self.equal_to_two
    "2 bottles of beer on the wall, 2 bottles of beer.\n" \
    "Take one down and pass it around, 1 bottle of beer on the wall.\n"
  end
  
  def self.otherwise(number)
    "#{number} bottles of beer on the wall, #{number} bottles of beer.\n" \
    "Take one down and pass it around, #{number - 1} bottles of beer on the wall.\n"
  end
  
  def self.verse(number)
    if number < 1
      lesser_than_one
    elsif number == 1
      equal_to_one
    elsif number == 2
      equal_to_two
    else
      otherwise(number)
    end
  end
  
  def self.verses(num1, num2)
    (num2..num1).to_a.reverse.each_with_object([]) do |num, output|
      output << verse(num)
    end.join("\n")
  end
  
  def self.lyrics
    verses(99, 0)
  end
end

