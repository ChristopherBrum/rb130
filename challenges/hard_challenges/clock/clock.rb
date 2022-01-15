=begin
Create a clock that is independent of date.

You should be able to add minutes to and subtract minutes from the time
represented by a given clock object. Two clock objects that represent the
same time should be equal to each other.

You may not use any built-in date or time functionality; just use arithmetic
operations.

#######################

Explicit
- write a clokc program that is independent of the Date class
  - you can add/subtract minutes from the time of a given clock object
  - 2 clock objs that rep the same time should be equal to each other
  - do not use built inDtae or Time classes

Implicit
- Clock has class method Clock::at
  - which takes 1 or 2 arguments
    - 1st argument is the hour from 0-23
    - 2nd is minutes
  - saves hr and min to a hash
  - pass hash to new instance of clock and return

- Clock has other instance methods `Clock#-` and `Clock#+`
  - These class methods can be called on a Clock object
  - Can use syntactial sugar syntax (i.e. Clock.at(10) + 30 ==> '10:30')
  - when time reachews 24 hrs it reverts to 00:00
  - when subtracting and reach below 00:00 will convert to 23:59 or less

- Clock has instance method Clock#to_s
  - returns a string representation of the current time
  - converts from an integer to a string

- Misc.
  - When comparing if two clocks are the same they are if they have same time
  - Clocks will be saved to a variable as an array of integers(hr, min)

DS
- integer inputs
- string outputs
- saves time as a hash of hrs and min

Algo(s)
- class method --> self.at(integer, integer=0) --> Clock object
  - initialize hash with :min and :hr set to 0
  - assign min and hour to the values passed increate new instance of the
  Clock class and pass hash as argument

- constructor method --> hash argument

- instance method --> +(integer)
  - add given integer to time[:min]
  - return self

- instance method --> -(integer)
  - subtract given integer from time[:min]
  - if min is neg
    - subtract 1 from
    - add 60 to min
  - return self

- private methods

- instance method --> fetch_hr --> string
  - calc_hr
  - if 0 return '00'
  - if less than 10 return '0' plus hour'
  - otherwise return hour as string

- instance method --> fetch_min --> string
  - clac_min
  - if 0 return '00'
  - if less than 10 return '0' plus min
  - otherwise return min as string

- instance method --> calc_hr -->  integer
  - if hours are greater thn or equal to 24
    - reduce by 24 until they are
  - return new hour

- instance emthod --> calc_min --> integer
  - if minutes are greater than or equal to 60
    - reduce by 60
    - increase hour by 1
  - return new  minutes

=end

class Clock
  def initialize(time)
    @time = time
  end

  def self.at(hour, minute=0)
    time = { hr: hour, min: minute }
    Clock.new(time)
  end

  def +(min)
    time[:min] += min
    self
  end

  def -(min)
    time[:min] -= min
    while time[:min] < 0
      time[:hr] -= 1
      time[:min] += 60
    end
    self
  end

  def to_s
    min = fetch_min
    hr = fetch_hr

    "#{hr}:#{min}"
  end

  def ==(other_clock)
    to_s == other_clock.to_s
  end

  private

  attr_accessor :time

  def fetch_hr
    calculate_hr if time[:hr] >= 24 || time[:hr] < 0
    case time[:hr]
    when 0      then "00"
    when 1...10 then "0#{time[:hr]}"
    else             time[:hr].to_s
    end
  end

  def fetch_min
    calculate_min
    case time[:min]
    when 0 then      "00"
    when 1...10 then "0#{time[:min]}"
    else             time[:min].to_s
    end
  end

  def calculate_hr
    while time[:hr] >= 24
      time[:hr] -= 24
    end

    while time[:hr] < 0
      time[:hr] += 24
    end
  end

  def calculate_min
    minute = time[:min]
    while minute >= 60
      minute -= 60
      time[:hr] += 1
    end
    time[:min] = minute
  end
end
