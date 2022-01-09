=begin
Write some code that converts modern decimal numbers into their Roman number
equivalents.

The Romans were a clever bunch. They conquered most of Europe and ruled it for
hundreds of years. They invented concrete and straight roads and even bikinis.
One thing they never discovered though was the number zero. This made writing
and dating extensive histories of their exploits slightly more challenging, but
the system of numbers they came up with is still in use today. For example the
BBC uses Roman numerals to date their programmes.

The Romans wrote numbers using letters - I, V, X, L, C, D, M. Notice that these
letters have lots of straight lines and are hence easy to hack into stone
tablets.

1   => I
10  => X
7   => VII

There is no need to be able to convert numbers larger than about 3000.
(The Romans themselves didn't tend to go any higher)

Wikipedia says: Modern Roman numerals ... are written by expressing each digit
separately starting with the left most digit and skipping any digit with a
value of zero.

To see this in practice, consider the example of 1990.
In Roman numerals, 1990 is MCMXC:

1000=M
900=CM
90=XC

2008 is written as MMVIII:

2000=MM
8=VIII

Explicit
- write a program that converts modern numbers into roman numerals
- no need to convert numbers greater than 3000

Implicit
- Roman numerals
  - I is 1, !! is 2 ...
  - V is 5, VI is 4 VIII is 8...
  - X is 10, XI is 9, XII is 12...
  - L is 50, LX is 40, LI is 49, LII is 52, LXXVIII is 78...
  - C is 100, CX is 90, CI is 99, CLXVI is 166...
  - D is 500, DC is 400, DXVI is 496, DCCL is 750...
  - M is 1000...

- Program will have a `to_roman` method to convert to roman numeral
- Integer argument passed in at instantiation
- String output from 'to_roman' converts number passed in at instantiation
- getter method for numbers

DS
- strings for roman numberals
- integers for given values
- arrays to manipulate from integer to string
- hash to represent the roman values

Algo(s)
- to_roman
  - initalize an empty array
  - iterate through the numerals hash
    - for each key/value pair create a loop
      - break if given number divided by the key is less than 1
      - subtract the key from the num
      - push the value to the array
  - join the arr to string and return

=end

class RomanNumeral
  NUMERALS = {
    1000 => "M",
    900 => "CM",
    500 => "D",
    400 => "CD",
    100 => "C",
    90 => "XC",
    50 => "L",
    40 => "XL",
    10 => "X",
    9 => "IX",
    5 => "V",
    4 => "IV",
    1 => "I"
  }

  def initialize(number)
    @number = number
  end

  def to_roman
    num = number
    arr = []

    NUMERALS.each do |k, v|
      loop do
        break if num / k < 1
        num -= k
        arr << v
      end
    end

    arr.join
  end

  private

  attr_reader :number
end
