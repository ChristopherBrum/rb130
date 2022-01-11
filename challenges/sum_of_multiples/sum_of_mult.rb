=begin
Write a program that, given a natural number and a set of one or more other
numbers, can find the sum of all the multiples of the numbers in the set that
are less than the first number. If the set of numbers is not given, use a
default set of 3 and 5.

For instance, if we list all the natural numbers up to, but not including,
20 that are multiples of either 3 or 5, we get 3, 5, 6, 9, 10, 12, 15, and 18.
The sum of these multiples is 78.

#########################

Explicit
- write a program that:
  - takes a number, and a set of numbers
  - finds the sum of all multiples of the set that are less than the first num
  - if no set is given use a default set of 3 and 5

Implicit
- constructor method takes a set of integers as an argument, if no argument
given the set is given a default set of 3 and 5 are assigned

- the class method ::to will take one instance variable
  - will default to a set of [3, 5]

- the instance method #to will take one integer argument and

DS
- integers as input
- integers as output
- range to be used to find divisors
- array to contain divisors

Algo(s)
- method --> #to(integer) --> output
  - initialize an empty array
  - iterate through 1 upto the given integer minus 1
    - if current integer is a multiple of any element of the set
        - push to array
  - find sum of arr and return

=end

class SumOfMultiples
  def initialize(*set)
    @set = set
  end

  def self.to(given_num, set=[3, 5])
    multiples = []

    1.upto(given_num - 1) do |num|
      set.each do |set_element|
        multiples << num if num % set_element == 0
      end
    end

    multiples.empty? ? 0 : multiples.uniq.sum
  end

  def to(given_num)
    SumOfMultiples.to(given_num, set)
  end

  private

  attr_reader :set
end
