# Blocks Practice Quiz

1. What are closures?

  Closures are a way of saving a chunk of code in a way that allows us to pass it around a program and call it from a different time and place. In Ruby this is done using blocks, Procs and lambdas, although technically blocks do not create closures by themselves. When a closure is created all artifacts within scope of the closure have a binding created with the closure that can access these artifacts when the closure is executed, even if the artifact is not within scope when/where the closure is executed

2. What is binding?

  Binding refers to the connection of all artifacts that are within scope of a closure when it is created. These artifacts can be methods, local variables, constants, as well as other types. The binding created is bound to the artifact  and not the value associated with the artifact, which means that the value of the artifact when the closure is created can be modified/reassigned before the closure is executed.

3. How does binding affect the scope of closures?

  Basically, the binding creates the connection from the closure to an artifact and value of the artifact will reflect any reassignments or modifications that occur to the value of the artifact prior to the closure being executed. Bindings have access to all artifacts that were in scope during creation of the closure and can access these artifacts values when executed, even if those artifacts are no longer in scope.

4. How do blocks work?

  A block is an anonymous chunk of code contained with `do..end` or `{..}` and can serve as a way to customize the functionality of a method by being passed in to a method at invocation.

5. When do we use blocks? (List the two reasons)

  We use blocks for:\
    - **Deferring implementation details to invocation**, and therefore the method implementor allows for a block so that final implementation details can be left up to the method caller.
    - **Before and After code/Sandwich code** is for situations where some functionality needs to be run before and after some non-related code, passed in by a block. This is useful in situations like testing the time a piece of code takes to run.

6. Describe the two reasons we use blocks, use examples.

  We use blocks to in two mains ways:\
    - As a **method implementor** you're not always 100% sure how the method caller is going to utilize the method so writing a method with the intention of allowing the method caller to refine the method by passing in a block that pertains to the specific situation they are working in.
    - As a **method caller** having a more generic method that allows you to pass in a block with specific code at invocation is vastly more flexible than not.

7. When can you pass a block to a method? Why?

  Methods always accept an implicit block, regardless of whether they utilize it or not.

8. How do we make a block argument manditory?



9. How do methods access both implicit and explicit blocks passed in?

10. What is yield in Ruby and how does it work?

11. How do we check if a block is passed into a method?

12. Why is it important to know that methods and blocks can return closures?

13. What are the benifits of explicit block?

14. Describe the arity differences of blocks, procs, methods and lambdas.

15. What other differences are there between lambdas and procs? (might not be assessed on this, but good to know)

16. What does & do when in a the method parameter?

```ruby
def method(&var); end
```

17. What does & do when in a method invocation argument?

```ruby
method(&var)
```

18. What is happening in the code below?

```ruby
arr = [1, 2, 3, 4, 5]

p arr.map(&:to_s) # specifically `&:to_s`
```

19. How do we get the desired output without altering the method or the method invocations?

```ruby
def call_this
  yield(2)
end

# your code here

p call_this(&to_s) # => returns 2
p call_this(&to_i) # => returns "2"
```

20. How do we invoke an explicit block passed into a method using &? Provide example.

21. What concept does the following code demonstrate?

```ruby
def time_it
  time_before = Time.now
  yield
  time_after= Time.now
  puts "It took #{time_after - time_before} seconds."
end
```

22. What will be outputted from the method invocation block_method('turtle') below? Why does/doesn't it raise an error?

```ruby
def block_method(animal)
  yield(animal)
end

block_method('turtle') do |turtle, seal|
  puts "This is a #{turtle} and a #{seal}."
end
```

23. What will be outputted if we add the follow code to the code above? Why?

```ruby
block_method('turtle') { puts "This is a #{animal}."}
24. What will the method call call_me output? Why?

def call_me(some_code)
  some_code.call
end

name = "Robert"
chunk_of_code = Proc.new {puts "hi #{name}"}
name = "Griffin"

call_me(chunk_of_code)
```

25. What happens when we change the code as such:

```ruby
def call_me(some_code)
  some_code.call
end

chunk_of_code = Proc.new {puts "hi #{name}"}
name = "Griffin"

call_me(chunk_of_code)
```

26. What will the method call call_me output? Why?

```ruby
def call_me(some_code)
  some_code.call
end

def name
  "Joe"
end

name = "Robert"
chunk_of_code = Proc.new {puts "hi #{name}"}

call_me(chunk_of_code)
```

27. Why does the following raise an error?

```ruby
def a_method(pro)
  pro.call
end

a = 'friend'
a_method(&a)
28. Why does the following code raise an error?

def some_method(block)
  block_given?
end

bl = { puts "hi" }

p some_method(bl)
```

29. Why does the following code output false?

```ruby
def some_method(block)
  block_given?
end

bloc = proc { puts "hi" }

p some_method(bloc)
30. How do we fix the following code so the output is true? Explain

def some_method(block)
  block_given? # we want this to return `true`
end

bloc = proc { puts "hi" } # do not alter this code

p some_method(bloc)
```

31. How does Kernel#block_given? work?

32. Why do we get an LocalJumpError when executing the below code? & How do we fix it so the output is hi? (2 possible ways)

```ruby
def some(block)
  block_given?
  yield
end

bloc = proc { p "hi" } # do not alter

some(bloc)
```

33. What does the following code tell us about lambda's? (probably not assess on this but good to know)

```ruby
bloc = lambda { p "hi" }

bloc.class # => Proc
bloc.lambda? # => true

new_lam = Lambda.new { p "hi, lambda!" } # => NameError: uninitialized constant Lambda
```

34. What does the following code tell us about explicitly returning from proc's and lambda's? (once again probably not assess on this, but good to know ;)

```ruby
def lambda_return
  puts "Before lambda call."
  lambda {return}.call
  puts "After lambda call."
end

def proc_return
  puts "Before proc call."
  proc {return}.call
  puts "After proc call."
end

lambda_return #=> "Before lambda call."
              #=> "After lambda call."

proc_return #=> "Before proc call."
```
