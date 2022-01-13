# rubocop:disable Layout/LineLength

=begin
The diamond exercise takes as its input a letter, and outputs it in a diamond
shape. Given a letter, it prints a diamond starting with 'A', with the supplied
letter at the widest point.

The first row contains one 'A'.
The last row contains one 'A'.
All rows, except the first and last, have exactly two identical letters.
The diamond is horizontally symmetric.
The diamond is vertically symmetric.
The diamond has a square shape (width equals height).
The letters form a diamond shape.
The top half has the letters in ascending order.
The bottom half has the letters in descending order.
The four corners (containing the spaces) are triangles.

Examples

Diamond for letter 'A':

A

Diamond for letter 'C':

  A
 B B
C   C
 B B
  A

Diamond for letter 'E':

    A
   B B
  C   C
 D     D
E       E
 D     D
  C   C
   B B
    A

#########################

Explicit
- write a program that will output a symetrical diamond shape
  - It takes a letter character as an input
  - The first row contains one 'A'.
  - The last row contains one 'A'.
  - All rows, except the first and last, have exactly two identical letters.
  - The diamond is horizontally symmetric.
  - The diamond is vertically symmetric.
  - The diamond has a square shape (width equals height).
  - The letters form a diamond shape.
  - The top half has the letters in ascending order.
  - The bottom half has the letters in descending order.
  - The four corners (containing the spaces) are triangles.

Implicit
- write a class method `::make_dimaond` that takes a letter character as an argument
  - letter input will always be a capital letter character
  - each row will be the same length
    - row length will be based on the given letter and how many spaces between their instances
    - first row and last row will contain a single `A`
    - other rows will contain 2 instances of the appropriate letter with:
      - appropriate spaces between the letters
      - appropriate spaces outside of the letters
    - add \n newling character after each letters line in complete
  - The diamond must go from `A` to the given letter and then back to `A`

DS
- strings for input
- integers for measuring spaces
- arrays for finding index and spacing for letters

Algo(s)
- class method --> Diamond::make_diamond(string) --> string
 - save longest line length to `max_length`
 - initialize diamond to an empty array
 - iterate through ALPHA
   - create line and push to diamond
   - when current_leter is reached
     - copy diamond
     - push current_letter line to diamond
     - reverse copy and push to diamond
 - join array and return

- class method --> Diamond::find_max_length --> integer
  - find inner spacing
  - if nil? return 1
  - otherwise return inner spacing + 2

- class method --> Diamond::find_letter_spacing --> integer
 - find current letter and its index in ALPHA
 - if its not 'A' return it index plus (index - 1)
 - if its 'A' return nil

- class method --> Diamond::build_line(string, integer) --> string
  - find letter spacing
  - create string of current letter, whitespace * letter_spacing and current letter
  - current letter is 'A' only one instance is used at the center
  - use center to pad outside of string with whitespace and return

p Diamond.find_max_length('A') == 1
p Diamond.find_max_length('B') == 3
p Diamond.find_max_length('C') == 5
p Diamond.find_max_length('D') == 7
p Diamond.find_max_length('E') == 9

p Diamond.find_inner_spacing('A') == nil
p Diamond.find_inner_spacing('B') == 1
p Diamond.find_inner_spacing('C') == 3
p Diamond.find_inner_spacing('D') == 5
p Diamond.find_inner_spacing('E') == 7
p Diamond.find_inner_spacing('F') == 9

p Diamond.build_line('A', 5) == '  A  '
p Diamond.build_line('B', 7) == '  B B  '
p Diamond.build_line('D', 9) == ' D     D '

puts Diamond.make_diamond('A') == "A\n"
puts Diamond.make_diamond('B') #== " A \nB B\n A \n"
puts Diamond.make_diamond('C') #== "  A  \n"\
                             " B B \n"\
                             "C   C\n"\
                             " B B \n"\
                             "  A  \n"
puts Diamond.make_diamond('E') #== "    A    \n"\
                             "   B B   \n"\
                             "  C   C  \n"\
                             " D     D \n"\
                             "E       E\n"\
                             " D     D \n"\
                             "  C   C  \n"\
                             "   B B   \n"\
                             "    A    \n"

=end

# rubocop:enable Layout/LineLength

class Diamond
  ALPHA = ('A'..'Z').to_a

  def self.make_diamond(given_letter)
    return "A\n" if given_letter == 'A'
    max_length = find_max_length(given_letter)
    diamond = []

    ALPHA.each do |current_letter|
      if current_letter == given_letter
        diamond_dup = diamond.dup
        diamond << build_line(current_letter, max_length)
        diamond << diamond_dup.reverse
        break
      else
        diamond << build_line(current_letter, max_length)
      end
    end

    p diamond.join('')
  end

  def self.find_max_length(given_letter)
    inner_spacing = find_inner_spacing(given_letter)
    return 1 if inner_spacing.nil?
    inner_spacing + 2
  end

  def self.find_inner_spacing(current_letter)
    return nil if current_letter == 'A'
    index = ALPHA.index(current_letter)
    index + (index - 1)
  end

  def self.build_line(current_letter, max_length)
    space = ''
    inner_spacing = find_inner_spacing(current_letter)

    if inner_spacing.nil?
      line = current_letter
    else
      inner_spacing.times { |_| space += ' ' }
      line = current_letter + space + current_letter
    end

    "#{line.center(max_length)}\n"
  end
end
