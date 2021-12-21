# Introduction to Testing

- [Why do we write tests?](#why-do-we-write-tests)
- [Introduction to Minitest](#introduction-to-minitest)
  - [Vocabulary](#vocabulary)
  - [Whats in the test file](#whats-in-the-test-file)
  - [Reading Testing Output](#reading-testing-output)
  - [Failures](#failures)
  - [Minitest Reporters](#minitest-reporters)
  - [Skipping Tests](#skipping-tests)
  - [Expectation Syntax vs Assertion](#expectation-syntax-vs-assertion)
  - [RSpec vs MiniTest](#rspec-vs-minitest)
  - [Minitest Summary](#minitest-summary)
- [Assertions and refutations](#assertions-and-refutations)
  - [Refutations](#refutations)
- [The general approach for testing](#the-general-approach-for-testing)
  - [SEAT Approach](#seat-approach)
- [Testing equality](#testing-equality)
  - [Equality with a custom class](#equality-with-a-custom-class)
- [Code and test coverage](#code-and-test-coverage)
- [Summary](#summary)

## Why do we write tests

  There are a myriad reasons why we, as developers, write tests for a code. As beginners its safe to safe that we write tests to _prevent regression_. By writing tests we can make changes to our code and avoid having to test everything manually because we already have tests that ensure our code does what its intended to do. Tests can be written before you write your code or after you've written your code. Most likely you will jump back and forth between the two, implementing code and testing code.

  In order to simplify things and avoid throwing lots of confusing terminology around we will refer to the testing we are learning here as **unit testing**.

---

## Introduction to Minitest

**Minitest** can do everything that **RSpec** can, but in a more simple and straightforward way. RSpec goes out of its way to be read like natural English but at the sake of simplicity. RSpec is also a **Domain Specific Language** (DSL) for writing tests. Minitest can use a DSL but can also be used in a way that reads like standard Ruby code.

### Vocabulary

There is a LOT of jargon when it comes to testing but we'll keep things simple for now.

- **Test Suite**: an entire set of tests that are separate from your program. Think of it like _all_ the tests that go with your program.
- **Test**: a situation where a test is run. For instance; this _test_ is going to make sure that you raise an error when you enter your password incorrectly. A test can contain multiple ways of ensuring a piece of code responds appropriately.
  A test can be broken down into smaller pieces as well.
  - **Test Step**: Most basic level of testing. A test step verifies that a certain expectation is satisfied. Test cases employ an assertion.
  - **Test Case**: A set of test steps to collectively test a piece of code/functionality and ensure it behaves as expected.
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
- `require_relative 'car'` points to the file that we will be testing a class from. `require_relative` looks for the Ruby file `car` within the current files(`car_test.rb`) directory. Now when we reference anything from the `car.rb` file in our `car_test.rb` file, Ruby knows where to look.

```ruby
class CarTest < MiniTest::Test
  def test_wheels
    car = Car.new
    assert_equal(4, car.wheels)
  end
end
```

- `class CarTest < MiniTest::Test` here we are creating our _test class_(`CarTest`). By inheriting from `MiniTest::Test` this ensures that we have all the necessary methods for writing tests. The test class should be named the same as the class we are testing with `Test` appended to it for clarification and when possible.
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

### Expectation Syntax vs Assertion

### RSpec vs MiniTest

### Minitest Summary

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

Previously we used `#assert_equal` to test whether or not a new instance of the Car class had  4 wheels. This is the most common assertion but far from the only one.

Sometimes we need to assert something other than equality, for instance whether a certain error is raised, or if an object is of a specific class, or that something is output to standard output (`STDOUT`), or that something is `nil`, etc.

[Here a full list of MiniTest assertions can be found.](http://docs.seattlerb.org/minitest/Minitest/Assertions.html)

| Assertion                          | Description                             |
|------------------------------------|-----------------------------------------|
| `assert_equal(exp, act)`           | Fails unless exp == act.                |
| `assert_nil(obj)`                  | Fails unless obj is nil.                |
| `assert_raises(*exp) { ... }`      | Fails unless block raises one of *exp.  |
| `assert_instance_of(cls, obj)`     | Fails unless obj is an instance of cls. |
| `assert_includes(collection, obj)` | Fails unless collection includes obj.   |

### Refutations

---

## The general approach for testing

### SEAT Approach

With larger projects there are generally 4 steps to writing a test:

1. **S**et up the necessary objects.
2. **E**xecute the code against the object we're testing.
3. **A**ssert the results of the execution.
4. **T**ear down and clean up any lingering artifacts.

We have already been practicing working through steps 2 and 3 by building _test steps_ and _test cases_, but we also have a way to run some code prior to any of the test cases being ran that can then be sued within the tests themselves. This can reduce redundant code and make our test suite more efficient.

By defining a `#setup` before all the test methods within our test class this method will execute and any code within it before each _test case_ is executed, so that any objects or values instantiated/initialized within `#setup` will be the unmodified when passed into a test case. We can use this to open files, or initialize an instance variable that is accessible anywhere within our test class.

```ruby
require 'minitest/autorun'
require_relative 'car'

class CarTest < MiniTest::Test

  def test_car_exists
    car = Car.new
    assert(car)
  end

  def test_wheels
    car = Car.new
    assert_equal(4, car.wheels)
  end
end
```

The above code can be simplified by using a `#setup` method at the top of the class.

```ruby
require 'minitest/autorun'
require_relative 'car'

class CarTest < MiniTest::Test
  
  def setup
    @car = Car.new
  end
    
  def test_car_exists
    assert(@car)
  end

  def test_wheels
    assert_equal(4, @car.wheels)
  end
end
```

This may not seem like much but as your program grows your test suite will grow as well and this can save you a lot of redundant code.

Similar to the `#setup` method we can define a `#teardown` method that will execute after all of your _test cases_. This can be helpful in a number of different ways, like working with a database that connected to within the `#setup` method and can be disconnected from within the `#teardown` method.

```ruby
require 'minitest/autorun'
require 'pg'

class MyApp
  def initialize
    @db = PG.connect 'mydb'
  end
  
  def cleanup
    @db.finish
  end
end

class DatabaseTest < Minitest::Test
  def setup
    @myapp = MyApp.new
  end
  
  def test_that_query_on_empty_database_returns_nothing
    assert_equal 0, @myapp.count
  end
  
  def test_that_query_on_non_empty_database_returns_right_count
    @myapp.create('Abc')
    @myapp.create('Def')
    @myapp.create('Ghi')
    assert_equal 3, @myapp.count
  end
  
  def teardown
    @myapp.cleanup
  end
end
```

Both #setup and #teardown are independent and optional; you can have both, neither, or either one in any test suite.

---

## Testing equality

When using the `#assert_equality` method we are testing for _value equality_, specifically invoking the `#==` method on the object. When using the `#assert_same` method we are testing for _object equality_.

```ruby
require 'minitest/autorun'
require "minitest/reporters"
Minitest::Reporters.use!

require_relative 'car'

class CarTest < MiniTest::Test
  def setup
    @car = Car.new
    @str1 = "hi there"
    @str2 = "hi there"
  end

  def test_value_equality
    assert_equal(@str1, @str2) 
  end
  
  def test_value_same
    assert_same(@str1, @str2)
  end
end
```

When we run this above code we are invoking both `#assert_equal` and `#assert_same` and passing in `@str1` and `@str2` as arguments. The test case of `#test_value_equality` passes, but the test case of `#test_value_same` fails, and within the information output to the terminal it states that `Expected "hi there" (oid=520) to be the same as "hi there" (oid=540).`, which identifies that `#assert_same` is comparing the objects for equality and `#assert_equality` is comparing the objects _values_ for equality.

```ruby
Started with run options --seed 28988

 FAIL CarTest#test_value_same (0.00s)
        Expected "hi there" (oid=520) to be the same as "hi there" (oid=540).
        intro_to_testing/car_test.rb:19:in `test_value_same`

  2/2: [=======================================================] 100% Time: 00:00:00, Time: 00:00:00

Finished in 0.00428s
2 tests, 2 assertions, 1 failures, 0 errors, 0 skips
```

### Equality with a custom class

The above behavior is expected when dealing with String objects, or any other object type built into the Ruby library, but when testing custom class objects we need to define our own custom `#==` method within the class.

```ruby
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
```

The above code when ran on our original `car.rb` file will result in both of our tests failing.

```ruby
Started with run options --seed 55587

 FAIL CarTest#test_value_same (0.00s)
        Expected #<Car:0x00007fb52b1cf7b8 @wheels=4> (oid=520) to be the same as #<Car:0x00007fb52b1cf858 @wheels=4> (oid=540).
        intro_to_testing/car_test.rb:18:in `test_value_same`

 FAIL CarTest#test_value_equality (0.07s)
        No visible difference in the Car#inspect output.
        You should look at the implementation of #== on Car or its members.
        #<Car:0xXXXXXX @wheels=4>
        intro_to_testing/car_test.rb:14:in `test_value_equality'

  2/2: [=======================================================] 100% Time: 00:00:00, Time: 00:00:00

Finished in 0.07824s
2 tests, 2 assertions, 2 failures, 0 errors, 0 skips
```

For the failure on `#test_value_equality`, Ruby is specifically telling us to look at the implementation of the `#==` method within our `Car` class, because it doesn't know how to _assert value equality_ here.

We can define a `Car#==` method to work with our test case.

```ruby
class Car
  attr_accessor :wheels, :name

  def initialize
    @wheels = 4
  end

  def ==(other) # assert_equal would fail without this method
    other.is_a?(Car) && name == other.name
  end
end
```

And then run `#test_value_equality` again. This time `#test_value_equality` passes.

```ruby
Started with run options --seed 2966

 FAIL CarTest#test_value_same (0.00s)
        Expected #<Car:0x00007f983f17fbe0 @wheels=4> (oid=520) to be the same as #<Car:0x00007f983f17fc08 @wheels=4> (oid=540).
        intro_to_testing/car_test.rb:18:in `test_value_same`

  2/2: [=======================================================] 100% Time: 00:00:00, Time: 00:00:00

Finished in 0.00246s
2 tests, 2 assertions, 1 failures, 0 errors, 0 skips
```

Now we can use `#assert_equal` within the `#test_value_equality` test case to effectively determine whether or not the 2 Car objects are considered equal within the context of what we are testing. `#assert_same` will still fail because it is looking at the object ID of the objects passed in, and is therefore will never pass unless we are testing an object against itself.

---

## Code and test coverage

- setup and teardown methods are executed before and after each test method is executed.

---

## Summary

- Minitest is the default testing library that comes with Ruby.
- Minitest tests come in 2 flavors: assert-style and spec-style. Unless you really like RSpec, use assert-style.
- A test suite contains many tests. A test can contain many assertions.
- Use assert_equal liberally, but don't be afraid to look up other assertions when necessary. - - Remember that assert_equal is for asserting value equality as determined by the == method.
- Use the SEAT approach to writing tests.
- Use code coverage as a metric to gauge test quality. (But not the only metric.)
