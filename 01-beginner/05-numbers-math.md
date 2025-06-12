# Chapter 5: Numbers and Math 🔢

## 🧮 Ruby as Your Super Calculator

Ruby is like having the most amazing calculator ever! It can do all kinds of math, from simple addition to complex calculations. And the best part? It never gets tired of doing math for you!

## 🎯 Types of Numbers in Ruby

Ruby understands two main types of numbers:

### 1. Integers (Whole Numbers) 🎲
```ruby
age = 10
score = 100
temperature = -5
big_number = 1000000

puts age.class  # Integer
```

### 2. Floats (Decimal Numbers) 🎈
```ruby
height = 5.5
price = 19.99
pi = 3.14159
temperature = 98.6

puts height.class  # Float
```

## ➕ Basic Math Operations

Ruby knows all the math operations you learned in school:

```ruby
# Addition
puts 5 + 3        # 8
puts 10 + 20      # 30

# Subtraction
puts 10 - 4       # 6
puts 100 - 25     # 75

# Multiplication
puts 6 * 7        # 42
puts 12 * 5       # 60

# Division
puts 20 / 4       # 5
puts 15 / 3       # 5

# Exponents (powers)
puts 2 ** 3       # 8 (2 to the power of 3)
puts 5 ** 2       # 25 (5 squared)

# Modulo (remainder after division)
puts 17 % 5       # 2 (17 divided by 5, remainder 2)
puts 20 % 3       # 2
```

## 🎭 Math with Variables

You can do math using variables too:

```ruby
apples = 15
oranges = 8

total_fruit = apples + oranges
puts "Total fruit: #{total_fruit}"  # 23

remaining_apples = apples - 5
puts "Apples left: #{remaining_apples}"  # 10

doubled_oranges = oranges * 2
puts "Double oranges: #{doubled_oranges}"  # 16
```

## 🎪 Fun Math Tricks

### Shortcut Operators
Ruby has shortcuts for common math operations:

```ruby
score = 10

# These all do the same thing:
score = score + 5
score += 5        # Shortcut!

# More shortcuts:
score -= 3        # Same as: score = score - 3
score *= 2        # Same as: score = score * 2
score /= 4        # Same as: score = score / 4

puts score
```

### Increment and Decrement
```ruby
lives = 3

# Add 1
lives += 1
puts lives  # 4

# Subtract 1
lives -= 1
puts lives  # 3
```

## 🔍 Integer vs Float Division

This is super important to understand:

```ruby
# Integer division (whole number result)
puts 10 / 3      # 3 (not 3.33...)
puts 7 / 2       # 3 (not 3.5)

# Float division (decimal result)
puts 10.0 / 3    # 3.3333333333333335
puts 7.0 / 2     # 3.5
puts 10 / 3.0    # 3.3333333333333335

# Converting to float
puts 10.to_f / 3  # 3.3333333333333335
```

**Rule:** If both numbers are integers, you get an integer result. If one is a float, you get a float result!

## 🎲 Random Numbers

Ruby can generate random numbers - perfect for games!

```ruby
# Random number from 1 to 6 (like a dice)
dice = rand(1..6)
puts "You rolled: #{dice}"

# Random number from 1 to 10
random_num = rand(1..10)
puts "Random number: #{random_num}"

# Random number from 0 to 1 (decimal)
random_decimal = rand
puts "Random decimal: #{random_decimal}"

# Random number up to a limit
big_random = rand(100)  # 0 to 99
puts "Big random: #{big_random}"
```

## 🧙‍♂️ Built-in Math Methods

Ruby has lots of helpful math methods:

```ruby
number = -15.7

puts number.abs        # 15.7 (absolute value)
puts number.round      # -16 (round to nearest integer)
puts number.floor      # -16 (round down)
puts number.ceil       # -15 (round up)

# More examples
puts 3.7.round         # 4
puts 3.2.round         # 3
puts 3.7.floor         # 3
puts 3.2.ceil          # 4

# Square root (need to require math first)
puts Math.sqrt(16)     # 4.0
puts Math.sqrt(25)     # 5.0
```

## 🎯 Practical Math Examples

### Example 1: Simple Calculator
```ruby
puts "🧮 Ruby Calculator"
puts "Enter first number:"
num1 = gets.chomp.to_f

puts "Enter second number:"
num2 = gets.chomp.to_f

puts "\nResults:"
puts "#{num1} + #{num2} = #{num1 + num2}"
puts "#{num1} - #{num2} = #{num1 - num2}"
puts "#{num1} × #{num2} = #{num1 * num2}"
puts "#{num1} ÷ #{num2} = #{num1 / num2}" if num2 != 0
```

### Example 2: Tip Calculator
```ruby
puts "💰 Tip Calculator"
puts "Enter bill amount:"
bill = gets.chomp.to_f

puts "Enter tip percentage (like 15 for 15%):"
tip_percent = gets.chomp.to_f

tip_amount = bill * (tip_percent / 100)
total = bill + tip_amount

puts "\nBill: $#{bill}"
puts "Tip (#{tip_percent}%): $#{tip_amount.round(2)}"
puts "Total: $#{total.round(2)}"
```

### Example 3: Dice Game
```ruby
puts "🎲 Dice Rolling Game!"
puts "Press Enter to roll two dice..."
gets

dice1 = rand(1..6)
dice2 = rand(1..6)
total = dice1 + dice2

puts "First die: #{dice1}"
puts "Second die: #{dice2}"
puts "Total: #{total}"

if total == 7
  puts "Lucky seven! 🍀"
elsif total == 12
  puts "Boxcars! 🎯"
else
  puts "Good roll! 🎲"
end
```

## 🎨 Number Formatting

Make your numbers look pretty:

```ruby
price = 19.999

# Round to 2 decimal places
puts price.round(2)    # 20.0

# Format as currency (you'll need to add the $ yourself)
puts "$#{price.round(2)}"  # $20.0

# Big numbers with commas (need to convert to string)
big_number = 1234567
puts big_number.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse
# This is advanced - don't worry about understanding it yet!
```

## 🎮 Math Games and Challenges

### Challenge 1: Number Guessing Game
```ruby
secret_number = rand(1..10)
puts "Guess my number (1-10):"
guess = gets.chomp.to_i

if guess == secret_number
  puts "Correct! 🎉"
else
  puts "Wrong! It was #{secret_number} 😅"
end
```

### Challenge 2: Simple Interest Calculator
```ruby
puts "💸 Simple Interest Calculator"
puts "Enter principal amount:"
principal = gets.chomp.to_f

puts "Enter interest rate (%):"
rate = gets.chomp.to_f

puts "Enter time (years):"
time = gets.chomp.to_f

interest = principal * (rate / 100) * time
total = principal + interest

puts "Interest earned: $#{interest.round(2)}"
puts "Total amount: $#{total.round(2)}"
```

## ⚠️ Common Math Mistakes

### 1. Division by Zero
```ruby
# This will cause an error:
puts 10 / 0  # ZeroDivisionError!

# Always check first:
divisor = 0
if divisor != 0
  puts 10 / divisor
else
  puts "Cannot divide by zero!"
end
```

### 2. Integer Division Surprise
```ruby
# Might not be what you expect:
puts 5 / 2      # 2 (not 2.5!)

# Better:
puts 5.0 / 2    # 2.5
puts 5 / 2.0    # 2.5
puts 5.to_f / 2 # 2.5
```

### 3. Floating Point Precision
```ruby
# Computers aren't perfect with decimals:
puts 0.1 + 0.2  # 0.30000000000000004 (not exactly 0.3!)

# For money calculations, use integers (cents):
price_cents = 199  # $1.99
puts "Price: $#{price_cents / 100.0}"
```

## 🎉 Math Mastery!

You now know how to:
- ✅ Use all basic math operations (+, -, *, /, **)
- ✅ Work with integers and floats
- ✅ Use shortcut operators (+=, -=, etc.)
- ✅ Generate random numbers
- ✅ Use built-in math methods
- ✅ Handle division carefully
- ✅ Create practical math programs

Ruby makes math fun and easy! You can build calculators, games, and solve real-world problems.

---

## 🚀 What's Next?

Now that you're a math wizard, let's learn about strings - how to work with text and words in Ruby!

**[← Previous: Variables - Your Data Containers](./04-variables.md)** | **[Next: Strings - Playing with Text →](./06-strings.md)**

---

### 🎯 Math Challenges

Try building these before moving on:
1. **Temperature Converter**: Celsius ↔ Fahrenheit
2. **BMI Calculator**: Calculate Body Mass Index
3. **Compound Interest**: Calculate growing investments
4. **Pizza Party**: Calculate slices per person

Math is everywhere in programming - master it and you'll be unstoppable! 💪
