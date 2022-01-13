# STUDY GUIDE

## Blocks

### Closures, binding, and scope

**What is a closure?**\
A closure is a programming concept where you can save a "chunk of code" and execute it at a later time. A closure creates "bindings" with all artifacts within scope of the closure at creation and these bindings can be referenced when the closure is later executed. A closure can be created by a blocks, Proc or lambda.

**What is a binding?**\
During creation of a closure a binding is created around all artifacts(methods, local variables, constants, etc.) that are within scope of the closure. These bindings can be referenced when the closure is executed, even if the artifacts are not within scope at the point of execution. The values associated with the artifacts can also be modified after the closure/binding is created and the updated value will be accessible by the block when invoked.

**What are Proc's and lambdas? How are they different?**\
Proc's and lambdas are both Proc objects that we can use to encapsulate a block of code and bind its surrounding artifacts to be passed around and executed later, but they differ by:

- Proc's have lenient arity and lambdas have strict arity.
- Lambdas cannot use the class method `new` to instantiate a new instance.
- Lambdas have an alternative arrow syntax for creating an instance.
- If explicitly returned from within a method...
  - a lambda will return to the method execution
  - a proc will return out of the method execution

**How do closures interact with variables scope?**\
When a closure is created any artifacts within scope, including variables, will have a binding created with the closure which allows the closure to access the variable when it is executed later in the program, even if the variable is not within scope where the closure is executed. The variable can be updated after the closure is created but before the closure is executed and the closure will have access to this updated value.

### How blocks work, and when we want to use them

**What are blocks?**

- Blocks are chunks of code contained within `do...end` or `{...}`.
- These chunks of code can be passed implicitly into _any_ method invocation as an argument.
- Blocks can also take arguments, by defining _block parameters_.
- Blocks are not objects, so they _cannot_ be assigned to variables and passed around.
- A block will be executed if the `yield` keyword is encountered within the method definition.

```ruby
arr = [1, 2, 3, 4]

arr.select do |num| # 
  num.even?        
end                

# => [2, 4]
```

The block by itself:

```ruby

           do |num| # the block begins at `do` and has 1 block parameter `num`
  num.even?         # code executed when the block is executed
end                 # the block end at `end`
```

**Why do we need blocks?**

Blocks are used for two main purposes:

1. To defer some implementation details to the method caller.
  
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

2. Methods perform some before and after actions/Sandwich code.

    Sometimes a method is written with the purpose of performing a task before and after a chunk of code is executed, for instance; timing the speed of execution. In this situation the _method implementor_ can write a method that performs some functionality before and after yielding to a block that will be passed in by the _method caller_. In this circumstance the block passed in doesn't matter to the method implementor.

**How do we yield to a block?**

- When a block is passed in as an argument at method invocation the block will not be executed unless the   `yield` keyword is called within the method implementation.
- At invocation, the code within the method definition will execute line by line.
- When it encounters the `yield` keyword it _yields_ to the block, meaning the execution of code jumps to the block, then executes the code within the block line by line.
- Once the block has finished executing the block will return the last thing executed.
- Then the code within the method definition will resume executing code after the `yield` keyword.
- `yield` can take arguments that will be passed to the block and assigned to block parameters.

**What's the main difference between blocks and Proc's?**\
A block is not an object but a Proc is, therefore a block cannot be assigned to a variable and passed around. To do so it must be converted to a Proc or lambda.

**What errors and pitfalls can arise from passing in a block at method invocation and how do we avoid them?**

- If the `yield` keyword is used with the intention of yielding to a block passed in as an argument, but not block is passed in, Ruby with throw a `LocalJumpError` when it executes `yield` and can't find a block.
- The `Kernel#block_given?` method can be used in conjunction with a conditional statement to bypass the `yield` keyword is a block has not been passed in at invocation.

- Variable shadowing can occur in situations where the block parameter is the same as a local variable of the same name outside of the block but within scope.

**How do we utilize the return value of a block?**

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

**How can methods that take a block pass pieces of data to that block?**

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

### Understand that methods and blocks can return chunks of code (closures)

### Methods with an explicit block parameter

### Arguments and return values with blocks

### When can you pass a block to a method

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
