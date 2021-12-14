require 'minitest/autorun'
require "minitest/reporters"
Minitest::Reporters.use!

require_relative 'car'

class CarTest < MiniTest::Test
  def setup
    @car1 = Car.new
    @car2 = Car.new
  end

  def test_value_equality
    assert_equal(@car1, @car2) 
  end
  
  def test_value_same
    assert_same(@car1, @car2)
  end
end