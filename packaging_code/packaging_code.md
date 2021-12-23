# Packing Code Into a Project

## The Ruby Toolbox / Introduction to Core Ruby Tools

### What are Ruby tools?

### Ruby Installation

- finding mac _system Ruby_ version
- root access on a Mac
- On Mac you should use Ruby Version Manager (RVM) to install and run the rubies you need
- install homebrew, a package manager for Mac. Used to install and manage tools helpful in Ruby development.
- system Ruby
  - `which` command line command
  - finding system Ruby
  - `rbenv` or `shims` present within the path of your _system Ruby_ shows that you are using a version of Ruby installed by **rbenv** version manager.
  - `rvm` present within the path of your _system Ruby_ means you're using a version of Ruby installed by **RVM** Ruby version manager.
- `ruby -v` entered in the command line will return the current version of Ruby is being used.

What gets installed with Ruby?

- The core library
- The standard Library
- The irb REPL (Read Evaluate Print Loop)
- The rake utility: a tool to automate Ruby development tasks
- The gem command: a tool to manage RubyGems
- Documentation tools (rdoc and ri)

### Gems

- With a standard Ruby installation both Ruby's core library and standard library are made available.
  - Whats the difference between these two?

What are gems?

- **RubyGems**, referred to as **gems**, are packages of code that you can download, install and use within your Ruby program or the command line.
- All versions of Ruby since 1.9 make the `gem` command available for managing gems.
- Some gems we are already familiar with are:
  - `rubocop`: This Gem checks for Ruby style guide violations and other potential issues in your code.
  - `pry`: This Gem helps debug Ruby programs.
  - `sequel`: This Gem provides a set of classes and methods that simplify database access.
  - `rails`: This Gem provides a web application framework that simplifies and speeds web applications development.
  - `minitest`: This gem gives us access to all of the testing features and methods included within MiniTest.
- Installing a gem is simple. Go to the [RubyGems website](https://rubygems.org/), choose a gem, then enter `gem install` with the gem name into the command line. This will be all you need to do for many gems but read their documentation first.
- The [RubyGems Basics](https://guides.rubygems.org/rubygems-basics/) page and the [Command Reference](https://guides.rubygems.org/command-reference/) pages provide more in depth information regarding gems.

Gems, Ruby and your computer

- 