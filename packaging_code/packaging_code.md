# Packing Code Into a Project

- [The Ruby Toolbox](#the-ruby-toolbox)
  - [What are Ruby tools?](#what-are-ruby-tools)
- [Ruby Installation](#ruby-installation)
- [Gems](#gems)
  - [What are gems?](#what-are-gems)
  - [Gems, Ruby and your computer](#gems-ruby-and-your-computer)
    - [The Remote Library](#the-remote-library)
    - [The Local Library](#the-local-library)
    - [Gems and your file system](#gems-and-your-file-system)
    - [Which file was Required?](#which-file-was-required)
    - [Multiple Gem Versions](#multiple-gem-versions)
- [Ruby Version Managers](#ruby-version-managers)
  - [What are Ruby Version Managers?](#what-are-ruby-version-managers)

## The Ruby Toolbox

### What are Ruby tools

---

## Ruby Installation

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
- Documentation tools (`rdoc` and `ri`)

---

## Gems

- With a standard Ruby installation both Ruby's core library and standard library are made available.
  - Whats the difference between these two?

### What are gems

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

### Gems, Ruby and your computer

#### The Remote Library

Because all Ruby versions from 1.9 onward contain the `gem` program, we can grab gems and add them to our program from the remote Gem library. Most often we will search and find the gem needed in the [RubyGems Library](https://rubygems.org/gems) but sometimes you will need to find the gems from a specialized library(ie. from a company, employer, school). Further information about these gems should be available from the gems 'homepage' or 'documentation'. Once the appropriate gem is found run `gem install GEM_NAME` and Ruby will connect to the remote library.

#### The Local Library

When you install a gem from a remote library Ruby adds those files to an appropriate folder within your local file system. Precisely where depends on a number of things, like:

- whether you're using a system Ruby that requires root access
- a user maintainable Ruby
- the specific Ruby version
- whether you're using a version manager (e.g. RVM, rbenv)

Fortunately Ruby knows exactly where to put the files in order for them to work so there's usually nothing else required after installing the gems.

#### Gems and your file system

Occasionally you may need access to the source code for a gem, and if you are without internet you will need to navigate the file system to find the Gem's source code. **Important to not alter the source code in anyway**.

Using the `gem` command can give you a shortcut to finding the source code in you file system. The `gem env` command will output a list of information regarding your RubyGems installation.

```txt
➜  rb130 git:(main) gem env
RubyGems Environment:
  - RUBYGEMS VERSION: 3.1.2
  - RUBY VERSION: 2.7.1 (2020-03-31 patchlevel 83) [x86_64-darwin20]
  - INSTALLATION DIRECTORY: /Users/christopherbrum/.rvm/gems/ruby-2.7.1
  - USER INSTALLATION DIRECTORY: /Users/christopherbrum/.gem/ruby/2.7.0
  - RUBY EXECUTABLE: /Users/christopherbrum/.rvm/rubies/ruby-2.7.1/bin/ruby
  - GIT EXECUTABLE: /usr/bin/git
  - EXECUTABLE DIRECTORY: /Users/christopherbrum/.rvm/gems/ruby-2.7.1/bin
  - SPEC CACHE DIRECTORY: /Users/christopherbrum/.gem/specs
  - SYSTEM CONFIGURATION DIRECTORY: /Users/christopherbrum/.rvm/rubies/ruby-2.7.1/etc
  - RUBYGEMS PLATFORMS:
    - ruby
    - x86_64-darwin-20
  - GEM PATHS:
     - /Users/christopherbrum/.rvm/gems/ruby-2.7.1
     - /Users/christopherbrum/.rvm/rubies/ruby-2.7.1/lib/ruby/gems/2.7.0
  - GEM CONFIGURATION:
     - :update_sources => true
     - :verbose => true
     - :backtrace => false
     - :bulk_threshold => 1000
  - REMOTE SOURCES:
     - https://rubygems.org/
  - SHELL PATH:
     - /Users/christopherbrum/.rvm/gems/ruby-2.7.1/bin
     - /Users/christopherbrum/.rvm/gems/ruby-2.7.1@global/bin
     - /Users/christopherbrum/.rvm/rubies/ruby-2.7.1/bin
     - /Users/christopherbrum/.nvm/versions/node/v12.22.1/bin
     - /usr/local/bin
     - /usr/bin
     - /bin
     - /usr/sbin
     - /sbin
     - /Library/Apple/usr/bin
     - /Users/christopherbrum/.rvm/bin
```

RUBY VERSION

- This is version of Ruby associated with the `gem` command ran.

RUBY EXECUTABLE

- The location of the `ruby` command that you should use with gems managed by this `gem` command.

INSTALLATION DIRECTORY

- Where `gem` installs Gems by default. varies based on Ruby version.

USER INSTALLATION DIRECTORY

- Depending on your Ruby installation and options you pass to `gem`, `gem` may install Gems somewhere in your home directory instead of a system-level directory. This is the location in your home directory that `gem` uses in such cases.

EXECUTABLE INSTALLATION DIRECTORY

- Some Gems provide commands that you can use directly from a terminal prompt; gem places those commands in this directory.

REMOTE SOURCES

- The remote library used by this gem installation.

SHELL PATH

- Value of your shell's PATH variable; tells your shell which directories it should search to find executable program files.

#### Which file was Required

Sometimes you will get an error because a gem feature that you need is not accessible because the gem version is not the one you need and that the feature doesn't exist. In cases like this you'll need to know the version of the Gem your program loaded. You can run a piece of debugging code shortly after the point you require the Gem, like `binding.pry`, or you can run:

```txt
puts $LOADED_FEATURES.grep(/test_file\.rb/)
```

Which will output something like:

```txt
/usr/local/rvm/gems/ruby-2.2.2/gems/freewill-1.0.0/lib/test_file.rb
```

In this case `test_file-1.0.0` specifies the Gem 'freewill' has loaded version 1.0.0.

#### Multiple Gem Versions

Occasionally you will come across a situation where it appears that multiple Gem versions have been loaded. By default Ruby will run the most up to date version off a Gem, which can cause issues if we need to run an older version. In this case we can specify that we want to use a specific version of a Gem in a few ways:

- Provide an absolute path name to `require`.
- Add an appropriate `-I` option to the Ruby invocation.
- Modify $LOAD_PATH prior to requiring `somegem`.
- Modify the `RUBYLIB` environment variable.

These are all 'hacks' and are only good in the short term. What we really want to use id **Bundler**.

## Ruby Version Managers

### What are Ruby Version Managers

### Which Ruby Version Manager should I use?

---