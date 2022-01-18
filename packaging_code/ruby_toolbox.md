# Ruby Toolbox

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
  - [RVM](#rvm)
  - [rbenv](#rbenv)
- [Bundler](#bundler)
  - [Gemfile and Gemfile.lock](#gemfile-and-gemfile.lock)
  - [Running Apps with Bundler](#running-apps-with-bundler)
  - [Bundle exec](#bundle-exec)
- [Rake](#rake)
- [Relationships](#relationships)
- [Links](#links)

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

**What?**: Ruby Version Managers are programs that can be installed in order to manage and use multiple versions of Ruby, the utilities associated with those versions (i.e. `irb`), and the RubyGems installed for each version.

**Why?**: Ruby is an evolving language and with each version features are added and removed. At some point you will be working with a program that is running on an older version of Ruby and a RVM will allow you to switch between the different versions required for different programs.

**How?**: _RVM_ and _rbenv_ are the two most commonly used Ruby version managers. Their approach is different but the accomplish the same things. But a few things to keep in mind:

- RVM has some problems when used on a Mac so rbenv may be less troublesome.

Overall distinctions between `RVM` and `rbenv`

RVM:

- Can have issues when running on a Mac.
- Easier to install and use on Cloud9 and Linux systems.
- Has more features out of "the box"
- Most;y functions by altering your `PATH` variable and replacing the `cd` command with a `RVM` shell-function.

rbenv:

- Works better for Mac.
- Out of the box lacking a few features, but rbenv plugins make up for that.
- Mostly works by altering the `PATH` variable and some other environmental variables.

### RVM

Most of the work of a Ruby version manager is done behind the scenes. Essentially, by using the appropriate shell command (`rvm`) and specifying a Ruby version, the version manager will alter the PATH that the shell command operates from to work out of the directory for the Ruby version specified.

Some common commands:

```txt
rvm use 2.1.1
```

Tells RVM to switch to Ruby version 2.1.1.

```txt
rvm list rubies
```

Tells RVM to list the versions of Ruby you already have installed.

```txt
rvm install 2.2.3
```

Tells RVM to install Ruby version 2.2.3 (may get warnings about deprecated versions)

```txt
rvm use 2.1.1 --default
rvm use default
```

Tells RVM to set a RUby version as default and then switches to default.

An easier and less error prone way of assuring you're using the appropriate Ruby version for any of your projects is to add `.ruby-version` file within the projects root directory that only contains the Ruby version. To do this navigate to the root directory of the project and enter:

```txt
rvm --ruby-version use 2.2.2 (or the desired Ruby version)
```

From there set your Ruby default version so that Ruby automatically switches for you.

### rbenv

From a functionality standpoint RVM and rbenv appear very similar, but under the hood they function differently. rbenv uses a sets scripts called **_shims_** that share the name of various Ruby and gem programs, and live within a `shims` subdirectory of the main rbenv directory. This sub-directory is included in the rbenv PATH prior to any gems or Ruby programs so that it checks the `shims` directory first. Then runs the appropriate shim script and from within the script the `rbenv gem/ruby PROGRAM` is ran, which is where the appropriate version of Ruby is determined.

> That all sounds pretty complex, and it is. However, in practice, it's mostly invisible. If you want to run, say, rubocop from the Ruby 2.2.2 directory, you tell rbenv to use Ruby 2.2.2, then run the rubocop command. Magically, the system finds the rubocop shim, the shim runs rbenv exec rubocop, and that runs the Ruby 2.2.2 version of rubocop.

rbenv does not provide a way to directly install gems but [ruby-build](https://github.com/rbenv/ruby-build) takes care of that problem.

You can set a default Ruby version by using the `global` command.

```txt
rbenv global 2.3.1
```

And by navigating to a projects root directory you can set a default Ruby version for that project using the `local` command.

```txt
cd ~/src/magic
rbenv local 2.0.0
```

---

## Bundler

**What?**: Bundler is a _dependency manager_. The same as we use Ruby version managers to manage different versions of Ruby, and even though they can be used to manage Gem dependencies, the favored way to do so is by using a dependency manager, and Bundler is the most commonly used one with Ruby.

**Why?**: A dependency manager allows us to switch between different versions of RubyGems as needed throughout different projects that we're working on.

**How?**: Bundler lets you install multiple Gem versions under different Ruby versions.

### Gemfile and Gemfile.lock

The `Gemfile` is a Ruby file that uses a DSL to tell Bundler which version of Ruby and which RubyGems versions to use within a program. After creating a `Gemfile` run the `bundle install` command, which will scan the `Gemfile` and downloads all the dependencies listed and saves them in a `Gemfile.lock` file. This includes the gems specifically listed in `Gemfile` as well as all the gems those depend on.

> Note: the RubyGem is named _Bundler_ but the command is _bundle_.

For more info here's the [Bundler Docs](https://bundler.io/docs.html)

### Running Apps with Bundler

Unless you're using Rails you will need to `require` Bundler within your `Gemfile.lock` file before any other gems.This removes the gem directories from the `$LOAD_PATH` global array, which Ruby searches through when it needs to locate a required file. At that point Ruby can no longer find gems, so `bundler/setup` re-ads the directories with the appropriate version of Gems required.

```txt
require 'bundler/setup'
```

Bundler doesn't interfere with your Rubies and their corresponding gems, so you can still run commands such as `gem env`, `rvm info`, and `rbenv version`.

### Bundle exec

Discrepancies with a Gem version required by an executable can sometimes cause issues if your default version is in conflict. Using the `bundle exec` is the easiest way to force the appropriate version to be loaded. This is a common issue when running `rake` files.

More info about Bundler can be found [here](https://www.cloudcity.io/blog/2015/07/10/how-bundler-works-a-history-of-ruby-dependency-management/)

---

## Rake

Rake is RubyGem that automates common functions required to build, test, package, and install programs. It is part of every modern Ruby installation so it does not need to be installed manually. You can write rake tasks to automate automate anything you want to do with your app during the development, testing, and release cycles.

Common Rake tasks that you may encounter:

- Set up required environment by creating directories and files
- Set up and initialize databases
- Run tests
- Package your application and all of its files for distribution
- Install the application
- Perform common Git tasks
- Rebuild certain files and directories (assets) based on changes to other files and directories

Rake uses a file called `Rakefile` within your project directory. It describes the tasks that can be performed and how to perform them. Here's what the syntax for a `Rakefile` look like:

```ruby
desc 'Say hello'
task :hello do
  puts "Hello there. This is the `hello` task."
end

desc 'Say goodbye'
task :bye do
  puts 'Bye now!'
end

desc 'Do everything'
task :default => [:hello, :bye]
```

The first two tasks are named and the third is default, meaning if no task is specified the default task will run when rake is invoked.

To see what tasks a `Rakefile` has available enter:

```txt
$ bundle exec rake -T
rake bye      # Say goodbye
rake default  # Do everything
rake hello    # Say hello
```

It is common to run `bundle exec` when using Rake because it avoid a lot of errors that may surface when not using it. Rake is written in regular Ruby code but there are Rake methods, like `desc` and `task` that comprise a DSL.

Reasons to use Rake:

For instance, to release a new version of an existing program, you may want to:

- Run all tests associated with the program.
- Increment the version number.
- Create your release notes.
- Make a complete backup of your local repo.

Even though these things are easy enough to do on their own it makes things simpler to be able to setup these tasks, dictate the order with which they will be executed and simply enter one command and run them all. It also avoids simple syntactical errors that repeatedly running tasks manually can run into.

---

## Relationships

- One thing to keep in mind as you become more comfortable with the Ruby tools is how they relate to each other.

- Your Ruby Version Manager is at the top level -- it controls multiple installations of Ruby and all the other tools.

- Within each installation of Ruby, you can have multiple Gems -- even 1000s of Gems if you want. Each Gem becomes accessible to the Ruby version under which it is installed. If you want to run a Gem in multiple versions of Ruby, you need to install it in all of the versions you want to use it with.

- Each Gem in a Ruby installation can itself have multiple versions. This frequently occurs naturally as you install updated Gems, but can also be a requirement; sometimes you just need a specific version of a Gem for one project, but want to use another version for your other projects.

- Ruby projects are programs and libraries that make use of Ruby as the primary development language. Each Ruby project is typically designed to use a specific version (or versions) of Ruby, and may also use a variety of different Gems.

- The Bundler program is itself a Gem that is used to manage the Gem dependencies of your projects. That is, it determines and controls the Ruby version and Gems that your project uses, and attempts to ensure that the proper items are installed and used when you run the program.

- Finally, Rake is another Gem. It isn't tied to any one Ruby project, but is, instead, a tool that you use to perform repetitive development tasks, such as running tests, building databases, packaging and releasing the software, etc. The tasks that Rake performs are varied, and frequently change from one project to another; you use the Rakefile file to control which tasks your project needs.

---

## Links

[Click here](https://launchschool.com/books/core_ruby_tools/read/conclusion) for useful links related to Core Ruby Tools.
