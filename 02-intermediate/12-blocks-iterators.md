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

## Block Variables and Scope 🔍

Understanding how variables work in blocks is super important! Let's explore the magic of block scope.

### Block Parameters vs Outside Variables

Block parameters are like temporary visitors - they only exist inside the block:

```ruby
# This variable exists outside the block
outside_var = "I'm outside!"

numbers = [1, 2, 3]
numbers.each do |num|  # 'num' only exists inside this block
  puts "Number: #{num}"
  puts "Outside variable: #{outside_var}"  # Can access outside variables
end

# puts num  # This would cause an error - 'num' doesn't exist here!
```

### Block Variable Shadowing ⚠️

Be careful! If you use the same name for a block parameter as an outside variable, the block parameter "shadows" (hides) the outside one:

```ruby
name = "Alice"
puts "Before block: #{name}"

["Bob", "Charlie"].each do |name|  # This 'name' shadows the outside 'name'
  puts "Inside block: #{name}"
end

puts "After block: #{name}"  # Still "Alice" - the outside variable wasn't changed

# Output:
# Before block: Alice
# Inside block: Bob
# Inside block: Charlie
# After block: Alice
```

### Creating Variables Inside Blocks

Variables created inside blocks can't be accessed from outside:

```ruby
[1, 2, 3].each do |num|
  doubled = num * 2  # This variable only exists inside the block
  puts "Doubled: #{doubled}"
end

# puts doubled  # Error! 'doubled' doesn't exist outside the block
```

### Multiple Block Parameters 🎭

Some methods can pass multiple values to your block! It's like getting multiple pieces of information at once.

#### `each_with_index` - Position and Value

Get both the item and its position:

```ruby
fruits = ["apple", "banana", "cherry"]

fruits.each_with_index do |fruit, index|
  puts "#{index + 1}. #{fruit.capitalize}"
end

# Output:
# 1. Apple
# 2. Banana
# 3. Cherry
```

#### Hash Iteration - Key and Value

When iterating over hashes, you get both the key and value:

```ruby
ages = { "Alice" => 25, "Bob" => 30, "Charlie" => 35 }

ages.each do |name, age|
  puts "#{name} is #{age} years old"
end

# Output:
# Alice is 25 years old
# Bob is 30 years old
# Charlie is 35 years old
```

#### `with_index` on Any Iterator

You can add index tracking to most iterators:

```ruby
words = ["hello", "world", "ruby"]

# Map with index
indexed_words = words.map.with_index do |word, index|
  "#{index}: #{word.upcase}"
end

puts indexed_words
# Output: ["0: HELLO", "1: WORLD", "2: RUBY"]

# Select with index - get even-positioned items
even_positioned = words.select.with_index { |word, index| index.even? }
puts even_positioned
# Output: ["hello", "ruby"]
```

#### Multiple Assignment in Blocks

You can use multiple assignment when dealing with arrays:

```ruby
# Array of pairs
coordinates = [[1, 2], [3, 4], [5, 6]]

coordinates.each do |x, y|
  puts "Point at (#{x}, #{y})"
end

# Output:
# Point at (1, 2)
# Point at (3, 4)
# Point at (5, 6)

# With more values than parameters
data = [[1, 2, 3, 4], [5, 6, 7, 8]]

data.each do |first, second|  # Extra values are ignored
  puts "First: #{first}, Second: #{second}"
end

# Output:
# First: 1, Second: 2
# First: 5, Second: 6
```

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

### More Amazing Iterator Methods! 🚀

#### `any?` and `all?` - The Questioners 🤔

Check if any or all elements meet a condition:

```ruby
numbers = [2, 4, 6, 8, 10]

# Check if any number is even
has_even = numbers.any? { |num| num.even? }
puts "Has even numbers: #{has_even}"  # true

# Check if all numbers are even
all_even = numbers.all? { |num| num.even? }
puts "All even: #{all_even}"  # true

# Check with mixed numbers
mixed = [1, 2, 3, 4, 5]
puts "Mixed has even: #{mixed.any?(&:even?)}"  # true
puts "Mixed all even: #{mixed.all?(&:even?)}"  # false
```

#### `partition` - The Separator 🔄

Split an array into two based on a condition:

```ruby
numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

# Separate evens and odds
evens, odds = numbers.partition { |num| num.even? }

puts "Evens: #{evens}"  # [2, 4, 6, 8, 10]
puts "Odds: #{odds}"    # [1, 3, 5, 7, 9]

# Separate by length
words = ["cat", "elephant", "dog", "butterfly", "ant"]
long_words, short_words = words.partition { |word| word.length > 4 }

puts "Long words: #{long_words}"    # ["elephant", "butterfly"]
puts "Short words: #{short_words}"  # ["cat", "dog", "ant"]
```

#### `group_by` - The Organizer 📂

Group elements by a common characteristic:

```ruby
# Group words by their length
words = ["cat", "dog", "elephant", "ant", "butterfly", "ox"]
grouped = words.group_by { |word| word.length }

puts grouped
# Output: {3=>["cat", "dog", "ant"], 8=>["elephant"], 9=>["butterfly"], 2=>["ox"]}

# Group numbers by even/odd
numbers = [1, 2, 3, 4, 5, 6]
by_parity = numbers.group_by { |num| num.even? ? "even" : "odd" }

puts by_parity
# Output: {"odd"=>[1, 3, 5], "even"=>[2, 4, 6]}
```

#### `sort_by` - The Smart Sorter 📊

Sort elements by a custom criteria:

```ruby
# Sort words by length
words = ["elephant", "cat", "butterfly", "dog"]
by_length = words.sort_by { |word| word.length }

puts by_length  # ["cat", "dog", "elephant", "butterfly"]

# Sort people by age
people = [
  { name: "Alice", age: 30 },
  { name: "Bob", age: 25 },
  { name: "Charlie", age: 35 }
]

by_age = people.sort_by { |person| person[:age] }
puts by_age.map { |p| "#{p[:name]} (#{p[:age]})" }
# Output: ["Bob (25)", "Alice (30)", "Charlie (35)"]
```

#### `max_by` and `min_by` - The Extremes Finders 🎯

Find the maximum or minimum element based on a criteria:

```ruby
words = ["elephant", "cat", "butterfly", "dog"]

# Find longest word
longest = words.max_by { |word| word.length }
puts "Longest word: #{longest}"  # "butterfly"

# Find shortest word
shortest = words.min_by { |word| word.length }
puts "Shortest word: #{shortest}"  # "cat"

# With numbers and custom logic
numbers = [15, 7, 23, 4, 18]

# Find number closest to 10
closest_to_10 = numbers.min_by { |num| (num - 10).abs }
puts "Closest to 10: #{closest_to_10}"  # 7
```

#### `take_while` and `drop_while` - The Conditional Takers 📦

Take or drop elements while a condition is true:

```ruby
numbers = [1, 3, 5, 2, 7, 9, 4]

# Take odd numbers from the beginning
odds_from_start = numbers.take_while { |num| num.odd? }
puts "Odds from start: #{odds_from_start}"  # [1, 3, 5]

# Drop odd numbers from the beginning, keep the rest
after_odds = numbers.drop_while { |num| num.odd? }
puts "After dropping odds: #{after_odds}"  # [2, 7, 9, 4]
```

#### `zip` - The Combiner 🤝

Combine two arrays element by element:

```ruby
names = ["Alice", "Bob", "Charlie"]
ages = [25, 30, 35]
cities = ["New York", "London", "Tokyo"]

# Combine names and ages
name_age_pairs = names.zip(ages)
puts name_age_pairs
# Output: [["Alice", 25], ["Bob", 30], ["Charlie", 35]]

# Combine all three
combined = names.zip(ages, cities)
puts combined
# Output: [["Alice", 25, "New York"], ["Bob", 30, "London"], ["Charlie", 35, "Tokyo"]]

# Use with a block to format
formatted = names.zip(ages) do |name, age|
  puts "#{name} is #{age} years old"
end
```

#### `cycle` - The Repeater 🔄

Repeat an array's elements indefinitely (use with caution!):

```ruby
colors = ["red", "green", "blue"]

# Print colors cycling 6 times
counter = 0
colors.cycle do |color|
  puts "Color #{counter + 1}: #{color}"
  counter += 1
  break if counter >= 6
end

# Output:
# Color 1: red
# Color 2: green
# Color 3: blue
# Color 4: red
# Color 5: green
# Color 6: blue

# Or specify how many cycles
colors.cycle(2) { |color| puts color }
# Prints each color twice
```

## Procs and Lambdas - Blocks with Superpowers! 🦸‍♂️

Sometimes you want to save a block of code and reuse it later. That's where Procs and Lambdas come in! They're like blocks that you can store in variables.

### Procs - Stored Blocks 📦

A Proc (procedure) is a block wrapped in an object that you can save and reuse:

```ruby
# Create a Proc
square_proc = Proc.new { |num| num * num }

# Use it with different arrays
numbers1 = [1, 2, 3]
numbers2 = [4, 5, 6]

squared1 = numbers1.map(&square_proc)
squared2 = numbers2.map(&square_proc)

puts squared1  # [1, 4, 9]
puts squared2  # [16, 25, 36]

# You can also call it directly
result = square_proc.call(7)
puts result  # 49
```

### Lambda - Procs with Rules 📏

Lambdas are like Procs but with stricter rules about arguments:

```ruby
# Create a lambda
multiply_lambda = lambda { |a, b| a * b }
# Or the shorter way:
multiply_lambda = ->(a, b) { a * b }

# Use it
result = multiply_lambda.call(5, 3)
puts result  # 15

# Lambdas are strict about argument count
# multiply_lambda.call(5)     # Error! Wrong number of arguments
# multiply_lambda.call(5,3,2) # Error! Too many arguments
```

### Proc vs Lambda Differences 🤷‍♂️

#### Argument Handling
```ruby
# Proc is flexible with arguments
flexible_proc = Proc.new { |a, b| puts "a: #{a}, b: #{b}" }
flexible_proc.call(1)      # a: 1, b: 
flexible_proc.call(1, 2, 3) # a: 1, b: 2 (ignores extra)

# Lambda is strict
strict_lambda = ->(a, b) { puts "a: #{a}, b: #{b}" }
# strict_lambda.call(1)     # Error! Wrong number of arguments
strict_lambda.call(1, 2)    # a: 1, b: 2
```

#### Return Behavior
```ruby
def test_proc_return
  my_proc = Proc.new { return "from proc" }
  my_proc.call
  "after proc"  # This won't be reached
end

def test_lambda_return
  my_lambda = -> { return "from lambda" }
  my_lambda.call
  "after lambda"  # This WILL be reached
end

puts test_proc_return   # "from proc"
puts test_lambda_return # "after lambda"
```

### When to Use What? 🤔

- **Blocks**: For simple, one-time use with methods
- **Procs**: When you need flexibility and want to reuse code
- **Lambdas**: When you want strict argument checking and predictable returns

### Practical Examples 🛠️

#### Reusable Validators

```ruby
# Create validation lambdas
email_validator = ->(email) { email.include?('@') && email.include?('.') }
password_validator = ->(pwd) { pwd.length >= 8 && pwd.match?(/[A-Z]/) && pwd.match?(/[0-9]/) }

# Test data
users = [
  { email: "alice@example.com", password: "SecurePass123" },
  { email: "bob", password: "weak" },
  { email: "charlie@test.org", password: "StrongPass456" }
]

users.each do |user|
  email_valid = email_validator.call(user[:email])
  password_valid = password_validator.call(user[:password])
  
  puts "User: #{user[:email]}"
  puts "  Email valid: #{email_valid}"
  puts "  Password valid: #{password_valid}"
  puts "  Overall valid: #{email_valid && password_valid}"
  puts
end
```

#### Custom Iterators with Procs

```ruby
def repeat_with_proc(times, &block)
  times.times { |i| block.call(i + 1) }
end

# Create a reusable greeting proc
greeting_proc = Proc.new { |num| puts "Hello ##{num}!" }

# Use it
repeat_with_proc(3, &greeting_proc)
# Output:
# Hello #1!
# Hello #2!
# Hello #3!
```

## Block Return Values and Mutation 🔄

Understanding what blocks return and how they can change data is crucial for effective Ruby programming!

### Block Return Values 📤

Blocks return the value of their last expression:

```ruby
# Map returns a new array with block return values
numbers = [1, 2, 3, 4, 5]

# Block returns the squared value
squares = numbers.map { |num| num * num }
puts squares  # [1, 4, 9, 16, 25]

# Block returns a string
descriptions = numbers.map { |num| "The number #{num}" }
puts descriptions  # ["The number 1", "The number 2", ...]

# Multiple expressions - returns the last one
results = numbers.map do |num|
  doubled = num * 2
  tripled = num * 3
  tripled  # This is what gets returned
end
puts results  # [3, 6, 9, 12, 15]
```

### Mutation vs. Non-Mutation 🧬

Some methods create new objects, others modify existing ones:

#### Non-Mutating Methods (Create New Objects)
```ruby
original = [1, 2, 3, 4, 5]

# These create NEW arrays
evens = original.select { |num| num.even? }
doubled = original.map { |num| num * 2 }
sorted = original.sort { |a, b| b <=> a }

puts "Original: #{original}"  # Still [1, 2, 3, 4, 5]
puts "Evens: #{evens}"       # [2, 4]
puts "Doubled: #{doubled}"   # [2, 4, 6, 8, 10]
puts "Sorted: #{sorted}"     # [5, 4, 3, 2, 1]
```

#### Mutating Methods (Change Original Objects)
```ruby
numbers = [1, 2, 3, 4, 5]

# These modify the ORIGINAL array
numbers.select! { |num| num.even? }  # Note the '!' 
puts numbers  # [2, 4] - original array was changed!

# More mutating methods
letters = ['b', 'a', 'd', 'c']
letters.sort! { |a, b| a <=> b }
puts letters  # ['a', 'b', 'c', 'd'] - original was sorted

# reject! removes elements that match the condition
words = ["hello", "hi", "goodbye", "bye"]
words.reject! { |word| word.length < 4 }
puts words  # ["hello", "goodbye"] - short words removed
```

### Understanding the Bang Methods (!) ⚠️

Methods ending with `!` usually mutate the original object:

```ruby
fruits = ["banana", "apple", "cherry"]

# Non-mutating version
sorted_fruits = fruits.sort
puts "Original: #{fruits}"        # ["banana", "apple", "cherry"]
puts "Sorted copy: #{sorted_fruits}"  # ["apple", "banana", "cherry"]

# Mutating version
fruits.sort!
puts "After sort!: #{fruits}"     # ["apple", "banana", "cherry"]

# Common bang methods with blocks
numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

numbers.select! { |num| num.even? }      # Keep only evens
puts numbers  # [2, 4, 6, 8, 10]

numbers.map! { |num| num * 10 }          # Multiply each by 10
puts numbers  # [20, 40, 60, 80, 100]

numbers.reject! { |num| num > 50 }       # Remove numbers > 50
puts numbers  # [20, 40]
```

### Careful with Object References! 🔗

When objects are stored in arrays, blocks can modify the objects themselves:

```ruby
# Array of hashes
people = [
  { name: "Alice", age: 25 },
  { name: "Bob", age: 30 },
  { name: "Charlie", age: 35 }
]

# This modifies the original hash objects!
people.each { |person| person[:age] += 1 }

puts people
# Output: [{:name=>"Alice", :age=>26}, {:name=>"Bob", :age=>31}, {:name=>"Charlie", :age=>36}]

# The original objects were changed!

# To avoid mutation, create new objects
people_next_year = people.map do |person|
  { name: person[:name], age: person[:age] + 1 }
end

# Now we have two separate arrays with different age values
```

### Block Return Values in Different Contexts 🎯

```ruby
numbers = [1, 2, 3, 4, 5]

# each returns the original array (ignores block return value)
result1 = numbers.each { |num| num * 100 }
puts result1  # [1, 2, 3, 4, 5] - original array

# map uses block return values to create new array
result2 = numbers.map { |num| num * 100 }
puts result2  # [100, 200, 300, 400, 500]

# select uses block return value as true/false test
result3 = numbers.select { |num| num * 100 }  # Any non-false value is truthy
puts result3  # [1, 2, 3, 4, 5] - all numbers are truthy

# find returns the first element where block returns truthy
result4 = numbers.find { |num| num > 3 }
puts result4  # 4

# reduce uses block return value as accumulator
result5 = numbers.reduce { |sum, num| sum + num }
puts result5  # 15
```

### Performance Considerations 🚀

Understanding mutation can help with performance:

```ruby
# Less efficient - creates new arrays each time
large_array = (1..100000).to_a
result = large_array.select { |n| n.even? }.map { |n| n * 2 }.sort

# More efficient - fewer intermediate arrays
result = large_array.each_with_object([]) do |n, acc|
  acc << n * 2 if n.even?
end.sort!

# Most efficient for this case - single pass with reduce
result = large_array.reduce([]) do |acc, n|
  acc << n * 2 if n.even?
  acc
end.sort!
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

### Challenge 4: Advanced Data Processing
```ruby
# Employee data
employees = [
  { name: "Alice", department: "Engineering", salary: 75000, years: 3 },
  { name: "Bob", department: "Marketing", salary: 60000, years: 5 },
  { name: "Charlie", department: "Engineering", salary: 80000, years: 2 },
  { name: "Diana", department: "Sales", salary: 65000, years: 4 },
  { name: "Eve", department: "Engineering", salary: 90000, years: 6 }
]

puts "👥 Employee Analysis"
puts "==================="

# Group by department
by_department = employees.group_by { |emp| emp[:department] }
by_department.each do |dept, emps|
  puts "#{dept}: #{emps.length} employees"
end

# Average salary by department
puts "\nAverage Salaries:"
by_department.each do |dept, emps|
  avg_salary = emps.map { |emp| emp[:salary] }.reduce(:+) / emps.length
  puts "#{dept}: $#{avg_salary}"
end

# Senior employees (5+ years)
senior_employees = employees.select { |emp| emp[:years] >= 5 }
puts "\nSenior Employees: #{senior_employees.map { |emp| emp[:name] }.join(', ')}"

# Highest paid employee
highest_paid = employees.max_by { |emp| emp[:salary] }
puts "Highest paid: #{highest_paid[:name]} ($#{highest_paid[:salary]})"
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

# Method chaining with shortcuts
result = (1..10)
  .select(&:even?)              # [2, 4, 6, 8, 10]
  .map { |n| n * n }            # [4, 16, 36, 64, 100]
  .reduce(:+)                   # 220

puts result  # 220
```

## Advanced Block Patterns 🎨

### Method Chaining
```ruby
# Processing pipeline
words = ["Hello", "WORLD", "ruby", "Programming"]

result = words
  .map(&:downcase)                    # ["hello", "world", "ruby", "programming"]
  .select { |word| word.length > 4 }  # ["hello", "world", "programming"]
  .map(&:capitalize)                  # ["Hello", "World", "Programming"]
  .sort                               # ["Hello", "Programming", "World"]

puts result
```

### Nested Blocks and Complex Data
```ruby
# Complex data structure
sales_data = [
  { month: "January", sales: [1000, 1500, 2000, 1800] },
  { month: "February", sales: [1200, 1600, 2200, 1900] },
  { month: "March", sales: [1100, 1400, 2100, 2000] }
]

# Calculate monthly totals and find best month
monthly_totals = sales_data.map do |month_data|
  total = month_data[:sales].reduce(:+)
  { month: month_data[:month], total: total }
end

best_month = monthly_totals.max_by { |data| data[:total] }
puts "Best month: #{best_month[:month]} with $#{best_month[:total]}"

# Weekly averages
weekly_averages = sales_data.map do |month_data|
  avg = month_data[:sales].reduce(:+) / month_data[:sales].length.to_f
  { month: month_data[:month], weekly_avg: avg.round(2) }
end

puts "Weekly Averages:"
weekly_averages.each { |data| puts "#{data[:month]}: $#{data[:weekly_avg]}" }
```

## What's Next? 🚀

Fantastic! You've learned about blocks and iterators - some of Ruby's most powerful features! These tools will make your code more elegant and fun to write. You now understand:

- Basic block syntax and parameters
- Variable scope in blocks
- Multiple block parameters
- A wide variety of iterator methods
- Procs and lambdas for reusable code blocks
- Block return values and mutation
- Advanced patterns and real-world applications

Next up, we'll dive into **Classes and Objects** - where you'll learn to create your own custom data types and build amazing things! 🏗️

## Quick Reference 📋

### Block Syntax
```ruby
# Curly braces (single line)
array.each { |item| puts item }

# do-end (multiple lines)
array.each do |item|
  puts item
end

# Multiple parameters
hash.each { |key, value| puts "#{key}: #{value}" }
array.each_with_index { |item, index| puts "#{index}: #{item}" }
```

### Essential Iterator Methods
```ruby
# Visiting and transforming
array.each { |item| ... }           # Visit each item
array.map { |item| ... }            # Transform each item
array.each_with_index { |item, i| ... }  # Visit with index

# Filtering and finding
array.select { |item| ... }         # Pick matching items
array.reject { |item| ... }         # Remove matching items
array.find { |item| ... }           # Find first match
array.any? { |item| ... }           # Check if any match
array.all? { |item| ... }           # Check if all match
array.count { |item| ... }          # Count matching items

# Organizing and sorting
array.group_by { |item| ... }       # Group by criteria
array.partition { |item| ... }      # Split into two arrays
array.sort_by { |item| ... }        # Sort by criteria
array.max_by { |item| ... }         # Find max by criteria
array.min_by { |item| ... }         # Find min by criteria

# Combining and reducing
array.reduce { |acc, item| ... }    # Combine all items
array.zip(other_array)              # Combine arrays element-wise
```

### Advanced Methods
```ruby
array.take_while { |item| ... }     # Take items while condition true
array.drop_while { |item| ... }     # Drop items while condition true
array.cycle(n) { |item| ... }       # Repeat array n times
```

### Procs and Lambdas
```ruby
# Proc creation
my_proc = Proc.new { |x| x * 2 }
my_proc = proc { |x| x * 2 }

# Lambda creation
my_lambda = lambda { |x| x * 2 }
my_lambda = ->(x) { x * 2 }

# Usage
result = my_proc.call(5)        # 10
array.map(&my_proc)             # Use as block
```

### Mutation vs Non-Mutation
```ruby
# Non-mutating (creates new objects)
new_array = array.map { |item| ... }
new_array = array.select { |item| ... }

# Mutating (changes original)
array.map! { |item| ... }       # Changes original array
array.select! { |item| ... }    # Changes original array
array.reject! { |item| ... }    # Changes original array
```

### Block Shortcuts
```ruby
# Symbol to proc
array.map(&:upcase)             # Same as { |item| item.upcase }
array.select(&:even?)           # Same as { |item| item.even? }
array.reduce(:+)                # Same as { |a, b| a + b }
```

### Block Variables and Scope
```ruby
outside_var = "accessible"

array.each do |item|            # 'item' only exists in block
  puts outside_var              # Can access outside variables
  block_var = "local"           # Only exists in block
end
# puts item        # Error!
# puts block_var   # Error!
```

Remember: Blocks are like giving someone a recipe to follow for each item in your collection! They're one of Ruby's most powerful and expressive features. 📝✨

[← Previous: Loops](./11-loops.md) | [Next: Classes and Objects →](./13-classes-objects.md)
