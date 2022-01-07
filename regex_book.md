# Introduction to Regular Expressions

- [Introduction](#introduction)
  - [What are Regular Expressions?](#what-are-regular-expressions)
  - [What Are Regex Used For?](#what-are-regex-used-for)
  - [A First Taste](#a-first-taste)
  - [How often will I use Regex?](#how-often-will-I-use-regex)
  - [Useful Learning Resources](#useful-learning-resources)
- [Regular Expressions](#regular-expressions)
  - [Basic Matching](#basic-matching)
    - [Alphanumerics](#alphanumerics)
    - [Special Characters](#special-characters)
    - [Concatenation](#concatenation)
    - [Alternation](#alternation)
    - [Control Character Escapes](#control-character-escapes)
    - [Ignoring Case](#ignoring-case)
    - [Basic Matching Summary](#basic-matching-summary)
  - [Character Classes](#character-classes)
    - [Set of Characters](#set-of-characters)
    - [Range of Characters](#range-of-characters)
    - [Negated Classes](#negatred-classes)
  - [Character CLass Shortcuts](#character-class-shortcuts)
    - [Any Character](#any-character)
    - [Whitespace](#whitespace)
    - [Digits and Hex Digits](#digits-and-hex-digits)
    - [Word Characters](#word-characters)
  - [Anchors](#anchors)
    - [Start/End of Line](#start-and-end-of-line)
    - [Lines vs Strings](#lines-vs-strings)
    - [Start/End of String](#start-and-end-of-string)
    - [Word Boundaries](#word-boundaries)
  - [Quantifiers](#quantifiers)
    - [Zero or More](#zero-or-more)
    - [One or More](#one-or-more)
    - [Zero or One](#zero-or-one)
    - [Ranges](#ranges)
    - [Greediness](#greediness)

---

## Introduction

## What are Regular Expressions?

Regex are **patterns** that we use to find information within a set of strings. We can use them 
to perform conditional tests, extract desired information, or modify information.

Each language has its own implementation of regex, but much of it applies regardless of language implementation.

### What Are Regex Used For?

We can use regex patterns to do many different things. For example:

- Check whether the pattern ss appears in the string Mississippi.
- Check whether the letter i occurs three or more times in Mississippi.
- Find and replace all instances of Mrs with Ms in a document.
- Does a file name begin with Bob and end with .txt or .md?
- Does a string have any non-alphanumeric characters in it?
- Did the user enter a valid integer?
- Are there any whitespace characters in the string?
- Find and replace all non-alphanumeric characters in a string with -.
- Locate all email addresses in a document.
- Split a line of text into fields assuming that each whitespace character delimits two values.

### A First Taste

At its most basic, regex are a string of characters between two `/` characters. For instance, we can find any occurrences of the string `'cat'` within some body of text with this expression: `/cat/`. This expression will match with `cat`, `cathy`, `scatter`, and `scat`. It will not match with `Cat` or `c a t`, though.

When things get more complex you can find regex patterns that look like: `/\bhttps?:\/\/\S+\?/`, which will find any web url that contains a query string. So even though it can look like nonsense, regex can be quite powerful.
  
### How often will I use Regex?

This depends on your role as a developer. If you do a lot of manipulation of strings then: yes. And most developer roles will have you manipulating strings to a greater or lesser degree.

### Useful Learning Resources

For Ruby:

- [Ruby Regexp Documentation](https://ruby-doc.org/core-3.1.0/Regexp.html)
- [Rubular](https://rubular.com/)

For JavaScript:

- [JS RegExp Documentation](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/RegExp)
- [Scriptular](https://scriptular.com/)

---

## Regular Expressions

### Basic Matching

At its most simplest form regex can be used to match substrings within a string or body of text.

#### Alphanumerics

Alphanumerics are the most basic off all patterns we can match using regex. You can construct an alphanumeric regex pattern by placing a letter or a number between two `/` characters.

For example, `/s/` matches the letter `s` anywhere within a string that it appears. It matches `cats`, `sack`, `custard`, and `Mississippi`. In the last example `/s/` matches 4 times, for each of the `s`'s in `Mississippi`.

It's important to note that `/s/` does not match `S` or `CATS`. `s` and `S` are different ascii characters.

We can put this into action like so:

```ruby
str = 'cast'
print "matched 's'" if str.match(/s/) # matched 's' 
print "matched 'x'" if str.match(/x/) # no output
```

Documentation for the Ruby method `#match` can be found [here](https://ruby-doc.org/core-3.1.0/Regexp.html#method-i-match)

#### Special Characters

Regex can also match non-alphanumeric characters, but because some of these special characters have a specific meaning in regex they may require special treatment.

The following characters have special meaning in regex:

`$ ^ * + ? . ( ) [ ] { } | \ /`

Characters that have a special meaning in regex are called **meta-characters**. In order to match a _literal meta-character_ you must prepend the character with a backslash(`\`). For example, to match a question mark you would do this: `/\?\`.

Special characters that are _not_ meta-characters have not special behavior and can be treated without the backslash(`\`). For instance, the colon(`:`) and the semi-colon(`;`) are not meta-characters and can be targeted like alpha-numeric characters.

When using meta-characters within square brackets things change. Which we'll cover shortly.

> As of this moment, Rubular does not support blank spaces, so square brackets must be used to target blank spaces. `/[ ]/` will be equivalent to `/ /` in Rubular.

#### Concatenation

You can _concatenate_ two or more patterns into a new pattern. The pattern `/cat/` is actually a concatenation of the regex pattern `/c/`, `/a/`, and `/t/` concatenated together. `/cat/` will match any string that contains a `c` followed by an `a` and then followed by a `t`.

This should illuminate that we can concatenate any pattern to another pattern to produce a larger regex. This is at the heart of regex:
>_patterns are the building blocks of regex_, not characters or strings.

You can construct complex regex by concatenating a series of patterns, and you can analyze a complex regex by breaking it down into its component patterns.

#### Alternation

**Alternation** is a simple way to construct a regex that matches one of several sub-patterns. At it's most basic it's done by separating different regex patterns with the `|` character. For example:

```txt
/(cat|dog|mouse)/
```

...can be used to match any text that has any of these patterns found within. Again, _case matters_. There is no built-in restriction on the number of alternations added to a regex pattern. In this example we did not prepend the `(`, `)`, or `|` characters with a backslash(`\`) because we wanted to use the "meta" meaning of those special characters.

#### Control Character Escapes

Most modern programming languages use **control character escapes** to represent characters that are not represented in a visual way. For example, `\n`, `\r\`, and `\t` are almost universally used to represent _new lines_, _carriage returns_, and _tabs_.

```ruby
puts "has tab" if text.match(/\t/)
```

This prints `has tab` if `text` contains a tab character.

#### Ignoring Case

Regex gives us other options for the patterns we're matching, the documentation refers to these _options_ as **flags** or **modifiers**. One such option is appending `i` to the end of the regex expression after the last `/` character, like this: `/launch/i`. What this does is tells the regex to ignore case in this circumstance. Below, without the optional `i` telling the regex to ignore case only the third line `launchschool.com` will match, but with the `i` appended to the close of the regex all `Launch`, `LAUNCH`, and `launch`(school.com) will be highlighted.

```txt
I love Launch School!
LAUNCH SCHOOL! Gotta love it!
launchschool.com
```

#### Summary

---

### Character Classes

#### Set of Characters

_Character class patterns_ match a single occurrences of any character within the square brackets. `/[abc]/` will find all occurrences of `a`, `b`, or `c` found within a string. So for the string `alphabetically` there will be three matches to `a` and one match for `b` and `c`. This can be utilized when asking a user for some type of input, for example choosing from a selection numbered 1 to 5 can be checked with `/[12345]/`, and asking for a `y/n` input can be checked with `/[ynYN]/`. Character classes also can be beneficial if you cannot use the `i` option to ignore case, for example: `/[Hh]oover/` matches `Hoover` and `hoover` but not `HOOVER`.

Character classes act as concatenation within your regex patterns. The last example `/[Hh]oover/` showed that the first letter of the string ending with `oover` could be a number of different characters. This can also be done with other character classes concatenated together, like: `/[abc][123]/`. This will match with any string that has a first character of `a`, `b`, or `c`, and a second character of `1`, `2`, or `3`.

It's good practice to organize like-character types together; digits, lowercase letters, uppercase letters, whitespace, etc. It will still if they are not arranged in a particular order but for readability grouping non-alphanumerical characters in the beginning or end of a character class is recommended.

Within a character class the number of meta-characters lessens only to:

`^` `\` `-` `[` `]`

Sometimes this depends on their position within a character class. For example, you can use `^` as a non-meta-character if it isn't the first character in the class, and you can use `-` as a non-meta-character if it is the first character in the class. You can also escape special characters even if not required in the circumstance.

#### Range of Characters

By using the hyphen(`-`) in a character class you can include a range of characters to look through for a match. `/[a-z]/` will match any lowercase letter, `/[A-Z]/` will match any uppercase number, and `/[a-z0-9]/` will match any lowercase letter or decimal digit.

Do not try to match ranges between special characters or uppercase and lowercase number. There are characters found between upper and lowercase letters and attempting to do things like `/[A-z]/` will yield unexpected results.

#### Negated Classes

We can use the `^` character at the beginning of a character class to negate the results you're trying to match. For example `/[abc]/` will match any instance of the characters `a`, `b` or `c` in a string, but `/[^abc]/` will match all characters that are _not_ `a`, `b` or `c` in a string. This works for individual character as well as ranges.

### Character Class Shortcuts

#### Any Character

A quick way to match with any character regardless of its type is to use the _any_ character (`.`). This character class pattern, `/./`, will match with any character expect for characters that are not typically seen, like newline characters, ot tab characters.

#### Whitespace

Whitespace characters are:

- the space (`' '`)
- tab (`\t`)
- vertical tab (`\v`)
- carriage return (`\r`)
- line feed (`\n`)
- form feed (`\f`)

Two frequently used shortcuts for character classes are the _whitespace shortcut_(`\s`) and the _non-whitespace shortcut_(`\S`).

```ruby
puts 'matched 1' if 'Four score'.match(/\s/)
puts 'matched 2' if "Four\tscore".match(/\s/)
puts 'matched 3' if "Four-score\n".match(/\s/)
puts 'matched 4' if "Four-score".match(/\s/)

# matched 1
# matched 2
# matched 3
```

The above code outputs `matched 1`, `matched 2`, and `matched 3` because some form of whitespace has been found within the string being matched, but the last string does not.

```ruby
puts 'matched 1' if 'a b'.match(/\S/)
puts 'matched 2' if " \t\n\r\f\v".match(/\S/)

# matched 1
```

`matched 1` is output because a non-whitespace character is found within the string being matched but the second there is not.

`\s` and `\S` can be used in and out of the square brackets. Outside square brackets, e.g., /\s/, it stands for one of the whitespace characters. Inside square brackets, e.g., /[a-z\s]/, they represent an alternative to the other members of the class. Here, for instance, it represents any lowercase alphabetic character or any whitespace character.

#### Digits and Hex Digits

We have shortcuts for _decimal digits_, `0-9`, and the _hexadecimal digits_, `0-9`, `A-F`, and `a-f`, because they're commonly found in character classes.

| Shortcut | Meaning |
|---|---|
| `\d` | Any decimal digit (0-9) |
| `\D` | Any character but a decimal digit |
| `\h` | Any hexadecimal digit (0-9, A-F, a-f) (Ruby) |
| `\H` | Any character but a hexadecimal digit (Ruby) |

Just like `\s` and `\S` these shortcuts can be used in and out of brackets.

#### Word Characters

`\w` matches _word characters_ and `\W` matches _non-word characters_. 'Word characters' does not mean alphabetical characters only, it encompasses all upper and lowercase letters(`a-z` and `A-Z`), all decimal digits(`0-9`), and the underscore(`_`).

These can be used in or out of brackets.

### Anchors

_Anchors_ allows us control how regex matches a string by telling the regex engine where matches can begin and where they can end. Anchors do not match characters, they tell specify where regex looks for matches in a string or body of text. This can be at the beginning or end of a string or line, or on a word or non-word-boundary.

### Start and End of Line

The `^` and `$` _meta-characters_ are **anchors** that specify the regex match at the beginning(`^`) or end(`$`) of a line of text, which can be different that the beginning or end of a string, but not always.

### Lines vs Strings

This can become more complicated when working with multiline string because we now how `\n`

```ruby
TEXT1 = "red fish\nblue fish"
puts "matched red" if TEXT1.match(/^red/)
puts "matched blue" if TEXT1.match(/^blue/)

# matched red
# matched blue
```

This outputs both `matched red` and `matched blue` because the `\n` character within `TEXT1` pushes `blue fish` to a newline and the `^` anchor looks for a match at the beginning of each _line_.

```ruby
TEXT2 = "red fish\nred shirt"
puts "matched fish" if TEXT2.match(/fish$/)
puts "matched shirt" if TEXT2.match(/shirt$/)

# matched fish
# matched shirt
```

This is the same reason that both `matched fish` and `matched shirt` are output by this code. The `$` anchor looks at the end of each _line_ for the pattern to match, which matches because of the `\n`.

### Start and End of String

More often than needing to match at the beginning or the end of a line we will need to match at the beginning or end of a _string_, and for these situations we have `\A`, `\z`, and `\Z`(there is no `\a`).

- `\A` matches at the beginning of a string.
- `\z` and `\Z` both match at the end of a string, but:
  - `\z` always matches at the end of a string, and...
  - `\Z` matches up to, but not including, a newline at the end of a string.

In general just use `\z` unless you actually have a situation where you need `\Z`.

```ruby
TEXT3 = "red fish\nblue fish"
TEXT4 = "red fish\nred shirt"
puts "matched red" if TEXT3.match(/\Ared/)
puts "matched blue" if TEXT3.match(/\Ablue/)
puts "matched fish" if TEXT4.match(/fish\z/)
puts "matched shirt" if TEXT4.match(/shirt\z/)

# matched red
# matched shirt
```

### Word Boundaries

The `\B` and `\b` anchors anchor regex matches to _word boundaries_(`\b`) and _non-word boundaries_(`\B`). To these anchors words are considered sequences of word characters(`\w`) and non-words are considered sequences of non-word characters(`\W`).

A word boundary occurs:

- between any pair of characters, one of which is a word character and one which is not.
- at the beginning of a string if the first character is a word character.
- at the end of a string if the last character is a word character.

A non-word boundary occurs:

- between any pair of characters, both of which are word characters or both of which are not word characters.
- at the beginning of a string if the first character is a non-word character.
- at the end of a string if the last character is a non-word character.

```txt
Eat some food.
```

Here, word boundaries occur before the `E`, `s`, and `f` at the start of the three words, and after the `t`, `e`, and `d` at their ends. Non-word boundaries occur elsewhere, such as between the `o` and `m` in `some`, and following the `.` at the end of the sentence.

The regex pattern `/\b\w\w\w\b/` will match with any 3 letter words consisting of "word characters" with word boundaries at the start and end of the word.

```txt
One fish,
Two fish,
Red fish,
Blue fish.
123 456 7890
```

This code will match with `One` , `Two`, `Red`, `123`, and `456`.

`\b` and `\B` do not working within brackets of character classes.

### Quantifiers

#### Zero or More

The _zero or more_ quantifier(`*`) points at a character and will match with that character is there _zer_ or more instances of that character within the string. For example the regex pattern `/\b\d\d\d\d*\b/` when searching through the following code:

```txt
Four and 20 black birds
365 days in a year, 100 years in a century.
My phone number is 222-555-1212.
My serial number is 345678912.
```

...will match with `365`, `100`, `222`, `555`, `1212`, and `345678912`, but it does not match `20`. This is because the pattern(`/\b\d\d\d\d*\b/`) is being broken down by the regex engine like so:

| Pattern | Explanation |
|---|---|
| `\b` | Starting at a word boundary |
| `\d` | A single digit followed by ... |
| `\d` | a single digit followed by ... |
| `\d` | a single digit followed by ... |
| `\d*` | Zero or more additional digits |
| `\b` | Ending with a word boundary |

Here's another way to see this is to try the regex `/co*t/` against these strings:

```txt
ct
cot
coot
cooot
```

Each of these strings match the regex pattern, even the one without an `o`.

> The quantifier always applies to one pattern; the pattern it finds to the left of the quantifier.

But you can group within parenthesis to define the pattern you want to apply `*` to. For example the regex pattern `/1(234)*5/` matched again these strings:

```txt
15
12345
12342342345
1234235

# The first 3 patterns match
# 15
# 12345
# 12342342345
```

The first 3 strings match the pattern because the `*` quantifier is saying that `234` can occur zero or more times between `1` and `5` and will result in a match.

#### One or More

The `+` quantifier is nearly identical to the `*` quantifier except that it matches one or more occurrences of a pattern. If we take the example for early and(`/\b\d\d\d+\b/`) and swap out the `*` for a `+`, we can see that;

```txt
Four and 20 black birds
365 days in a year, 100 years in a century.
My phone number is 222-555-1212.
My serial number is 345678912.
```

...will match with `365`, `100`, `222`, `555`, `1212`, and `345678912`.

But if we use the last example from zero or more quantifiers we can see that the regex pattern `/1(234)+5/` matched again these strings:

```txt
15
12345
12342342345
1234235

# The second and third patterns match
# 12345
# 12342342345
```

...does not match with the first example because the pattern `234` does not occur one or more times.

#### Zero or One

In some situation you made need to determine whether a pattern occurs once, or doesn't occur at all. That's where the `+` quantifier comes in. If you need to test whether a string contains the words `cot` or `coot`, but don't want to match against `ct` or `cooot`, you can use `/coo?t/`, which matches a `c` followed by an `o` followed by an _optional_ `o` followed by a `t`.

```txt
Scott scoots but doesn't act cooot.
```

`cot` and `coot` in the first two words match.

This quantifier can be very useful when working with dates that can be stored as `20170111` or `2017-01-11` so the `-` is optional.

#### Ranges

Some situations may call for you to test whether a phone number has exactly 10 digits to it, or you must find all words with exactly 6 letters, or find words that contain 5-8 characters. This is whether the _range quantifier_ comes in handy. The range quantifier consists of a pair of curly braces(`{}`) with one or 2 numbers, and an optional `,` in it.

- `p{m}` matches precisely `m` occurrences of the pattern `p`.
- `p{m,}` matches `m` or more occurrences of `p`.
- `p{m,n}` matches `m` or more occurrences of `p`, but not more than `n`.

If you need to test a string to see if it contains precisely ten consecutive digits (perhaps it represents a US-style phone number), you can try it with the regex `/\b\d{10}\b/` and these strings:

```txt
2225551212 1234567890 123456789 12345678900
```

The first 2 digits match because the are comprised of exactly 10 digits.

To match numbers that are at least 10 digits you would use this regex pattern: `/\b\d{10,}\b/`

And to match numbers that are between 5 and 8 digits you would use this regex pattern: `/\b\d{5,8}\b/`

#### Greediness

The quantifiers we've been using sof far are considered **greedy** because they always match the longest possible string that they can. If we're matching `/a[abc]*c/` against `xabcbcbacy`, this pattern matches `abcbcbac`, not `abc` or `abcbc` both of which could match the pattern, but are shorter than the final match string. This is generally not an issue but can be confusing when it comes up.

Most cases greediness is what we want but sometimes we do want our pattern to be matched in a **lazy** way. To do so, we can add another `?` quantifier after the initial one and it will make the quantifier lazy. For example, `/a[abc]*?c/` matches `abc` and `ac` in `xabcbcbacy`.

## Using Regular Expressions

1. Write a method that returns true if its argument looks like a URL, false if it does not.

```ruby
=begin
Explicit
- write a method that takes one srting as an argument
- if the string has the characterteristics of a URL, return true
- Otherwise, return false

Implicit
- cannot have white space before or after the url
- cannot have additional characters before or after the url
- must start with 'http'
- can optionally have a 's' after
- must have `://` after
- must have at least one character after

DS
- string input
- boolean output

Algo
- beginning of string must start with 'http'
- next a single 's' is optional
- must have '://' next
- must contain one word character after
- string must end with a word character
- return true or false based on whether a match was found

=end

def url?(string)
  !!string.match(/\Ahttps?:\/\/\S+\z/)
end

p url?('http://launchschool.com')   == true
p url?('https://example.com')       == true
p url?('https://example.com hello') == false
p url?('   https://example.com')    == false
```

2. Write a method that returns all of the fields in a haphazardly formatted string. A variety of spaces, tabs, and commas separate the fields, with possibly multiple occurrences of each delimiter.

```ruby
=begin
Explicit
- method returns all fields of a haphazardly formatted string
- strings boundaries are: spaces, tabs, commas
- string boundaries can be individual or multiple

Implicit
- Return value should be an array of the separated strings

DS
- Strings as an input
- Array of strings as output

algo
- split given string at every, or multiple instances of a comma, space, or tab character.

=end

def fields(string)
  string.split(/[\t, ]+/)
end
  
p fields("Pete,201,Student") == ["Pete", "201", "Student"]

p fields("Pete \t 201    ,  TA") == ["Pete", "201", "TA"]

p fields("Pete \t 201") == ["Pete", "201"]

p fields("Pete \n 201") == ["Pete", "\n", "201"]
```

3. Write a method that changes the first arithmetic operator (+, -, *, /) in a string to a '?' and returns the resulting string. Don't modify the original string.

```ruby
=begin
Explicit
- write a method that takes one string as an argument
- change the first arithmetic operator (+, -, *, /) in the string to a '?'
- then return the resulting string
- do not modify the original string

Implicit
- 

DS
- string input
- string output

Algo
- substitute the first arithmetic operator (+, -, *, /) found in the given string with '?'
- do not mutate the given string

=end

def mystery_math(string)
  string.sub(/[+\-*\/]/, '?')
end

p mystery_math('4 + 3 - 5 = 2') == '4 ? 3 - 5 = 2'
p mystery_math('(4 * 3 + 2) / 7 - 1 = 1') == '(4 ? 3 + 2) / 7 - 1 = 1'
```

4. Write a method that changes every arithmetic operator (+, -, *, /) to a '?' and returns the resulting string. Don't modify the original string.

```ruby
=begin
Explicit
- write a method that takes one string object as an argument
- it will change every arithmetic operator (+, -, *, /) to a '?'
- then, return the resulting string
- do not modify the given string

Implicit
- 

DS
- string input
- string output

Algo
- substitute every arithmetic operator (+, -, *, /) found in the given string with '?'
- do not mutate the given string

=end

def mysterious_math(string)
  string.gsub(/[+\/*\-]/, '?')
end

p mysterious_math('4 + 3 - 5 = 2')           == '4 ? 3 ? 5 = 2'
p mysterious_math('(4 * 3 + 2) / 7 - 1 = 1') == '(4 ? 3 ? 2) ? 7 ? 1 = 1'
```

5. Write a method that changes the first occurrence of the word apple, blueberry, or cherry in a string to danish.

```ruby
=begin
Explicit
- write a method that takes one string as an argument
- change the first occurrence of the word berry/blueberry/cherry to 'danish'

Implicit
- instances of the given trigger words can not be sunstrings of a string, they must have whitespace as a boundary at the front and end

DS
- string input
-string output

Algo
- find the first instance of the trigger words within the given string
- the instance must have white space as front and end boundaries
- resplace with 'danish'

=end

def danish(string)
  string.sub(/\b(apple|cherry|blueberry)\b/, 'danish')
end

p danish('An apple a day keeps the doctor away') ==  'An danish a day keeps the doctor away'
p danish('My favorite is blueberry pie') ==  'My favorite is danish pie'
p danish('The cherry of my eye') ==  'The danish of my eye'
p danish('apple. cherry. blueberry.') ==  'danish. cherry. blueberry.'
p danish('I love pineapple') ==  'I love pineapple'
```

6. Challenge: write a method that changes strings in the date format 2016-06-17 to the format 17.06.2016. You must use a regular expression and should use methods described in this section.

```ruby
=begin
Explicit
- write a method that takes one string as an argument
- change a string if it is in date format (2016-06-17) to the format (17.06.2016)
- use a regex

Implicit
- string formatted like 2016/06/17 will not be formatted
- the day and the year will be swapped

DS
- string input
- string output
- arrays possibly

Algo
- if given string contains 4 digits, a '-', 2 digits, a '-', and 2 digits
  - split string at '-' into array
  - reverse array
  - join array with '.'
  - return string
- otherwise 
  -return given string

=end

def format_date(string)
  return string unless string.match?(/\A[\d]{4}\-[\d]{2}\-[\d]{2}\z/)
  string.split('-').reverse.join('.')
end

p format_date('2016-06-17') == '17.06.2016'
p format_date('2016/06/17') == '2016/06/17' # (no change)
```

7. Challenge: write a method that changes dates in the format `2016-06-17` or `2016/06/17` to the format `17.06.2016` You must use a regular expression and should use methods described in this section.

```ruby
=begin
Explicit
- write a method that takes one string as an argument
- change a string if it is in date format (2016-06-17) or (2016/06/17)to the format (17.06.2016)
- use a regex

Implicit
- the day and the year will be swapped
- if a combo of - and / are used, return given string

DS
- string input
- string output
- arrays possibly

Algo
- if given string contains 4 digits, a '-' or '/', 2 digits, a '-' or '/', and 2 digits
  - split string at trigger character into array
  - reverse array
  - join array with '.'
  - return string
- otherwise 
  -return given string
=end

def format_date(string)
   string.gsub(/\b([\d]{4})([\-\/])([\d]{2})\2([\d]{2})\b/, '\4.\3.\1')
end

p format_date('2016-06-17') == '17.06.2016'
p format_date('2017/05/03') == '03.05.2017'
p format_date('2015/01-31') == '2015/01-31' # (no change)
```
