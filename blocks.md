# Blocks

## Closures in Ruby

### Closures

**Closures** are a programming concepts of encapsulating a "chunk of code" together that can be saved, passed around and executed at a later time/place. Closures **bind** to surrounding artifacts (ie. variables, methods, constants) and create an enclosure around everything so that it can be referenced when the closure is later executed. A closure retains access to variables within its binding _rather than_ the specific values of those variables at the time the closure was created; so if the value of those variables changes, the closure accesses the new values, even if the closure is executed somewhere out of the scope of it's bindings/variables.

- Closures are created using a Proc object, lambda or a block.
- They can be thought of like a method that can be passed around and executed but is not named.
- A Ruby method is not a closure.

![Closures pt 1](https://drive.google.com/file/d/1iFWgi_BtLGCFp7PCMLg87FOcVGkK_zSO/view?usp=sharing)

![Closures pt 2](https://drive.google.com/file/d/1QcYPXCjkiDypaELj4hW4Rx1Fcx8EiebN/view?usp=sharing)

### Blocks, Procs and Lambdas

A block is delineated by either a `do..end` or a `{..}` and are very common in Ruby. Every method in Ruby can be passed an implicit block. When a block is included with a method invocation.

### Binding

### Main ways to work with closures

---

## Calling methods with blocks

- What?
- How?
- Why?
- What can you do within a block?

## Writing methods that take blocks

- What?
- How?
- Why?
- Yielding
  - `yield` keyword
  - `LocalJumpError`
  - Making yield optional
- Passing execution to the block
- Yielding with an Argument
  - Block parameter vs Block local variable
  - Arguments passed to a block vs passed to a method
  - **Arity**
- Return value of yielding to the block
- When to use blocks in your own methods
  - Defer some implementation details til implementations
  - Before and After action: Sandwich code
- Methods with an explicit block parameter
- Using closures

---

### Key Points

- blocks are one way that Ruby implements closures. Closures are a way to pass around an unnamed "chunk of code" to be executed later.
- blocks can take arguments, just like normal methods. But unlike normal methods, it won't complain about wrong number of arguments passed to it.
- blocks return a value, just like normal methods.
- blocks are a way to defer some implementation decisions to method invocation time. It allows method callers to refine a method at invocation time for a specific use case. It allows method implementors to build generic methods that can be used in a variety of ways.
- blocks are a good use case for "sandwich code" scenarios, like closing a File automatically.
- methods and blocks can return a chunk of code by returning a Proc or lambda.

---

## Building methods that take blocks

Build a "times" method from scratch

```ruby
#method definition
def times(num)
  counter = 0
  
  while counter < num
    yield(counter)
    counter += 1
  end
  
  num
end

# method invocation
# block passed in with #times method is invoked by the yield keyword in the method definition
times(5) do |current_num|
  puts current_num
end

# 0
# 1
# 2
# 3
# 4
# => 5
```

---

Build an "each" method from scratch

```ruby
# Method definition
def each(arr)
  counter = 0
  
  while counter < arr.size
    yield(arr[counter])
    counter += 1
  end
  
  arr
end

# method invocation
# block passed in with #times method is invoked by the yield keyword in the method definition
each([1, 2, 3, 4, 5]) do |element|
  puts element * 2
end
# 2
# 4
# 6
# 8
# 10
# => [1, 2, 3, 4, 5]
```

---

- Build an "select" method from scratch

```ruby
# Method definition
def new_select(arr)
  counter = 0
  new_arr = []
  
  while counter < arr.size
    # return value of block used to check for truthiness
    if yield(arr[counter])
      new_arr << arr[counter]
    end
    
    counter += 1
  end
  
  new_arr
end

array = [1, 2, 3, 4, 5]

# method invocations
# block passed in with #times method is invoked by the yield keyword in the method definition
p new_select(array) { |num| num.odd? } == [1, 3, 5] # true
p new_select(array) { |num| puts num } == [] # outputs 1, 2, 3, 4, 5 and returns true
p new_select(array) { |num| num + 1 } == [1, 2, 3, 4, 5] # true
```

---

Build an "reduce" method from scratch

```ruby
def reduce(arr, default=nil)
  accumulator = (default ? default : arr.first)
  counter = (default ? 0 : 1)
  
  while counter < arr.size
    accumulator = yield(accumulator, arr[counter])
    counter += 1
  end
  
  accumulator
end

array = [1, 2, 3, 4, 5]


p reduce(array) { |acc, num| acc + num } == 15
p reduce(array, 10) { |acc, num| acc + num } == 25
p reduce(['a', 'b', 'c']) { |acc, value| acc += value } == 'abc'
p reduce([[1, 2], ['a', 'b']]) { |acc, value| acc + value } == [1, 2, 'a', 'b']
# p reduce(array) { |acc, num| acc + num if num.odd? }  # => NoMethodError
```

---

## Build a todo list

- Why would we prefer to build a custom method for a class vs using a built in method that we can call on collections contained within the objects state?
  - This is the idea behind encapsulation: we want to hide implementation details from users of the TodoList class, and not encourage users of this class to reach into its internal state. Instead, we want to encourage users of the class to use the interfaces (ie, public methods) we created for them.
  - The entire goal of creating a class and encapsulating logic in a class is to hide implementation details and contain ripple effects when things change. Prefer to use the class's interface where possible.

## Blocks and variable scope

- Refreshing our understanding of local variable scope
- Closure and Binding
  - What?
  - How?
  - Why?
  - In Ruby a closure is represented by a block, Proc object, or a lambda.

Questions:

- How is a closure scoped?
- What elements/objects can be _bound_ within a closure?
- How does a local variable and a method definition differ when it comes to their scope within a closure?
  
## symbol to proc

- What?
- How?
- Why?
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
