# STUDY GUIDE

## Blocks

- Closures, binding, and scope
  - **Closure**: is created at instantiation of a proc and encompasses all bindings defined within the creation of the proc object.
  - Binding will always look for a variable before a method definition
  - any variable bound to proc object will reference the most recently updated value of that variable
- How blocks work, and when we want to use them.
- Blocks and variable scope
- Write methods that use blocks and procs
- Understand that methods and blocks can return chunks of code (closures)
- Methods with an explicit block parameter
  - The `&` (unary and operator) explicitly requires a block to be passed into a method. It takes a block passed in at invocation and converts it to a proc object within the method definition.
  - The unary and operator when used on a variable referencing a proc object and passed in as an argument at method invocation will convert the proc object to a block.
    - If the variable above is not referencing a proc, the unary and operator will call `#to_proc` on the object before converting it to a block.
- Arguments and return values with blocks
- When can you pass a block to a method
- &:symbol
- Arity of blocks and methods

## Testing With Minitest

- Testing terminology
- Minitest vs. RSpec
- SEAT approach
- Assertions

## Core Tools/Packaging Code

- Purpose of core tools
- Gemfiles

## Questions for Aryan

- What did you struggle with in 130?
  - Not enough examples.
  - Mini test is used on the last question of the assessment. Important!
  - Do extra questions at the end of the practice problems at least once.

- Have a study guide put together for assessment for quick reference guide.
