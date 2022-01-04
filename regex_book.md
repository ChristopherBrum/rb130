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
    - [Summary](#summary)

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
