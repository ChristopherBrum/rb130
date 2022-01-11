# rubocop:disable Metrics/LineLength

=begin
Write a program that can generate the lyrics of the 99 Bottles of Beer song.

See the test suite for the entire song.

####################

Explicit
- write a program that can output 99 bottles of beer

Implicit
- class method ::verse takes one integer argument

- class method verses takes two arguments, begin/end of a range

- a class method ::lyrics will output verses 99-0 w/ no arguments

- bottles 99-3 output:
  "(num) bottles of beer on the wall, (num) bottles of beer.\n" \
  "Take one down and pass it around, (num -1) bottles of beer on the wall.\n"

- bottle 2 output:
  "(num) bottles of beer on the wall, (num) bottles of beer.\n" \
  "Take one down and pass it around, (num -1) -->bottle<-- of beer on the wall.\n"

- bottle 1 output:
  "(num) bottle of beer on the wall, (num) bottle of beer.\n" \
  "Take -->it<-- down and pass it around, -->no more<-- bottles of beer on the wall.\n"

- bottle 0 output:
  "-->No more<-- bottles of beer on the wall, -->no more<-- bottles of beer.\n" \
  "-->Go to the store and buy some more<--, (start at 99) bottles of beer on the wall.\n"

DS
- integers ar arguments
- strings as outputs

Algo(s)
- BeerSong::verse(integer) --> string
  - if input is 2
    - "(num) bottles of beer on the wall, (num) bottles of beer.\n" \
      "Take one down and pass it around, (num -1) -->bottle<-- of beer on the wall.\n"
  - if input is 1
    - "(num) bottle of beer on the wall, (num) bottle of beer.\n" \
      "Take -->it<-- down and pass it around, -->no more<-- bottles of beer on the wall.\n"
  - if input is 0
    - "-->No more<-- bottles of beer on the wall, -->no more<-- bottles of beer.\n" \
      "-->Go to the store and buy some more<--, (start at 99) bottles of beer on the wall.\n
  - else
    - "(num) bottles of beer on the wall, (num) bottles of beer.\n" \
      "Take one down and pass it around, (num -1) bottles of beer on the wall.\n"

- BeerSong::verses(integer, integer) --> string

- BeerSong::lyrics --> string

=end

class BeerSong
  def self.two(num)
    "#{num} bottles of beer on the wall, #{num} bottles of beer.\n" \
    "Take one down and pass it around, #{num - 1} bottle of beer on the wall.\n"
  end

  def self.one(num)
    "#{num} bottle of beer on the wall, #{num} bottle of beer.\n" \
    "Take it down and pass it around, no more bottles of beer on the wall.\n"
  end

  def self.zero
    "No more bottles of beer on the wall, no more bottles of beer.\n" \
    "Go to the store and buy some more, 99 bottles of beer on the wall.\n"
  end

  def self.otherwise(num)
    "#{num} bottles of beer on the wall, #{num} bottles of beer.\n" \
    "Take one down and pass it around, #{num - 1} bottles of beer on the wall.\n"
  end

  # rubocop:enable Metrics/LineLength

  def self.verse(num)
    case num
    when 2 then two(num)
    when 1 then one(num)
    when 0 then zero()
    else
      otherwise(num)
    end
  end

  def self.verses(first, last)
    (last..first).to_a.reverse.each_with_object([]) do |num, output|
      output << verse(num)
    end.join("\n")
  end

  def self.lyrics
    verses(99, 0)
  end
end
