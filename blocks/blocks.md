# Blocks

- [Closures in Ruby](#closures-in-ruby)
  - [Closures](#closures)
  - [Blocks Procs and Lambdas](#blocks-procs-and-lambdas)
- [Calling methods with blocks](#calling-methods-with-blocks)
- [Writing methods that take blocks](#writing-methods-that-take-blocks)
  - [Yielding](#yielding)
  - [LocalJumpError](#localjumperror)
  - [Making yield optional](#making-yield-optional)
  - [Yielding to the block](#yielding-to-the-block)
  - [Yielding with an Argument](#yielding-with-an-Argument)
  - [Block parameter vs Block local variable](#block-parameter-vs-block-local-variable)
  - [Arguments passed to a block vs passed to a method](#arguments-passed-to-a-block-vs-passed-to-a-method)
  - [Arity](#arity)
  - [Return value of yielding to the block](#return-value-of-yielding-to-the-block)
  - [When to use blocks in your own methods](#when-to-use-blocks-in-your-own-methods)
    - [Defer some implementation details til invocation](#defer-some-implementation-details-til-invocation)
    - [Before and After action: Sandwich Code](#sandwich-code)
  - [Methods with an explicit block parameter](#methods-with-an-explicit-block-parameter)
  - [Using closures](#using-closures)
- [Key Points](#key-points)
- [Blocks and variable scope](#blocks-and-variable-scope)
  - [Refreshing our understanding of local variable scope](#refreshing-our-understanding-of-local-variable-scope)
  - [Closure and Binding](#closure-and-Binding)
- [symbol to proc](#symbol-to-proc)
- [Summary of Concepts](#summary-of-concepts)
- [Build a todo list](#build-a-todo-list)
- [Questions](#questions)

---

## Closures in Ruby

### Closures

**Closures** are a programming concepts of encapsulating a "chunk of code" together that can be saved, passed around and executed at a later time/place. Closures **bind** to surrounding artifacts (ie. variables, methods, constants) and create an enclosure around everything so that it can be referenced when the closure is later executed. A closure retains access to variables within its binding _rather than_ the specific values of those variables at the time the closure was created; so if the value of those variables changes, the closure accesses the new values, even if the closure is executed somewhere out of the scope of it's bindings/variables.

- Closures are created using a Proc object, lambda or a block.
- They can be thought of like a method that can be passed around and executed but is not named.
- A Ruby method is not a closure.

### Blocks, Procs and Lambdas

A **block** is a piece of code enclosed with a `do..end` or a `{..}` and are very common in Ruby. Every method in Ruby can be passed an implicit block and when a block is included with a method invocation it can provide more specific functionality. Blocks can also take in parameters. A block is not the same as a method implementation, these are two separate things. A block is passed in as an argument to a invoked method and the method implementation dictates what is done with it.

```ruby
arr = [1, 2, 3, 4, 5]

arr.each do |number|
  puts number * 10
end

arr.each { |number| number * 10 }

# the do..end delineate the block passed into the #each method as an argument
         do |number| 
  puts number * 10
end
# or the {..}
         { |number| number * 10 }
```

A **Proc** object is a way of capturing a block within an object. This allows us to assign the Proc object to a variable, pass it around and execute it elsewhere in a program. When creating a new Proc object you pass it a block as an argument.

```ruby
my_first_proc = Proc.new { puts "I'm a proc object!" }
puts my_first_proc #<Proc:0x0000559223e877a8 solution.rb:1>
```

A **Lambda** is another way to define and save a block with a special syntax.

```ruby
baby_lambda = -> { puts "I'm a lil baby lambda" }
baby_lambda.call # I'm a lil baby lambda
puts baby_lambda #<Proc:0x00005566ff7db228 solution.rb:1 (lambda)>
```

---

## Calling methods with blocks

Code we wrote in a block is not the method implementation -- in fact, that code has nothing to do with the method implementation. The entire block is passed in to a method like any other argument, and it's up to the method implementation to decide what to do with the block that you passed in. The method could take that block and execute it, or just as likely, it could completely ignore it -- it's up to the method implementation to decide what to do with the block of code given to it.

---

## Writing methods that take blocks

In Ruby, every method can take an optional block as an _implicit parameter_. The block can simply be added to the end of the method invocation and the method will decide what, if anything, to do with it.

```ruby
def say_hi(greeting)
  greeting
end

p say_hi                                        # ArgumentError: wrong number of arguments (given 0, expected 1)
p say_hi('Hi there')                            # Hi there
p say_hi('Merry', 'Christmas')                  # ArgumentError: wrong number of arguments (given 2, expected 1)

p say_hi { puts "BLOCK" }                       # ArgumentError: wrong number of arguments (given 0, expected 1)
p say_hi('Hi there') { puts "BLOCK" }           # Hi there
p say_hi('Merry', 'Christmas') { puts "BLOCK" } # ArgumentError: wrong number of arguments (given 2, expected 1)
```

### Yielding

The `yield` keyword is used to execute a block that has been passed in as an argument at method invocation. When the program encounters the `yield` keyword it looks for a block passed in at method invocation and them _jumps_ to that block and executes the code within it. A block returns the last expression evaluated within it, therefore, that return value is returned by `yield`, which can be utilized if desired.

By having a method that takes a block in as an argument it allows some of the functionality of the method to be decided by the programmer whom is invoking the method. THis allows us to write more generic methods that allow some of the specifics to be decided at invocation which makes our program much more flexible.

```ruby
def say_hi
  yield
end

say_hi { puts "Method execution yields to the block" } # Method execution yields to the block
```

### LocalJumpError

If the `yield` keyword is executed within a method definition but no block was passed in during invocation a `LocalJumpError` will be raised.

```ruby
def say_hi
  yield
end

say_hi # LocalJumpError: no block given (yield)
```

This demonstrates that if no block is passed to a method invocation and `yield` is present within the method implementation, Ruby will raise an error.

### Making yield optional

Ruby gives us a method that can aide in this situation, the `Kernel#block_given?` method. This method will return a boolean value based on whether a block has been passed in as an argument at method invocation or not. It can be utilized within a conditional statement to avoid raising a `LocalJumpError` unnecessarily.

```ruby
def say_hi
  yield if block_given?
end

say_hi # => nil
say_hi { puts "Method execution yields to the block" } # Method execution yields to the block
```

In both cases, the `Kernel#block_given?` method is invoked by calling `#say_hi`. The first invocation evaluates `Kernel#block_given?` to false because no block was passed in as an argument, therefore `yield` is not executed and `nil` is returned by `#say_hi` because the conditional was the last expression evaluated in the method. The next invocation has a block passed in as an _implicit_ argument, so `Kernel#block_given` evaluates to true and `yield` _yields_ to the block, which outputs `Method execution yields to the block`.

### Yielding to the block

When a block is passed to a method invocation as an argument and the `yield` keyword is called within the method implementation the code 'jumps' from the code being executed within the method definition to the block, and executes the code within the block before jumping back to the code being executed within the method definition.

### Yielding with an Argument

Sometimes a block requires an argument, even though a block itself it an argument being passed to a method invocation. The variable enclosed within the two pipes (`|num|`) is the _block parameter_, which will have a value assigned to it when the `yield` keyword is invoked with an argument passed to it within the method implementation (this implementation is done behind the scenes within the method definition of `Integer#times`).

```ruby
3.times { |num| puts num }
```

In the code above;

- `3` is the calling object.
- `.times` is the method being called/invoked.
- `{ |num| puts num }` is the block being passed in as an argument.
- `|num|` is the block parameter.
- `num` within the block is a _block local variable_.

### Block parameter vs Block local variable

?????

### Arguments passed to a block vs passed to a method

When passing in arguments to a method at invocation the number of arguments must match the expected number of arguments within the method definition or else raise an error, but with block parameters that is not the case. If _more_ arguments are passed in with the `yield` keyword than are defined within the block, no error is thrown. And if _less_ arguments are passed in with the `yield` keyword than are defined within the block, no error is thrown and the block parameters that have not had a value assigned to them will have a `nil` as a value.

### Arity

Rules regarding the numbers of arguments that must be passed to a block, Proc object or a lambda in Ruby is referred to as **arity**. Blocks and Procs have _lenient arity_ in Ruby, which means no errors will be raised if the number of arguments passed to the block does not match the number of block parameters. Methods and lambdas have **strict arity**, which means the number of arguments passed to them must match the number of arguments that they are expecting, else they will throw an error.

- **Lenient Arity**: blocks and procs
- **Strict Arity**: methods and lambdas

```ruby
# lenient arity
def say_hi
  yield(1)
end

say_hi { |x, y| puts "x is: #{x}, y is: #{y}" } # x is: 1, y is: 
say_hi { puts "No block parameters" } # No block parameters

# strict arity
def say_bye(name)
  puts "Goodbye #{name}"
end

say_bye                  # ArgumentError: wrong number of arguments (given 0, expected 1)
say_bye('Chris', 'Mike') # ArgumentError: wrong number of arguments (given 2, expected 1)
```

### Return value of yielding to the block

A block returns the last expression evaluated within it just like normal methods, therefore, that return value is returned by the `yield` keyword, which can be utilized if desired. It is also important to note that just like normal methods a block can mutate an argument passed into it with a destructive method call.

```ruby
def say_hi(name)
  puts name # Christopher
  block_return = yield(name)
  puts block_return # CHRISTOPHER
end

say_hi('Christopher') do |name|
  name.upcase! # mutates the argument passed in and returns it => CHRISTOPHER
end
```

### When to use blocks in your own methods

While building programs there comes a time when a decision must be made on where a block makes sense to be utilized as an argument passed into a method invocation. There are two main cases for this:

#### Defer some implementation details til invocation

With every method there are tow main players; the **method implementor** and the **method caller**. There are certain situations when writing a method where you won't know exactly how the method caller will want to utilize a method. By writing a method with that idea in mind you can allow for different inputs passed in by the method caller (ie. blocks) to still perform a specific action, the final _implementation_ details are deferred to the _method caller_. We see this all the time with methods like `#select`, where the method caller will pass in a block that serves their specific needs and the `#select` method takes in that unique block and implements the functionality specific to the `#select` method. This gives us great flexibility by having methods that are serve one purpose but can serve this purpose based on what the method caller is passing into it.

In this case the method implementor is concerned with the code passed in by the method caller because the way the method is defined will dictate whether or not the code passed in will function appropriately.

#### Sandwich Code

Sandwich code is the idea that the _method caller_ will pass in a block to a piece of code and that block will be _sandwiched_ between 'before' and 'after' functionality. In this case the method implementor is not concerned with what the method caller is passing in, only that the chunk of code that is passed in will be sandwiched between bits of functionality created by the implementor. Sandwich code can be useful for the purposes of timing pieces of code to test efficiency or in resource management and freeing up resources, that could otherwise cause crashes and memory leaks (ie. big problems). See the `File::open` class method.

In this case the method implementor in not concerned with what code is passed in by the method caller, only that their method performs some action before and after the method yields to the block.

### Methods with an explicit block parameter

By default block parameters are implicitly passed to a method at invocation but Ruby gives us a way to _explicitly_ pass a block a method and have is assigned to a method parameter to be passed around and executed as needed within the method body. By defining a method parameter in a method definition with the `unary & operator` (`&`) at the beginning you are telling Ruby that this method, when invoked, will have a block passed in and that block will be saved to this parameter. The `&` is only required in front of the parameter name and not within the method definition body.

What `&` is doing is converting the block passed in at invocation into a `Proc` object, which is essentially a way of encapsulating a block into an object that can then be passed around and called. The `Proc#call` method is used to execute the block and arguments can be passed into the block. If an explicit method is called for but no block is passed in at method invocation a `NoMethodError` will be raised.

```ruby
def say_hi(name, &chunk) # & calls for an explicit block and saves it to the method parameter chunk
  chunk.call(name)       # use the #call method to execute the block and pass in one argument
end

say_hi('Chris') do |name|
  puts "Hello #{name}"   # outputs Hello Chris
end

say_hi('Chris')          # NoMethodError: undefined method `call' for nil:NilClass
```

### Using closures

Closures retain a memory of their surrounding scope and this allows them access to variables, methods, constants, etc. which can be referenced or even updated when the closure is executed, even if these things are not within scope where the closure is executed.

```ruby
name = 'Chris'

proc1 = Proc.new { puts "Hi there #{name}" }
proc2 = Proc.new { puts "I'm avoiding #{name}" }

proc1.call # Hi there Chris
proc2.call # I'm avoiding Chris

name = 'Maria'

# calling proc1 and proc2 here shows that name has been reassigned to 'Maria' because the reassignment of name is now within scope of proc1 and proc2 below. 
proc1.call # Hi there Maria
proc2.call # I'm avoiding Maria
```

Variables must be defined above a closure in order to be in scope.

```ruby
name = 'Maria'

proc1 = Proc.new { puts "Hi there #{name}" }
proc2 = Proc.new { puts "I'm avoiding #{name}" }

proc1.call # Hi there Maria
proc2.call # I'm avoiding Maria

```

```ruby
proc1 = Proc.new { puts "Hi there #{name}" }
proc2 = Proc.new { puts "I'm avoiding #{name}" }

name = 'Maria'

proc1.call # NameError: undefined local variable or method `name' for main:Object
proc2.call # NameError: undefined local variable or method `name' for main:Object
```

Method definitions can be defined after a closure is defined but must be defined before a closure is called.

```ruby
proc1 = Proc.new { puts "Hi there #{name}" }
proc2 = Proc.new { puts "I'm avoiding #{name}" }

def name
  "Dr. Doogie Hauser"
end

proc1.call # Hi there Dr. Doogie Hauser
proc2.call # I'm avoiding Dr. Doogie Hauser
```

```ruby
proc1 = Proc.new { puts "Hi there #{name}" }
proc2 = Proc.new { puts "I'm avoiding #{name}" }

proc1.call # NameError: undefined local variable or method `name' for main:Object
proc2.call # NameError: undefined local variable or method `name' for main:Object

def name
  "Dr. Doogie Hauser"
end
```

---

## Key Points

- blocks are one way that Ruby implements closures. Closures are a way to pass around an unnamed "chunk of code" to be executed later.
- blocks can take arguments, just like normal methods. But unlike normal methods, it won't complain about wrong number of arguments passed to it.
- blocks return a value, just like normal methods.
- blocks are a way to defer some implementation decisions to method invocation time. It allows method callers to refine a method at invocation time for a specific use case. It allows method implementors to build generic methods that can be used in a variety of ways.
- blocks are a good use case for "sandwich code" scenarios, like closing a File automatically.
- methods and blocks can return a chunk of code by returning a Proc or lambda.

---

## Blocks and variable scope

### Refreshing our understanding of local variable scope

Local variables are scoped based on where they are initialized and we think of where they are initialized in terms of _inner_ and _outer_ scope. With a block local variables defined outside of the block are accessible within the block but local variables defined within the block are not accessible outside of the block. Therefore a block creates a new scope for local variables. This is referring only to local variables, sometimes invoking methods will look exactly the same as invoking a local variable when there is no parenthesis. It's important to look to where the local variable was initialized in order to define its scope, and make sure it is a local variable and not a method invocation that you're dealing with.

### Closure and Binding

In Ruby the idea of a closure is implemented by saving a chunk of code so that it can be passed around an executed at a later time and place.

> _In order for a block to actually be passed around and executed a later time/place it must be encapsulated within a Proc or lambda._

If we want to get technical; a block by itself is not actually a closure, but when encapsulated within a Proc or a lambda a closure is created.  For the purposes of discussing closures in Ruby though, it's easier just to think of blocks as closures. When a closure is created all artifacts within its scope can be have a binding created to the closure so that these artifacts can be utilized when the closure is executed.

```ruby
name = "Chris"

chunk_of_code = Proc.new { puts "Hi there #{name}" }

chunk_of_code.call # Hi there Chris
```

Above, nothing out of the ordinary is going on. A local variable is assigned to String object, a Proc object is instantiated with a block passed in as an argument with the local variable `name` interpolated within the block, then its saved to a local variable. Finally, the Proc object is called and outputs `'Hi there Chris'`.

> A closure's binding consists of artifacts that were in scope at the point at which the closure was created; by artifacts we mean things like variables, method references, etc.

The Proc object instantiation creates a closure which allows access to all artifacts within scope of the block to be bound to it. In this case it creates a binding to the `name` local variable. This is how the value of `name` is accessible when `chunk_of_code.call` is executed.

```ruby
name = "Chris"

chunk_of_code = Proc.new { puts "Hi there #{name}" }

name = "Sam"

chunk_of_code.call # Hi there Sam
```

> Any variables that need to be accessed in a proc (or block/ lambda) must be defined before the proc is created (or passed as an argument when the proc is called).

Because a closures retains a binding with the artifacts that are within its scope when the block is created, the value of the artifacts bound to the closure can be updated after the closure was created and the closure can access these updated values. Above, `name` is reassigned _after_ the Proc object and closure are created but _before_ calling the Proc object, therefore the updated value of `name` is what is accessible through the binding created within the closure.

```ruby
name = "Chris"

chunk_of_code = Proc.new { puts "Hi there #{name}" }

name = "Sam"

chunk_of_code.call # Hi there Sam

name = "Bob"
```

Because the reassignment of `name` to `"Bob"` was after the call on `chunk_of_code` it was not accessible by the binding created through the closure of `chunk_of_code`.

Questions:

- How is a closure scoped?
- What elements/objects can be _bound_ within a closure?
- How does a local variable and a method definition differ when it comes to their scope within a closure?

---
  
## symbol to proc

- We cannot use methods that take arguments with this shortcut.
- This shortcut will work with any collection that takes a block.

The `Symbol#to_proc` method:

- When using the _unary and operator_ (`&`) on an argument passed in at method invocation it will check to see if the argument is a Proc object, if not  the argument must be a Symbol version of a method that can take a block and does not take an argument.
- When the _unary and operator_ (`&`) prepends a method parameter within a method definition it is telling the method that a block must passed in a method invocation _explicitly_, and then stores that block within the method parameter. If a block is not passed in an error will be raised.  
- When the _unary and operator_ (`&`) prepends an argument being passed in at method invocation it first checks to see if the argument is a Proc object, if not it calls `Symbol#to_proc` on the argument, then can convert the Proc object into a block.

When a _unary and operator_ (`&`) is used on a method parameter a block must be passed in _explicitly_ and the `&` converts the block to a Proc object.

```ruby
def something(&block)
  p block.class
end

something {} # => Proc
```

When the _unary and operator_ (`&`) prepends an argument it checks to see if the argument is a Proc object and then converts it into a block.

```ruby
def something
  yield('Hi there')
end

proc_obj = Proc.new { |x| puts x }
something(&proc_obj) # Hi there

# the above is the same as passing a block instead of a Proc object
# unary and operator converts the Proc object to a block

something { |x| puts x } # Hi there
```

When the unary and operator (`&`) prepends an argument it checks to see if the argument is a Proc object and if it is _not_ it calls the `Symbol#to_proc` method on it. Then it converts the Proc object to a block.

```ruby
def something
  p yield(123).class
end

something(&:to_s) # String

# & converts :to_s to a Proc Object
# Then converts it to a block
# It would would be the same as passing this to the method invocation;

something { |x| x.to_s } # String
```

---

## Summary of Concepts

- blocks are just one way Ruby implements closures. Procs and lambdas are others.
- closures drag their surrounding context/environment around, and this is at the core of how variable scope works.
- blocks are great for pushing some decisions to method invocation time.
- blocks are great for wrapping logic, where you need to perform some before/after actions.
- we can write our own methods that take a block with the yield keyword.
- when we yield, we can also pass arguments to the block.
- when we yield, we have to be aware of the block's return value.
- once we understand blocks, we can re-implement many of the common methods in the Ruby core library in our own classes.
- the Symbol#to_proc is a nice shortcut when working with collections.
- how to return a chunk of code from a method or block

---

## Build a todo list

- Why would we prefer to build a custom method for a class vs using a built in method that we can call on collections contained within the objects state?
  - This is the idea behind encapsulation: we want to hide implementation details from users of the TodoList class, and not encourage users of this class to reach into its internal state. Instead, we want to encourage users of the class to use the interfaces (ie, public methods) we created for them.
  - The entire goal of creating a class and encapsulating logic in a class is to hide implementation details and contain ripple effects when things change. Prefer to use the class's interface where possible.

---

## Questions

- What is a closure?
- How do we implement closures in Ruby?
- Why do we need closures?
- What tools do we have for implementing closures in Ruby?
- What is binding?
- What is a block?
- What can we do with blocks?
- How is a block different from a methods implementation?
- How can we pass a block to a method and have it executed?
- What occurs is we don't pass a block to a method invocation that contains the `yield` keyword?
- How can we check if a block has been passed in as an argument with a method invocation?
- What are the 2 components of code execution regarding methods?
- What is the sequence of code execution for a method?
  1. Method invocation, implicit and explicit arguments passed in.
  2. Method local variables (parameters) are initialized to the values explicitly passed in to the method definition. The block is implicitly passed in to the method definition.
  3. Method body code is executed from top to bottom.
      - If a `yield` keyword is called the method execution immediately _yields_ to the block passed in at invocation and executes the code within the block.
      - Otherwise the code within the method definition is executed line by line.
  4. The method returns the last expressions value of the method.

- How would we differentiate the different arguments types of a method invocation?
  Answer:
  - A String/Integer/Object defined by the method definition is an _explicit argument_.
  - A block passed in at method invocation is a _implicit argument_ not included in the method definition.
- What is a block parameter and block local variable and what is special about the latter?
- Can you pass an argument to a block using the `yield` keyword?
- What is _arity_ and whats the difference between lenient and strict?
- What happens when you pass more/less arguments than the block has calling for?
