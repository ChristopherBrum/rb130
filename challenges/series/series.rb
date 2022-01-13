=begin
Write a program that will take a string of digits and return all the possible
consecutive number series of a specified length in that string.

For example, the string "01234" has the following 3-digit series:

012
123
234

Likewise, here are the 4-digit series:

0123
1234

Finally, if you ask for a 6-digit series from a 5-digit string,
you should throw an error.

##########################

Explicit
- write a program that will return all the consecutive number substring-digits
found within a given integer of a specific length
- if asked for substrings longer than the given string raise an error

Implicit
- constructor method
  - takes a string of numeric characters as an argument

- #slices instance method
  - find all consecutive substrings of a given length
  - iterate through the substrings
    - if the digits are already ordered least to greatest
      - as an array, push to a new array and return

DS
- strings as input
- integers as output
- array to find substrings

Algo(s)
- method --> #slices(integer) --> nested array
  - initialize 'subs' to return value of find_subs(integer)

- helper method --> find_subs(integer) --> array
  - initialize empty arr
  - split string into array of characters
  - iterate through given array of string characters
    - create counter set to 0
    - inisalzie temp_arr to empty array
    - while counter is less than integer passed in
      - push current char to a temp_arr
      - increment index and counter by 1
      - break if counter greater than arr size and if arr element is nil
    - push temp_arr to empty array if temp_arr size equals the given integer
  - return array

=end

class Series
  def initialize(str_number)
    @str_number = str_number
  end

  def slices(sub_size)
    subs = []
    validate_sub_size(sub_size)

    str_number.chars.each_with_index do |_, index|
      temp_arr = group_consecutive(index, sub_size)
      subs << temp_arr if temp_arr.size == sub_size
    end

    subs
  end

  private

  attr_reader :str_number

  def validate_sub_size(sub_size)
    raise(ArgumentError) if sub_size > str_number.size
  end

  def group_consecutive(index, sub_size)
    counter = 0
    temp_arr = []

    while counter < sub_size && !str_number[index].nil?
      temp_arr << str_number[index].to_i
      counter += 1
      index += 1
    end

    temp_arr
  end
end
