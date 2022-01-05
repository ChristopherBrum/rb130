require 'minitest/autorun'

# Write a program that takes a word and a list of possible anagrams and selects the correct sublist that contains the anagrams of the word.

# For example, given the word "listen" and a list of candidates like "enlists", "google", "inlets", and "banana", the program should return a list containing "inlets". Please read the test suite for the exact rules of anagrams.

=begin
program takes a word, and list of possible anagrams
selects correct sublist containingall anagrams

"listen", ["enlists", "google", "inlets", and "banana"]

=> ['inlets']

Implicit Rules:
- anagram: words that have the same letters organized differently
- #match method
  - if no matching strings are in the list, return []
  - if match is found, return all matches in an array
  - multiple matches can be returned in an array
  - duplicate letters cannot be used to determine anagram
  - identical word is not an anagram
  - do not use ordinal values for finding anagrams
  - strings are case insensetive

#match
-sort @word and save to base_word
- perform selective iteration on the list passed in
  - check if current word passed to #sort_letters is equal to base_word 
  
#sort_letters
- downcase string
- split word into characters
- sort characters
- join characters into string and return

=end

class Anagram
  def initialize(word)
    @word = word
  end
  
  def match(list)
    base_word = sort_string(@word)
    selected = list.select { |el| base_word == sort_string(el) }
    selected.select { |word| word.downcase != @word.downcase }
  end
  
  def sort_string(str)
    str.downcase.chars.sort.join
  end
end

class AnagramTest < Minitest::Test
  def test_no_matches
    detector = Anagram.new('diaper')
    assert_equal [], detector.match(%w(hello world zombies pants))
  end
  
  def test_detect_simple_anagram 
    # skip
    detector = Anagram.new('ant')
    anagrams = detector.match(%w(tan stand at))
    assert_equal ['tan'], anagrams
  end

  def test_detect_multiple_anagrams
    # skip
    detector = Anagram.new('master')
    anagrams = detector.match(%w(stream pigeon maters))
    assert_equal %w(maters stream), anagrams.sort
  end

  def test_does_not_confuse_different_duplicates
    # skip
    detector = Anagram.new('galea')
    assert_equal [], detector.match(['eagle'])
  end

  def test_identical_word_is_not_anagram
    # skip
    detector = Anagram.new('corn')
    anagrams = detector.match %w(corn dark Corn rank CORN cron park)
    assert_equal ['cron'], anagrams
  end

  def test_eliminate_anagrams_with_same_checksum
    # skip
    detector = Anagram.new('mass')
    assert_equal [], detector.match(['last'])
  end

  def test_eliminate_anagram_subsets
    # skip
    detector = Anagram.new('good')
    assert_equal [], detector.match(%w(dog goody))
  end

  def test_detect_anagram
    # skip
    detector = Anagram.new('listen')
    anagrams = detector.match %w(enlists google inlets banana)
    assert_equal ['inlets'], anagrams
  end

  def test_multiple_anagrams
    # skip
    detector = Anagram.new('allergy')
    anagrams =
      detector.match %w( gallery ballerina regally clergy largely leading)
    assert_equal %w(gallery largely regally), anagrams.sort
  end

  def test_anagrams_are_case_insensitive
    # skip
    detector = Anagram.new('Orchestra')
    anagrams = detector.match %w(cashregister Carthorse radishes)
    assert_equal ['Carthorse'], anagrams
  end
end