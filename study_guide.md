# STUDY GUIDE

- [Blocks](#)
  - [Closures, Binding and Scope](#closures-binding-and-scope)
  - [How blocks work and when we want to use them](#how-blocks-work-and-when-we-want-to-use-them)
  - [Blocks and variable scope](#blocks-and-variable-scope)
  - [Write methods that use blocks and procs](#)
  - [Understand that methods and blocks can return chunks of code (closures)](#)
  - [Methods with an explicit block parameter](#)
  - [Arguments and return values with blocks](#)
  - [When can you pass a block to a method](#)
  - [&:symbol](#)
  - [Arity of blocks and methods](#)
- [Minitest](#)
  - [Testing With** Minitest](#)
  - [Testing terminology](#)
  - [Minitest vs. RSpec](#)
  - [SEAT approach](#)
  - [Assertions](**#)
- [Core Ruby Tools](#)
  - [Core Tools/Packaging Code](#)
  - [Purpose of core tools](#)
  - [Gemfiles](#)

## Blocks

### Closures, binding, and scope

**_Closure_**

- A closure is a programming concept where you can save a "chunk of code" and execute it at a later time.
- A closure creates "bindings" with all artifacts within scope of the closure at creation and these bindings can be referenced when the closure is later executed.
- A closure can be created by a blocks, Proc or lambda.

**_Binding_**

- During the creation of a closure a binding is created around all artifacts(methods, local variables, constants, etc.) that are within scope of the closure.
- These bindings can be referenced when the closure is executed, even if the artifacts are not within scope at the point of execution.
- The values associated with the artifacts can also be modified after the closure/binding is created and the updated value will be accessible by the block when invoked.

**_Scope_**

- The `do..end` or `{..}` that delineates a block also creates a separate inner and outer scope. Objects defined outside of the scope are accessible inside the scope, but object defined inside the scope are not accessible outside.
- Local variables must be defined prior to the creation of a closure to be included in its binding.
- Methods can be defined before or after a closure but before the closure is invoked to be included in its binding, and thus retrievable upon execution.
- Closure allows the artifacts within its binding to be updated after the closure has been created but before the closure is executed.

```ruby
name = 'Chris'

def age 
  25
end

proc_obj = proc { puts "I'm #{name} and I'm #{age}." } # Proc creation

p proc_obj.object_id # 60
proc_obj.call        # I'm Chris and I'm 25. (Proc execution)
  
name = 'Mark'
  
def age
  33
end
  
p proc_obj.object_id # 60
proc_obj.call        # I'm Mark and I'm 33. (Proc execution)
```

### How blocks work and when we want to use them

**_Blocks, Proc's and Lambdas_**

Blocks

- Is not an object.
- Blocks can be implicitly passed to all methods.
- A block will be ignored if:
  - the block is not yielded using the `yield` keyword.
  - the block is not converted to a Proc object
- Blocks can take arguments
  - within the block between the `| |` pipes they're called _block parameters_
  - within the body of the block they're called _block local variables_
- Blocks have lenient arity.
  - no error raised if number of arguments and parameters are not equal.
  - extra parameters will default to `nil`.
  - extra arguments will be ignored.
- Methods that expect a block will raise a `LocalJumpError` if no block is passed to a method invocation.
  - A guard clause can check whether a block has been passed in or not and avoid raising a `LocalJumpError`.
- A block is a way of implementing the idea of a closure. It's an anonymous chunk of code wrapped up in `{..}` or `do..end`.

```ruby
def say_something
  puts "I just wanted to tell you #{yield}"
end

def say_hi
  teacher = "Mrs. Jacob"
  puts yield(teacher) if block_given?
end

say_something { "you're smart." } # I just wanted to tell you you're smart.

say_something # raises LocalJumpError

say_hi { |teacher| "Good morning #{teacher}." } # Good morning Mrs. Jacob.

say_hi { |teacher, friend| "Good morning #{teacher}." } # Good morning Mrs. Jacob.

say_hi { "Good morning teacher." } # Good morning teacher.

say_hi # nil
```

Proc's

- Is an object and has it's own class.
- Is a special type of object that can encapsulate a block, or "chunk of code", within an object to be passed around and executed at a later point.
- Can be assigned to a local variable and passed around.
- Can be returned by a method and reused.
- Blocks have lenient arity.
- When returned from within a method will return out of the method.

```ruby
name = "Chris"
proc1 = proc { puts "Hi there #{name}" }

proc1.call # Hi there Chris
name = "Adrienne"
proc1.call # Hi there Adrienne

proc2 = proc { |age| puts "#{name} is #{age} years old." }

proc2.call # Adrienne is  years old. (no ArgumentError)
proc2.call(25) # Adrienne is 25 years old.
```

Lambdas

- Lambdas are a special type of Proc object that can encapsulate a block and create a closure.
- Is an object but doesn't have it's own class.
- Can be assigned to a variable and passed around.
- Cannot be instantiated with the `::new` class method, but can use arrow syntax.
- Has strict arity.
- When returned from within a method will return to the method.

```ruby
lambda1 = lambda { puts "Hi there" }

lambda2 = -> (name) { puts "My name is #{name}" }

puts lambda1 # #<Proc:0x000055677d485c80 solution.rb:1 (lambda)>
puts lambda2 # #<Proc:0x000055677d485c58 solution.rb:3 (lambda)>
lambda1.call # Hi there
lambda2.call # ArgumentError
lambda2.call("Mitch") # My name is Mitch

```

**_Blocks are used for two main purposes_**

- To defer some implementation details to the method caller.

  The _method implementer_ may choose to write a method definition more generic way, which allows the _method caller_ to customize the functionality of the method by passing in a block at invocation.

```ruby
def each(array)
  array.each { |el| yield(el) }
end

arr = [5, 7, 4, 8, 10]
each(arr) { |element| puts "I'm element #{element}!" }

# I'm element 5!
# I'm element 7!
# I'm element 4!
# I'm element 8!
# I'm element 10!
```

- Methods perform some before and after actions/Sandwich code.

  Sometimes a method is written with the purpose of performing a task before and after a chunk of code is executed, for instance; timing the speed of execution. In this situation the _method implementor_ can write a method that performs some functionality before and after yielding to a block that will be passed in by the _method caller_. In this circumstance the block passed in doesn't matter to the method implementor.

**_Yielding to a block_**

- When a block is passed in as an argument at method invocation the block will not be executed unless the `yield` keyword is called within the method implementation.
- At invocation, the code within the method definition will execute line by line.
- When it encounters the `yield` keyword it _yields_ to the block, meaning the execution of code jumps to the block, then executes the code within the block line by line.
- Once the block has finished executing the block will return the last thing executed.
- Then the code within the method definition will resume executing code after the `yield` keyword.
- `yield` can take arguments that will be passed to the block and assigned to block parameters.

```ruby
def say_something
  puts "I just wanted to say #{yield}"
end

say_something { "that I really have to pee." }
# I just wanted to say that I really have to pee.

def say_something
  quote = "I love you"
  puts "I just wanted to say #{yield(quote)}"
end

say_something do |quote|
  if quote
    quote
  else
    "that I really have to pee."
  end
end

# I just wanted to say I love you.
```

**_Errors/Pitfalls from passing a block at method invocation_**

- If the `yield` keyword is used with the intention of yielding to a block passed in as an argument, but not block is passed in, Ruby with throw a `LocalJumpError` when it executes `yield` and can't find a block.
- The `Kernel#block_given?` method can be used in conjunction with a conditional statement to bypass the `yield` keyword is a block has not been passed in at invocation.

- Variable shadowing can occur in situations where the block parameter is the same as a local variable of the same name outside of the block but within scope.

```ruby
def say_something
  puts "I just wanted to say #{yield}"
end

# say_something # LocalJumpError

def say_something
  if block_given?
    puts "I just wanted to say #{yield}"
  else
    puts "I have nothing to say"
  end
end

say_something # I have nothing to say
```

**_Passing data to a block from within a method_**

- When using the `yield` keyword to execute a block we can pass in arguments.
- These values will be assigned to any block parameters defined within the block.

```ruby
def iterate(array)
  counter = 0
  
  while counter < array.size
    yield(array[counter])
    counter += 1
  end
end

arr = %w(a b c d e)
iterate(arr) { |letter| puts letter.capitalize * 5 }

# AAAAA
# BBBBB
# CCCCC
# DDDDD
# EEEEE
```

### Blocks and variable scope

- Blocks create a new inner scope, so any variable initialized within it cannot be accessed outside of the block.
- Variables defined prior to the block not within a different inner scope are accessible within the block.
- This is the scope by which closures use to create bindings without outside artifacts.

### Write methods that use blocks and proc's



**_Block and Proc Differences_**

- A block is not an object but a Proc is.
- Therefore a block cannot be assigned to a variable and passed around.
- To do so it must be converted to a Proc or lambda.

**_Proc and Lambda Differences_**

Proc's and lambdas are both Proc objects that we can use to encapsulate a block of code and bind its surrounding artifacts to be passed around and executed later, but they differ by:

- Proc's have lenient arity and lambdas have strict arity.
- Lambdas cannot use the class method `new` to instantiate a new instance.
- Lambdas have an alternative arrow syntax for creating an instance.
- If explicitly returned from within a method...
  - a lambda will return to the method execution
  - a proc will return out of the method execution

### Understand that methods and blocks can return chunks of code (closures)

**_Utilizing the return value of a block_**

- Blocks return the last evaluated expression within itself.
- Therefore, if yielding to a block with the `yield` keyword, the return value of the block can be captured by a variable initialized to its return value.

```ruby
def add_title(name)
  title = yield.capitalize + ' ' 
  title + name
end

p add_title('Chris Brum') { 'mr' }

# Mr. Chris Brum
```

**_Utilizing the return value of a Proc or Lambda_**

### Methods with an explicit block parameter

- To make a method take an explicit block the unary & operator (`&`) must prepend a method parameter name in the method definition.
- The unary & operator used in the method definition will take a block passed in as an argument and convert it a `Proc` object and initialize it to the method parameter.
- The unary and only needs to prepend the method parameter, it does not need to prepend the variable when used within the method body.
- If an explicit block is defined in a method definition but not block is passed in the parameter will be defined to `nil`.

```ruby
def call_me (&some_code)
  some_code
end

p call_me # outputs nil

def call_again (&some_code)
  some_code.call
end

# p call_last # NoMethodError: undefined method `call' for nil:NilClass

def call_last (&some_code)
  puts "method call"
  puts some_code
  some_code.call
end

call_last { puts "block called" }
# method call
# #<Proc:0x000055b292b55eb0 solution.rb:19>
# block called
# => nil
```

### Arguments and return values with blocks

- Blocks have _lenient arity_, which means an error will not be raised if the number of arguments and parameters do not match.
- 

### When can you pass a block to a method

All methods in Ruby can take an implicit block.

### &:symbol

### Arity of blocks and methods

**What is arity?**
Arity refers to the rules regarding the number of arguments that must be passed to a block, Porc, or lambda.

- Lenient Arity(blocks and Procs): Ruby will not raise an error if the number of arguments passed in doesn't match the number of paremeters defined. Any parameters that do not have an argument passed to them will reference `nil`.
- Strict Arity(methods & lambdas): Ruby will raise an ArgumentError if the number of arguments passed to a method or lambda doen not match the number of parameters defined.

---

## Testing With Minitest

### Testing terminology

### Minitest vs. RSpec

### SEAT approach

### Assertions

---

## Core Tools/Packaging Code

### Purpose of core tools

### Gemfiles

What is Symbol#to_proc and how is it used?
How do we specific a block argument explicitly?
How can we return a Proc from a method or block?
What is arity? What kinds of things in Ruby exhibit arity? Give explicit examples.
