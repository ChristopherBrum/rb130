=begin
Write a program that, given a word, computes the Scrabble score for that word.

Letter Values
You'll need the following tile scores:

Letter	                         Value
A, E, I, O, U, L, N, R, S, T -->	1
D, G                         -->  2
B, C, M, P	                 -->  3
F, H, V, W, Y	               -->  4
K	                           -->  5
J, X	                       -->  8
Q, Z	                       -->  10

How to Score
Sum the values of all the tiles used in each word. For instance,
the word CABBAGE has the following letters and point values:

3 points for C
1 point for each A (there are two)
3 points for B (there are two)
2 points for G
1 point for E

Thus, to compute the final total (14 points), we count:

3 + 2*1 + 2*3 + 2 + 1
=> 3 + 2 + 6 + 3
=> 5 + 9
=> 14

Explicit
- Program will compute the scrabble score for a given word
- Find the score of each letter in the givven word
- then find the sum of all of the letter scores, and return value

Implicit
- the constructor method method will take one argument

- write an instance method `score` that returns the scrabble score of the
object passed in at instantiation
- an empty string will return 0
- a string containing only whitespace will return 0
- a nil object will return 0
- characters are case insensitive

DS
- string values passed in
- nil objects may be encountered
- hash for containing scores of different letters
- array for splitting string into individual characters
- integer output and score

Algo(s)
- constructor method
  - takes in one argument, generally a string

- SCORES constant will hold the scoring information in a hash

- ::score class method w/ one parameter
  - initialize word_score to 0
  - upcase the given word
  - split given word into an array of characters
  - iterate through the array
    - iterate through the SCORES hash
      - find current letter in value of SCORES and add the key to word_score
  - return word_score

  - #score --> instance method --> integer output
    - invoke the Scrabble::score method and pass in scrabble_word as an argument

=end

class Scrabble
  SCORES = {
    1 => ['A', 'E', 'I', 'O', 'U', 'L', 'N', 'R', 'S', 'T'],
    2 => ['D', 'G'],
    3 => ['B', 'C', 'M', 'P'],
    4 => ['F', 'H', 'V', 'W', 'Y'],
    5 => ['K'],
    8 => ['J', 'X'],
    10 => ['Q', 'Z']
  }

  def initialize(scrabble_word)
    @scrabble_word = scrabble_word
  end

  def self.score(word)
    word_score = 0
    return word_score if word.class != String

    word.upcase.chars.each do |letter|
      SCORES.each do |score, letters|
        word_score += score if letters.include?(letter)
      end
    end

    word_score
  end

  def score
    Scrabble.score(scrabble_word)
  end

  private

  attr_reader :scrabble_word
end
