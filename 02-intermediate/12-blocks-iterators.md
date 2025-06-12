# Chapter 12: Blocks and Iterators - Code That Travels 🎒

[← Previous: Loops](./11-loops.md) | [Next: Classes and Objects →](./13-classes-objects.md)

## What Are Blocks? 🧩

Imagine you have a magic backpack that can carry pieces of code around! That's basically what a block is - it's a chunk of code that you can pass around to different methods. It's like giving someone a recipe card that they can use whenever they need it! 👨‍🍳

Blocks are one of Ruby's most powerful and fun features. They make your code more flexible and elegant!

## How to Write Blocks ✍️

There are two ways to write blocks in Ruby:

### 1. The Curly Braces Way `{ }`
Best for short, one-line blocks:

```ruby
# Print each number
[1, 2, 3].each { |number| puts number }

# Square each number
[1, 2, 3].map { |num| num * num }
```

### 2. The do-end Way
Best for longer blocks:

```ruby
# Print each number with a message
[1, 2, 3].each do |number|
  puts "The number is: #{number}"
  puts "And its square is: #{number * number}"
end
```

The `|number|` part is called a **block parameter** - it's like a temporary variable that holds each item as the block processes them!

## Amazing Iterator Methods 🔮

### `each` - The Visitor 👋

The `each` method visits every item in a collection and does something with it:

```ruby
# Say hello to each friend
friends = ["Alice", "Bob", "Charlie"]

friends.each do |friend|
  puts "Hello, #{friend}! 👋"
end

# Output:
# Hello, Alice! 👋
# Hello, Bob! 👋
# Hello, Charlie! 👋
```

### `map` - The Transformer 🔄

The `map` method creates a new array by transforming each element:

```ruby
# Transform numbers to their squares
numbers = [1, 2, 3, 4, 5]
squares = numbers.map { |num| num * num }

puts squares
# Output: [1, 4, 9, 16, 25]

# Transform names to uppercase
names = ["alice", "bob", "charlie"]
loud_names = names.map { |name| name.upcase }

puts loud_names
# Output: ["ALICE", "BOB", "CHARLIE"]
```

### `select` - The Picker 🎯

The `select` method picks only the elements that match a condition:

```ruby
# Find even numbers
numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
even_numbers = numbers.select { |num| num.even? }

puts even_numbers
# Output: [2, 4, 6, 8, 10]

# Find long names
names = ["Jo", "Alice", "Bob", "Alexander", "Sue"]
long_names = names.select { |name| name.length > 3 }

puts long_names
# Output: ["Alice", "Alexander"]
```

### `reject` - The Opposite of Select 🚫

The `reject` method removes elements that match a condition:

```ruby
# Remove odd numbers
numbers = [1, 2, 3, 4, 5, 6]
not_odd = numbers.reject { |num| num.odd? }

puts not_odd
# Output: [2, 4, 6]
```

### `find` - The Detective 🕵️

The `find` method finds the first element that matches a condition:

```ruby
# Find the first even number
numbers = [1, 3, 4, 5, 6]
first_even = numbers.find { |num| num.even? }

puts first_even
# Output: 4
```

### `reduce` - The Combiner 🔗

The `reduce` method combines all elements into a single value:

```ruby
# Add all numbers together
numbers = [1, 2, 3, 4, 5]
sum = numbers.reduce { |total, num| total + num }

puts sum
# Output: 15

# Find the biggest number
biggest = numbers.reduce { |max, num| num > max ? num : max }

puts biggest
# Output: 5

# You can also give it a starting value
sum_with_start = numbers.reduce(100) { |total, num| total + num }

puts sum_with_start
# Output: 115 (100 + 1 + 2 + 3 + 4 + 5)
```

### `count` - The Counter 📊

Count elements that match a condition:

```ruby
# Count even numbers
numbers = [1, 2, 3, 4, 5, 6, 7, 8]
even_count = numbers.count { |num| num.even? }

puts even_count
# Output: 4
```

## Ranges and Blocks 📏

Ranges work great with blocks too!

```ruby
# Print numbers from 1 to 5
(1..5).each { |num| puts "Number: #{num}" }

# Create an array of squares
squares = (1..10).map { |num| num * num }
puts squares
# Output: [1, 4, 9, 16, 25, 36, 49, 64, 81, 100]

# Sum of numbers from 1 to 100
sum = (1..100).reduce { |total, num| total + num }
puts sum
# Output: 5050
```

## String Magic with Blocks 🎭

Even strings have methods that use blocks!

```ruby
# Process each character
"Hello".each_char { |char| puts "Character: #{char}" }

# Process each line
text = "Line 1\nLine 2\nLine 3"
text.each_line { |line| puts "-> #{line.chomp}" }
```

## Real-World Examples 🌍

### Grade Calculator

```ruby
# Calculate class average
grades = [85, 92, 78, 96, 88, 77, 94]

puts "📊 Grade Report"
puts "==============="

# Show all grades
puts "Individual grades:"
grades.each_with_index do |grade, index|
  puts "Student #{index + 1}: #{grade}%"
end

# Calculate average
average = grades.reduce { |sum, grade| sum + grade } / grades.length.to_f
puts "\nClass average: #{average.round(2)}%"

# Find highest and lowest
highest = grades.max
lowest = grades.min
puts "Highest grade: #{highest}%"
puts "Lowest grade: #{lowest}%"

# Count passing grades (70 or above)
passing_count = grades.count { |grade| grade >= 70 }
puts "Students passing: #{passing_count}/#{grades.length}"
```

### Shopping Cart

```ruby
# Shopping cart with prices
cart = [
  { item: "Apple", price: 1.20, quantity: 3 },
  { item: "Banana", price: 0.80, quantity: 6 },
  { item: "Orange", price: 1.50, quantity: 2 },
  { item: "Milk", price: 3.50, quantity: 1 }
]

puts "🛒 Shopping Cart"
puts "=================="

# Show each item with total
cart.each do |product|
  item_total = product[:price] * product[:quantity]
  puts "#{product[:item]}: $#{product[:price]} × #{product[:quantity]} = $#{item_total}"
end

# Calculate total
grand_total = cart.reduce(0) do |total, product|
  total + (product[:price] * product[:quantity])
end

puts "\nGrand Total: $#{grand_total}"

# Find most expensive item
most_expensive = cart.max_by { |product| product[:price] }
puts "Most expensive item: #{most_expensive[:item]} ($#{most_expensive[:price]})"
```

### Word Analyzer

```ruby
text = "Ruby is awesome and fun to learn"
words = text.split

puts "📝 Text Analysis"
puts "=================="
puts "Original text: #{text}"

# Count words
puts "Word count: #{words.length}"

# Find longest word
longest = words.max_by { |word| word.length }
puts "Longest word: #{longest} (#{longest.length} letters)"

# Count words by length
word_lengths = words.map { |word| word.length }
puts "Average word length: #{word_lengths.reduce(:+) / word_lengths.length.to_f} letters"

# Find words longer than 4 letters
long_words = words.select { |word| word.length > 4 }
puts "Words longer than 4 letters: #{long_words.join(', ')}"
```

## Creating Your Own Iterator Methods 🔧

You can create methods that accept blocks!

```ruby
# A method that repeats something with a delay
def repeat_with_delay(times)
  times.times do |i|
    yield(i + 1) if block_given?  # Call the block if one was given
    sleep(1)  # Wait 1 second
  end
end

# Use it!
repeat_with_delay(3) do |count|
  puts "Message #{count}: Hello!"
end

# Output (with 1 second delays):
# Message 1: Hello!
# Message 2: Hello!
# Message 3: Hello!
```

### Check if a Block was Given

```ruby
def greet(name)
  puts "Hello, #{name}!"
  
  if block_given?
    yield  # Call the block
  else
    puts "Have a great day!"
  end
end

# Without a block
greet("Alice")
# Output:
# Hello, Alice!
# Have a great day!

# With a block
greet("Bob") do
  puts "Welcome to Ruby class!"
end
# Output:
# Hello, Bob!
# Welcome to Ruby class!
```

## Fun Challenges 🎮

### Challenge 1: Number Games
```ruby
# Create a range of numbers and play with them
numbers = (1..20).to_a

# Find all numbers divisible by 3
threes = numbers.select { |n| n % 3 == 0 }
puts "Divisible by 3: #{threes}"

# Double all odd numbers
doubled_odds = numbers.map { |n| n.odd? ? n * 2 : n }
puts "Doubled odds: #{doubled_odds}"

# Find the sum of all even numbers
even_sum = numbers.select(&:even?).reduce(:+)
puts "Sum of evens: #{even_sum}"
```

### Challenge 2: Name Processor
```ruby
names = ["alice smith", "BOB JONES", "Charlie Brown", "diana PRINCE"]

# Capitalize properly
proper_names = names.map do |name|
  name.split.map(&:capitalize).join(' ')
end

puts "Proper names: #{proper_names}"

# Find names with more than one word
full_names = names.select { |name| name.split.length > 1 }
puts "Full names: #{full_names.length}"

# Get initials
initials = names.map do |name|
  name.split.map { |part| part[0].upcase }.join('.')
end

puts "Initials: #{initials}"
```

### Challenge 3: Simple Game Statistics
```ruby
scores = [450, 320, 680, 290, 510, 720, 380]

puts "🎮 Game Statistics"
puts "=================="

# Basic stats
puts "Games played: #{scores.length}"
puts "Highest score: #{scores.max}"
puts "Lowest score: #{scores.min}"
puts "Average score: #{scores.reduce(:+) / scores.length}"

# Performance analysis
good_games = scores.count { |score| score >= 500 }
puts "Good games (500+): #{good_games}"

# Score ranges
score_ranges = scores.group_by do |score|
  case score
  when 0..299 then "Poor"
  when 300..499 then "Good"
  when 500..699 then "Great"
  else "Excellent"
  end
end

score_ranges.each { |range, scores| puts "#{range}: #{scores.length} games" }
```

## Block Shortcuts 🚀

Ruby has some cool shortcuts for common block operations:

```ruby
# These are equivalent:
numbers = [1, 2, 3, 4, 5]

# Long way
evens = numbers.select { |n| n.even? }

# Short way (symbol to proc)
evens = numbers.select(&:even?)

# More examples:
words = ["hello", "world", "ruby"]
caps = words.map(&:upcase)      # Same as { |w| w.upcase }
lengths = words.map(&:length)   # Same as { |w| w.length }
sum = numbers.reduce(:+)        # Same as { |a, b| a + b }
```

## What's Next? 🚀

Fantastic! You've learned about blocks and iterators - some of Ruby's most powerful features! These tools will make your code more elegant and fun to write.

Next up, we'll dive into **Classes and Objects** - where you'll learn to create your own custom data types and build amazing things! 🏗️

## Quick Reference 📋

```ruby
# Common iterator methods
array.each { |item| ... }           # Visit each item
array.map { |item| ... }            # Transform each item
array.select { |item| ... }         # Pick matching items
array.reject { |item| ... }         # Remove matching items
array.find { |item| ... }           # Find first match
array.reduce { |acc, item| ... }    # Combine all items
array.count { |item| ... }          # Count matching items

# Block syntax
{ |param| code }                    # Single line
do |param|                          # Multiple lines
  code
end

# Block shortcuts
&:method_name                       # Symbol to proc
```

Remember: Blocks are like giving someone a recipe to follow for each item in your collection! 📝✨

[← Previous: Loops](./11-loops.md) | [Next: Classes and Objects →](./13-classes-objects.md)
