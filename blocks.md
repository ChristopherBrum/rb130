# Blocks

- Closures in Ruby
  - closure
  - `Proc` object
  - Lambda
  - block
  - binding
  - 3 main ways to work with closures
    - Instantiating an object from the Proc class
    - Using lambdas
    - Using blocks

- Calling methods with blocks
- Writing methods that take blocks
  - yielding
- Build a "times" method from scratch
- Build an "each" method from scratch
- Build an "select" method from scratch
- Build an "reduce" method from scratch
- Build a todo list
- Blocks and variable scope
- symbol to proc

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
- What is _arity_?
- What happens when you pass more/less arguments than the block has calling for?
