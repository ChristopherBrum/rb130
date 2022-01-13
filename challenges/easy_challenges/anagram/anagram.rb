# Write a program that takes a word and a list of possible anagrams and
# selects the correct sublist that contains the anagrams of the word.

# For example, given the word "listen" and a list of candidates like
# "enlists", "google", "inlets", and "banana", the program should return a list
# containing "inlets".

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
