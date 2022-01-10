=begin
The Greek mathematician Nicomachus devised a classification scheme for natural
numbers (1, 2, 3, ...), identifying each as belonging uniquely to the
categories of abundant, perfect, or deficient based on a comparison between
the number and the sum of its positive divisors (the numbers that can be evenly
divided into the target number with no remainder, excluding the number itself).
For instance, the positive divisors of 15 are 1, 3, and 5. This sum
is known as the Aliquot sum.

Perfect numbers have an Aliquot sum that is equal to the original number.
Abundant numbers have an Aliquot sum that is greater than the original number.
Deficient numbers have an Aliquot sum that is less than the original number.

Examples:

6 is a perfect number since its divisors are 1, 2, and 3, and 1 + 2 + 3 = 6.

28 is a perfect number since its divisors are 1, 2, 4, 7,
and 14 and 1 + 2 + 4 + 7 + 14 = 28.

15 is a deficient number since its divisors are 1, 3, and 5
and 1 + 3 + 5 = 9 which is less than 15.

24 is an abundant number since its divisors are 1, 2, 3, 4, 6, 8,
and 12 and 1 + 2 + 3 + 4 + 6 + 8 + 12 = 36 which is greater than 24.

Prime numbers 7, 13, etc. are always deficient since their only divisor is 1.
Write a program that can tell whether a number is perfect/abundant/deficient.

Explicit
- Write a program that can tell whether a number is perfect/abundant/deficient.
  - Perfect numbers have Aliquot sum that is equal to the original number.
  - Abundant numbers have Aliquot sum that is greater than the original number.
  - Deficient numbers have Aliquot sum that is less than the original number.

Implicit
- create a PerfectNumber class
- class has a class method `PerfectNumber::classify`
  - takes one integer argument
  - will raise an ArgumentError if argument is negative
  - returns 'perfect', 'deficient', or 'abundant' according to the
  aliquot sum of argument

DS
- integer inout
- string output
- array to collect divisors

Algo(s)
- PerfectNumber::classify(integer) --> string
  - initialize empty array
  - raise ArgumentError if given num is negative
  - iterate through all numbers from 1 upto the given number
    - if curent num is a divisor of given num, push to arr
  - if sum of array is equal to given
    - return perfect
  - its less than
    - return deficient
  - if greater than
    -return abundant

=end

class PerfectNumber
  def self.classify(given_num)
    validate_input(given_num)
    sum_of_divisors = sum_divisors(given_num)
    find_category(sum_of_divisors, given_num)
  end

  class << self
    private

    def validate_input(number)
      raise(StandardError) if number < 0
    end

    def sum_divisors(given_num)
      sum = 0

      1.upto(given_num - 1) do |num|
        sum += num if given_num % num == 0
      end

      sum
    end

    def find_category(sum, given_num)
      if sum < given_num
        "deficient"
      elsif sum > given_num
        "abundant"
      else
        "perfect"
      end
    end
  end
end
