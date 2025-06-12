# Chapter 6: Strings - Playing with Text 📝

## 🎭 What Are Strings?

Strings are Ruby's way of working with text - words, sentences, names, messages, anything made of letters and symbols! Think of strings like a necklace made of letter beads. You can add beads, remove them, rearrange them, and create beautiful combinations!

## 📖 Creating Strings

There are several ways to create strings in Ruby:

```ruby
# Using double quotes
name = "Ruby"
message = "Hello, world!"

# Using single quotes
greeting = 'Hi there!'
language = 'Ruby programming'

# Multi-line strings
poem = "Roses are red,
Violets are blue,
Ruby is awesome,
And so are you!"

# Or using heredoc for long text
story = <<~TEXT
  Once upon a time, in a land of code,
  There lived a language named Ruby.
  It was friendly, powerful, and fun to use.
  The end!
TEXT
```

## 🎪 Single vs Double Quotes

Both work, but they have special powers:

### Double Quotes - The Magic Quotes ✨
```ruby
name = "Alice"
age = 25

# String interpolation (putting variables inside)
message = "Hello, #{name}! You are #{age} years old."
puts message  # Hello, Alice! You are 25 years old.

# Escape sequences work
puts "Line 1\nLine 2"  # \n creates a new line
puts "Tab\there"       # \t creates a tab
```

### Single Quotes - The Literal Quotes 📋
```ruby
# What you see is what you get
message = 'Hello, #{name}!'
puts message  # Hello, #{name}! (literally)

# Escape sequences don't work (except for \' and \\)
puts 'Line 1\nLine 2'  # Line 1\nLine 2 (literally)
```

**Rule of thumb:** Use double quotes when you need variables inside strings, single quotes otherwise.

## 🛠️ String Methods - Your Text Toolkit

Ruby gives strings lots of superpowers! Here are the most useful ones:

### Basic Information
```ruby
text = "Ruby Programming"

puts text.length      # 16 (number of characters)
puts text.size        # 16 (same as length)
puts text.empty?      # false (string has content)

empty_string = ""
puts empty_string.empty?  # true
```

### Changing Case
```ruby
name = "ruby programming"

puts name.upcase      # RUBY PROGRAMMING
puts name.downcase    # ruby programming
puts name.capitalize  # Ruby programming
puts name.swapcase    # RUBY PROGRAMMING (swaps upper/lower)

# Title case (capitalize each word)
puts name.split.map(&:capitalize).join(' ')  # Ruby Programming
```

### Finding Things
```ruby
sentence = "I love Ruby programming!"

puts sentence.include?("Ruby")     # true
puts sentence.include?("Python")   # false
puts sentence.start_with?("I")     # true
puts sentence.end_with?("!")       # true

# Finding position
puts sentence.index("Ruby")        # 7 (position where "Ruby" starts)
puts sentence.index("Python")      # nil (not found)
```

### Modifying Strings
```ruby
text = "  Ruby is awesome!  "

puts text.strip       # "Ruby is awesome!" (removes spaces from ends)
puts text.chomp       # Removes newlines from end
puts text.reverse     # "!emosewa si ybuR  "

# Replacing text
puts text.gsub("awesome", "amazing")  # "  Ruby is amazing!  "
puts text.sub("Ruby", "Python")      # "  Python is awesome!  "
```

## 🔧 Building and Combining Strings

### String Concatenation (Joining)
```ruby
first_name = "Ruby"
last_name = "Gem"

# Method 1: Using +
full_name = first_name + " " + last_name
puts full_name  # Ruby Gem

# Method 2: Using << (more efficient)
greeting = "Hello"
greeting << " there!"
puts greeting  # Hello there!

# Method 3: Using interpolation (best for readability)
age = 28
intro = "My name is #{first_name} and I'm #{age} years old."
puts intro
```

### String Multiplication
```ruby
# Repeat strings
puts "Ruby! " * 3        # Ruby! Ruby! Ruby! 
puts "=" * 20            # ====================
puts "🎉" * 5            # 🎉🎉🎉🎉🎉
```

## 🎯 Practical String Examples

### Example 1: Name Formatter
```ruby
puts "What's your full name?"
full_name = gets.chomp

# Split into parts
name_parts = full_name.split
first_name = name_parts[0]
last_name = name_parts[-1]  # Last element

puts "First name: #{first_name.capitalize}"
puts "Last name: #{last_name.capitalize}"
puts "Initials: #{first_name[0].upcase}.#{last_name[0].upcase}."
puts "Username suggestion: #{first_name.downcase}#{last_name.downcase}"
```

### Example 2: Word Counter
```ruby
puts "Enter a sentence:"
sentence = gets.chomp

word_count = sentence.split.length
char_count = sentence.length
char_count_no_spaces = sentence.gsub(" ", "").length

puts "Words: #{word_count}"
puts "Characters (with spaces): #{char_count}"
puts "Characters (without spaces): #{char_count_no_spaces}"
```

### Example 3: Simple Text Encryption
```ruby
puts "Enter a secret message:"
message = gets.chomp

# Simple Caesar cipher (shift each letter by 1)
encrypted = message.chars.map do |char|
  if char.match?(/[a-zA-Z]/)
    # Shift letter by 1
    (char.ord + 1).chr
  else
    char  # Keep non-letters as is
  end
end.join

puts "Encrypted: #{encrypted}"

# To decrypt, shift back by 1
decrypted = encrypted.chars.map do |char|
  if char.match?(/[a-zA-Z]/)
    (char.ord - 1).chr
  else
    char
  end
end.join

puts "Decrypted: #{decrypted}"
```

## 🎨 String Formatting and Templates

### Creating Templates
```ruby
template = "Hello, %{name}! Welcome to %{place}."

# Fill in the template
message1 = template % {name: "Alice", place: "Ruby Land"}
message2 = template % {name: "Bob", place: "Code City"}

puts message1  # Hello, Alice! Welcome to Ruby Land.
puts message2  # Hello, Bob! Welcome to Code City.
```

### Padding and Alignment
```ruby
name = "Ruby"

puts name.ljust(10)     # "Ruby      " (left-aligned, 10 chars)
puts name.rjust(10)     # "      Ruby" (right-aligned, 10 chars)
puts name.center(10)    # "   Ruby   " (centered, 10 chars)

# With custom padding
puts name.ljust(10, "-")  # "Ruby------"
puts name.center(10, "*") # "***Ruby***"
```

## 🔍 String Inspection and Conversion

### Converting to Other Types
```ruby
# String to number
age_string = "25"
age_number = age_string.to_i
price_string = "19.99"
price_number = price_string.to_f

puts age_number + 5     # 30
puts price_number * 2   # 39.98

# Number to string
number = 42
text = number.to_s
puts "The answer is " + text  # The answer is 42

# Other conversions
puts "ruby".to_sym      # :ruby (symbol)
puts [1, 2, 3].to_s     # "[1, 2, 3]" (array to string)
```

### String Analysis
```ruby
text = "Hello, Ruby World!"

# Character by character
puts text[0]        # "H" (first character)
puts text[-1]       # "!" (last character)
puts text[0, 5]     # "Hello" (5 characters starting from position 0)
puts text[7..-1]    # "Ruby World!" (from position 7 to end)

# As an array of characters
chars = text.chars
puts chars.inspect  # ["H", "e", "l", "l", "o", ",", " ", "R", "u", "b", "y", " ", "W", "o", "r", "l", "d", "!"]
```

## 🎮 String Games and Challenges

### Challenge 1: Palindrome Checker
```ruby
puts "Enter a word to check if it's a palindrome:"
word = gets.chomp.downcase.gsub(/[^a-z]/, "")  # Remove non-letters

if word == word.reverse
  puts "#{word} is a palindrome! 🎉"
else
  puts "#{word} is not a palindrome."
end
```

### Challenge 2: Pig Latin Translator
```ruby
puts "Enter a word to translate to Pig Latin:"
word = gets.chomp.downcase

if word.start_with?(/[aeiou]/)
  # Starts with vowel: add "way"
  pig_latin = word + "way"
else
  # Starts with consonant: move first letter to end, add "ay"
  pig_latin = word[1..-1] + word[0] + "ay"
end

puts "Pig Latin: #{pig_latin}"
```

### Challenge 3: Simple Mad Libs
```ruby
template = "The %{adjective1} %{noun1} %{verb} over the %{adjective2} %{noun2}."

puts "Let's create a silly sentence!"
puts "Enter an adjective:"
adj1 = gets.chomp

puts "Enter a noun:"
noun1 = gets.chomp

puts "Enter a verb:"
verb = gets.chomp

puts "Enter another adjective:"
adj2 = gets.chomp

puts "Enter another noun:"
noun2 = gets.chomp

story = template % {
  adjective1: adj1,
  noun1: noun1,
  verb: verb,
  adjective2: adj2,
  noun2: noun2
}

puts "\nYour silly sentence:"
puts story
```

## ⚠️ Common String Mistakes

### 1. Forgetting to Convert Types
```ruby
# This won't work as expected:
age = "25"
puts age + 5  # Error! Can't add number to string

# Fix it:
age = "25".to_i
puts age + 5  # 30
```

### 2. Modifying Strings In-Place
```ruby
name = "ruby"

# This doesn't change the original:
name.upcase
puts name  # Still "ruby"

# This does:
name = name.upcase
puts name  # "RUBY"

# Or use the ! version:
name.upcase!
puts name  # "RUBY"
```

### 3. Confusing Single and Double Quotes
```ruby
name = "Ruby"

# Won't work as expected:
puts 'Hello, #{name}!'  # Hello, #{name}!

# Use double quotes for interpolation:
puts "Hello, #{name}!"  # Hello, Ruby!
```

## 🎉 String Master!

You now know how to:
- ✅ Create strings with single and double quotes
- ✅ Use string interpolation to insert variables
- ✅ Manipulate strings with built-in methods
- ✅ Find and replace text within strings
- ✅ Convert between strings and other data types
- ✅ Format and align text beautifully
- ✅ Build fun text-based programs

Strings are everywhere in programming - user input, file content, web pages, messages. Master strings and you'll be able to handle any text challenge!

---

## 🚀 What's Next?

Now that you can manipulate text like a pro, let's learn about arrays - Ruby's way of organizing lists of things!

**[← Previous: Numbers and Math](./05-numbers-math.md)** | **[Next: Arrays - Lists of Everything →](./07-arrays.md)**

---

### 🎯 String Challenges

Before moving on, try creating:
1. **Password Generator**: Create random passwords with letters and numbers
2. **Text Reverser**: Reverse words in a sentence but keep word order
3. **Vowel Counter**: Count vowels in any text
4. **ASCII Art Generator**: Create simple text art from user input

Strings are powerful - have fun playing with text! 📝✨
