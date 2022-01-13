=begin
Implement octal to decimal conversion. Given an octal input string,
your program should produce a decimal output. Treat invalid input as octal 0.

Note: Implement the conversion yourself. Don't use any built-in or library
methods that perform the necessary conversions for you. In this exercise,
the code necessary to perform the conversion is what we're looking for,

About Octal (Base-8)

Decimal is a base-10 system. A number 233 in base 10 notation can be understood
as a linear combination of powers of 10:

The rightmost digit gets multiplied by 100 = 1
The next digit gets multiplied by 101 = 10
The digit after that gets multiplied by 102 = 100
The digit after that gets multiplied by 103 = 1000
...
The n*th* digit gets multiplied by 10n-1.
All of these values are then summed.

Thus:
  233 # decimal
= 2*10^2 + 3*10^1 + 3*10^0
= 2*100  + 3*10   + 3*1

Octal numbers are similar, but they use a base-8 system. A number 233 in base 8
can be understood as a linear combination of powers of 18:

The rightmost digit gets multiplied by 80 = 1
The next digit gets multiplied by 81 = 8
The digit after that gets multiplied by 82 = 64
The digit after that gets multiplied by 83 = 512
...
The n*th* digit gets multiplied by 8n-1.
All of these values are then summed.

Thus:
  233 # octal
= 2*8^2 + 3*8^1 + 3*8^0
= 2*64  + 3*8   + 3*1
= 128   + 24    + 3
= 155

###############################

Explicit
- write program that implements octal to decimal conversion
- invalid input treated as octal 0
- should take a string and produce a decimal output
- base 10 asnd base 8 are rexplained above

Implicit
- constructor method will take one string argument
- invalid inputs will return 0
- the `to_decimal` instance method will return an integer
- base 8 only uses digits 0-7

DS
- strings for input
- integers for output
- arrays for calculations

Algo(s)
- return 0 unless valid_octal?
- convert given string to integer and split into array of digits
- initialize counter to -1
- initialize decimal_arr
- loop through digits
  - multiply current num by 8 to the power of (absolute value of counter - 1) and
  - push to decimal_arr
  - increment counter
  - break if absolute value of counter less than or equal to array size
- find sum of decimal_arr and return

- valid_octal?
  - only contains digits 0-7?

=end

class Octal
  def initialize(octal)
    @octal = octal
  end

  def to_decimal
    return 0 unless valid_octal?
    octal_arr = octal.chars.map(&:to_i)
    decimal_arr = []
    counter = -1

    while counter.abs <= octal_arr.size
      decimal_arr << octal_arr[counter] * (8**(counter.abs - 1))
      counter -= 1
    end

    decimal_arr.sum
  end

  private

  attr_reader :octal

  def valid_octal?
    !/[^0-7]/.match?(octal)
  end
end
