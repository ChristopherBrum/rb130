# Group Study Session

```ruby
# What is outputted and why? Explicit Block Parameter Example

def my_method(&block)
  block.yield
end

my_method { puts "hello" }
```

`my_method` is defined with an ampersand appended to a parameter `&block`, creating an explicit block parameter.  This is a special optional parameter that converts an implicitly passed in block into a simple Proc object. 

within the method body, we reference the simple proc object by using its parameter name without the `&` prepended, and invoke the Proc#call method on `block`.

On line 7, we invoke `my_method` and pass in the block 
{ puts "hello"} outputting "hello"

---

```ruby
name = 'Santa'

my_proc = Proc.new do 
  puts name
end


def my_method(&block)
  block.call
end

my_method(my_proc) { puts "hello" }
```

`ArgumentError` raised (given 1, expected 0) because methods have strict arity meaning the number of arguments and method parameters must match. In this case, the optional explicit block parameter is for our implicit block,`{ puts "hello" }` so there's no parameter for  our `my_proc` argument

---

```ruby
def lambda_demo_method
  lambda_demo = lambda { return "Will I print?" }
  lambda_demo.call
  "Sorry - it's me that's printed."
end
 
puts lambda_demo_method # Sorry - it's me that's printed.
# (Notice that the lambda returns back to the method in order to complete it.)


def proc_demo_method
  proc_demo = Proc.new { return "Only I print!" }
  proc_demo.call
  "But what about me?" # Never reached
end
 
puts proc_demo_method # Only I print!
# (Notice that the proc breaks out of the method when it returns the value.)
 
# ===============

def batman_ironman_proc
  victor = Proc.new { return "Batman will win!" }
  victor.call
  "Iron Man will win!"
end

puts batman_ironman_proc

def batman_ironman_lambda
  victor = lambda { return "Batman will win!" }
  victor.call
  "Iron Man will win!"
end

puts batman_ironman_lambda
```

---

```ruby

# BINDING
# 5. What will the method call `call_me` output? Why?

# def call_me(some_code)
#   some_code.call
# end

# # name = "Robert"

# chunk_of_code = Proc.new {puts "hi #{name}"}

# def name 
#   'Rufus'
# end

# p chunk_of_code

# name = "Griffin"


# p call_me(chunk_of_code)

##########################

# # In order for our **closure** (the saved 'chunk of code') to be passed around and executed at a later time, it must understand the surrounding context from where it was defined.
# def call_me(some_code)
#   some_code.call
# end

name = "Robert"
chunk_of_code = Proc.new {puts "hi #{name}"}
name = "Griffin III"  # re-assign name after Proc initialization

call_me(chunk_of_code)
```

`hi Griffin III` is outputted and `nil` is returned.
The `Proc` object kept track of its **binding** (surrounding environment/context), so that it had all the information it needed to be executed later on.
**Bindings** include; local variables, method references, constants and other artifacts -- whatever it needs to execute correctly.

**Important note:** any local variables being accessed by a closure must be defined before the closure is created. Only exception is if the local variable is explicitly passed to the closure when it is called (e.g., `some_proc.call(some_variable)`). If we remove `name = "Robert"` in the code above, it'd change the binding of the `Proc` object & `name` would no longer be *in scope* since it is initialized after the `Proc` is instantiated.

Srdjan: If we try to invoke a method without an explicit caller and without parentheses, Ruby will *first* check to see if there is a local variable of that name within scope (which in the case of a block includes it's binding), if there is then Ruby will return the object referenced by the local variable, if not it will attempt to call a method of that name on self. 

Ginni: In order for local variables to be a part of a closures binding, they must be initialized before the closure is created unless they are explicitly passed into the closure.

Me trying to understand why exactly

**WITH `name = 'Robert'`**
`name` in `{puts "hi #{name}"}` is a local variable that's been initialized before the `Proc` object was created which means `name` will be in the `Proc` object's bindings. When we invoke the `#call` method on the `Proc` object, Ruby finds the local variable in the `Proc`s bindings and returns the value it references, which may or may not have been reassigned between the time the `Proc` object was created and the time the `Proc` object is invoked.

**WITHOUT `name = 'Robert'`**
`name` in `{puts "hi #{name}"}` is an uninitialized local variable at the time the `Proc` object was created which means it won't be part of its bindings. When we invoke the `#call` method on the `Proc` object, Ruby first checks to see if there's a local variable by that name *within scope*...meaning initialized at the time the `Proc` was created and therefore part of its bindings. Ruby won't find a local variable with that name in the `Proc`s bindings, so Ruby will attempt to call it like a method. Since there is no explicit caller, Ruby will invoke the method *implicitly* on `self` but because there are no methods defined in scope with that name--irregardless of when the `Proc` object was created--an `undefined local variable or method NameError` is raised.
