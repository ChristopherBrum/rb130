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
    - while counter is less than integer passed in
      - push current char to a temp_str
    - push string to empty array
  - return array

- helper method --> filter_subs(array) --> array
  - iterate through array using transformation
    - if sub chars is the same as sub chars sorted?
      - sub split into array of characters converted to integers
    - else
      - nil
  - remove all nil values form array and return

=end