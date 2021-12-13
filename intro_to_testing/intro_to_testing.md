# Introduction to Testing

## Why do we write tests?

  There are a myriad reasons why we, as developers, write tests for a code. As beginners its safe to safe that we write tests to prevent _regression_. By writing tests we can make changes to our code and avoid having to test everything manually because we already have tests that ensure our code does what its intended to do. Tests can be written before you write your code or after you've written your code. Most likely you will jump back and forth between the two, implementing code and testing code.

  In order to simplify things and avoid throwing lots of confusing terminology around we will refer to the testing we are learning here as **unit testing**.

## Introduction to Minitest

**Minitest** can do everything that **RSpec** can, but in a more simple and straightforward way. RSpec goes out of its way to be read like natural English but at the sake of simplicity. RSpec is also a **Domain Specific Language** (DSL) for writing tests. Minitest can use a DSL but can also be used in a way that reads like standard Ruby code.

### Vocabulary

There is a LOT of jargon when it comes to testing but we'll keep things simple for now.

- **Test Suite**: an entire set of tests that are separate from your program. Think of it like _all_ the tests that go with your program.
- **Test**: a situation where a test is run. For instance; this _test_ is going to make sure that you raise an error when you enter your password incorrectly. A test can contain multiple ways of ensuring a piece of code responds appropriately.
**Assertion**: the actual verification step in which a test confirms that what is returned by your program is what is expected. A test can have one or more assertions.

### Whats in the test file

Using our practice example, lets break down the components of a test.

```ruby
require 'minitest/autorun'

require_relative 'car'

class CarTest < MiniTest::Test
  def test_wheels
    car = Car.new
    assert_equal(4, car.wheels)
  end
end
```

- `require 'minitest/autorun'` the first line loads all the necessary files from the `minitest` gem.
- `require_relative 'car'` ensures points to the file that we will be testing a class from. `require_relative` looks for the Ruby file `car` within the current files(`car_test.rb`) directory. Now when we reference anything from the `car.rb` file in our `car_test.rb` file, Ruby knows where to look.

```ruby
class CarTest < MiniTest::Test
  def test_wheels
    car = Car.new
    assert_equal(4, car.wheels)
  end
end
```

- `class CarTest < MiniTest::Test` here we are creating our _test class_(`CarTest`). By inheriting from `MiniTest::Test` this ensures that we have all the necessary methods for writing tests.
- Within our test class(`CarTest`) we can write instance method that start with `test_` which lets Minitest that these methods are individual tests that need to be run.
- Within each test we need to make some _assertions_. These assertions are what we are trying to verify. Prior to making assertions we must set up some data and/or objects to make assertions against.
- We instantiate a new `Car` object and save it to local variable `car` within the `CarTest#test_wheels` method in order to verify that a newly created `Car` object has `4` wheels.

There a re many different types of assertions but for now we will focus on `assert_equals` which is inherited from `MiniTest::Assertions` takes 2 parameters; the first is the expected value, and the second is the test or actual value. In this case, we instantiate a new Car object, then check to see if it indeed has 4 wheels. Its common to have multiple assertions within one test.

```ruby
assert_equal(4, car.wheels)
```

### Reading Testing Output

### Failures

### Minitest Reporters

### Skipping Tests

### Expectation Syntax

### Summary

- Minitest is an intuitive test library that comes with Ruby.
- Using Minitest is very easy, and you shouldn't be afraid to play around with it.
- Create a test file
- Create a test class by subclassing MiniTest::Test.
- Create a test by creating an instance method that starts with test_.
- Create assertions with assert_equal, and pass it the expected value and the actual value.
- Colorize Minitest output with minitest-reporters
- You can skip tests with skip.
- Minitest comes in two syntax flavors: assertion style and expectation style. The latter is to appease RSpec users, but the former is far more intuitive for beginning Ruby developers.

## Assertions and refutations

| Assertion                          | Description                             |
|------------------------------------|-----------------------------------------|
| `assert_equal(exp, act)`           | Fails unless exp == act.                |
| `assert_nil(obj)`                  | Fails unless obj is nil.                |
| `assert_raises(*exp) { ... }`      | Fails unless block raises one of *exp.  |
| `assert_instance_of(cls, obj)`     | Fails unless obj is an instance of cls. |
| `assert_includes(collection, obj)` | Fails unless collection includes obj.   |

## The general approach for testing

## Testing equality

## Write your first test suite

## Code and test coverage

