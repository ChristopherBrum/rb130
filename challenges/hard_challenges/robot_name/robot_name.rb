=begin
Write a program that manages robot factory settings.

When robots come off the factory floor, they have no name.
The first time you boot them up, a random name is generated,
such as RX837 or BC811.

Every once in a while, we need to reset a robot to its factory settings,
which means that their name gets wiped. The next time you ask, it will
respond with a new random name.

The names must be random; they should not follow a predictable sequence.
Random names means there is a risk of collisions. Your solution should not
allow the use of the same name twice when avoidable.

#######################

Explicit
- write a program that manages facotry settings for robots
- robots start with no name
- when booted up they a random name is generated
- should be able to reset the robot and wipe its name
- next time booted will generate new random name
- do not allow the same name to be generated twice

Implicit
- names are formatted as 2 uppercase letters and 3 digits
- no argument passed in at instantiation of a robot

- `#name` instance method called
  - check if name has been generated
    - if yes, return name
    - otherwise, generate and return

- `#reset` will reset the generated name and add it to a collection of
names not to use again

DS
- Strings for output
- array to collect used names

Algo(s)
- constructor method --> no arguments given

- instance method --> name --> string
  - checks to see if #name has a value
    - if it doesn't, generate name and return it
    - if it does return name

- instance method --> reset --> n/a
  - pushes current name to a collection of non-usable names
  - generates a new name and assigns it to the name instance variable

- instance method --> generate_name --> string
  - generate 2 random uppercase letters
  - generate 3 random digits
  - concat and return
  - check to see if new name is found within old_names instance variable

=end

class Robot
  @@used_names = []

  def name
    @name.nil? ? @name = generate_name : @name
  end

  def reset
    @name = nil
  end

  private

  def generate_name
    new_name = ''
    2.times { new_name += ('A'..'Z').to_a.sample }
    3.times { new_name += ('0'..'9').to_a.sample }

    if @@used_names.include?(new_name)
      generate_name
    else
      @@used_names << new_name
      new_name
    end
  end

  attr_writer :name
end
