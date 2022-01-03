# Packing Code Into a Project

- [The Ruby Toolbox](#the-ruby-toolbox)
  - [What are Ruby tools?](#what-are-ruby-tools)
  - [Ruby Installation](#ruby-installation)
  - [Gems](#gems)
  - [Ruby Version Managers](#ruby-version-managers)
  - [Bundler](#bundler)
  - [Rake](#rake)
- [Project Directory](#project-directory)
- [Setting up the Gemfile](#setting-up-the-gemfile)

## The Ruby Toolbox

### Ruby Installation

- Most importantly, we've pointed out that the system Ruby may not be suitable for development (on Cloud9, this isn't a concern). We also briefly touched on what gets installed with Ruby.

- Much of the development process with any programming language is about finding and fixing problems. Sometimes, though, these problems are more about the tools that you use to write, test, build, document, analyze, and distribute the software. To fix these tool-related problems, you need to know your development environment and how the various tools interact with that environment. Ruby is no exception.

### Gems

- RubyGems, or Gems for short, are packages of code that you can download, install, and use in your Ruby programs or from the command line. The gem command manages your Gems.

- RubyGems are organized on your filesystem, and seen how to deal with some common issues that arise when working with Gems.

- You can install multiple versions of Ruby on your system, and that such multi-version systems take this into account when managing your Gems.

### Ruby Version Managers

- Ruby version managers let you manage multiple versions of Ruby, the utilities (such as irb) associated with each version, and the RubyGems installed for each Ruby. With version managers, you can install and uninstall ruby versions and gems, and run specific versions of ruby with specific programs and environments.

- The two main version managers, RVM and rbenv, are similar in function, with little to distinguish between the two for most developers. By default, RVM has more features, but rbenv plugins provide much of the functionality not provided by the base install of rbenv. RVM works by dynamically managing your environment, mostly by modifying your PATH variable and replacing the built-in cd command with an RVM-aware shell function; rbenv works by just modifying your PATH and some other environment variables.

- Ruby programs often need a specific version of Ruby, and specific versions of the Gems it uses. Ruby version managers take care of most of the issues arising from these differing requirements, but sometimes you'll find that they aren't enough. For example, you may need to use Ruby 2.2.2 for two different projects instead of your default 2.3.1, but you may also need separate versions of the Rails Gem, say 4.2.7 for one project, and version 5.0.0 for the other. While both RVM and rbenv (with the aid of a plugin) can handle these requirements, the easier and more common path is to use a RubyGem called Bundler.

### Bundler

- Bundler lets you describe exactly which Ruby and Gems you want to use with your Ruby apps. Specifically, it lets you install multiple versions of each Gem under a specific version of Ruby and then use the proper version in your app.

- Bundler is a RubyGem, so you must install it like a normal Gem: gem install bundler.

- To use Bundler, you provide a file named Gemfile that describes the Ruby and Gem versions you want for your app. You use a DSL described on the Bundler website to provide this information.

- Bundler uses the Gemfile to generate a Gemfile.lock file via the bundle install command. Gemfile.lock describes the actual versions of each Gem that your app needs, including any Gems that the Gems listed in Gemfile depend on. The bundler/setup package tells your Ruby program to use Gemfile.lock to determine which Gem versions it should load.

- The `bundle exec` command ensures that executable programs installed by Gems don't interfere with your app's requirements. For instance, if your app needs a specific version of rake but the default version of rake differs, `bundle exec` ensures that you can still run the specific rake version compatible with your app.

### Rake

- Rake is RubyGem that automates common functions required to build, test, package, and install programs.

- It is part of every modern Ruby installation so it does not need to be installed manually.

- You can write rake tasks to automate automate anything you want to do with your app during the development, testing, and release cycles.

---

## Project Directory

A software project will be comprised of a number of things, including but not limited to:

- Source code (Ruby in our case, but any other programming language used within your project live Javascript)
- Tests
- Assets
- HTML files
- Databases
- Configuration files

There is a generally agreed upon practice of where things should go across projects. Directory names and files names should also follow a standard of containing only letters, numbers and underscores. Avoid using spaces when naming directories as that can lead to unexpected behaviors.

- **Source code** should go in the `lib` directory found within the root directory of the project.
- **Tests** should go in the `test` directory found within the root directory of the project.

## Setting up the Gemfile

We will use the Bundler gem to configure the `Gemfile`, which determines the dependencies of your project. Dependencies in this file will let other developers know how to run your project.

A `Gemfile` normally needs 4 pieces of information:

1. **Where Bundler should look for RubyGems it needs to install.**

    This is usually done through the [RubyGems site](https://rubygems.org/) but sometimes may come from another source(i.e. company, school, etc.). It is included in your `Gemfile` like this:

    ```ruby
    source 'https://rubygems.org' # or other source url
    ```

2. Do you need a `.gemspec` file?

    Bundler checks for a `gemspec` file when the `Gemfile` contains a `gemspec` statement. If we don't have a `gemspec` statement it won't.

3. What version of Ruby does your project need?(recommended but not required)

    Typically you will want to use the most up to date version of Ruby that's out but that's not always possible. This is not required but is a good idea to specify the version you want, otherwise Bundler will use the version set as default. The version of Ruby can be added like this:

    ```ruby
    ruby '2.5.0'
    ```

4. What RubyGems does your program use?

    Determine what Gems have been required throughout your program, even code only ran for testing or automation. You won't always know what version of a Gem is required though, but you can look in your Gem directories to determine which versions are needed. You can require the appropriate Gems like this:

    ```ruby
    gem 'minitest', '~> 5.10'
    gem 'minitest-reporters', '~> 1.1'
    ```

If you add more Gems in your program later you must add them to your `Gemfile` and then run `bundle install` to add them to `Gemfile.lock`.
