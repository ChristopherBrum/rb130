# Write a program to determine whether a triangle is:
# equilateral, isosceles, or scalene.

# An equilateral triangle has all three sides the same length.

# An isosceles triangle has exactly two sides of the same length.

# A scalene triangle has all sides of different lengths.

# Note: For a shape to be a triangle at all, all sides must be of length > 0,
# and the sum of the lengths of any two sides must be greater than the length
# of the third side.

# Explicit
# - write a program to determine if a triangle is equilateral/isosceles/scalene
#   - equilateral triangle has all three sides the same length.
#   - isosceles triangle has exactly two sides of the same length.
#   - scalene triangle has all sides of different lengths.
# - all sides must be > 0
# - sum of any 2 sides must be greater than 3rd side

# Implicit
# - program has an instance method named 'kind'
#   - returns string objetc 'equilateral` if all sides are the same
#   - returns string object 'isoscelees' if 2 sides are the same
#   - returns string object 'scalene' if no sides are the same
#   - takes 3 arguments, either integer or float objects

# - instantiation of a new object will raise an error if:
#   - any of the length arguments is 0
#   - any of the length arguments is negative
#   - any two sides are less than or equal to the 3rd

# DS
# - integers and floats as input
# - string outputs or errors raised
# - arrays to iterate through side lengths

# Algo(s)
# - method to validate if side lengths are valid
#   -

# - #kind method determines the kind of triangle
#   - push side1, side2, and side3 to an array (sides)
#   - return 'eqilateral' if #equilateral is truthy
#   - return 'isosccales' if #isoscales is truthy
#   - return 'scalene' is #scalene is truthy

# - #equilateral?
#   - are all sides are the same?

# - #isoscales?
#   - are exactly 2 sides the same?

class Triangle
  def initialize(side1, side2, side3)
    @sides = [side1, side2, side3]
    validate_sides
  end

  def kind
    if equilateral?
      'equilateral'
    elsif isosceles?
      'isosceles'
    else
      'scalene'
    end
  end

  private

  attr_reader :sides

  def validate_sides
    raise(ArgumentError) if side_length_zero_or_neg? ||
                            two_sides_shorter_than_one?
  end

  def side_length_zero_or_neg?
    sides.any? { |side| side <= 0 }
  end

  def two_sides_shorter_than_one?
    length_of_two_sides = sides.combination(2).to_a.map(&:sum)
    counter = sides.size - 1

    length_of_two_sides.each do |two_sides|
      return true if two_sides <= sides[counter]
      counter -= 1
    end

    false
  end

  def equilateral?
    base = sides.first
    sides.all? { |side| base == side }
  end

  def isosceles?
    sides.uniq.size == 2
  end
end
