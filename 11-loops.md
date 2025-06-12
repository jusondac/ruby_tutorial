# Chapter 11: Loops - Doing Things Again 🔄

[← Previous: Conditionals](./10-conditionals.md) | [Next: Blocks and Iterators →](./12-blocks-iterators.md)

## What Are Loops? 🎪

Imagine you're a DJ at a party and you want to play the same awesome song 10 times in a row! Instead of pressing play 10 times manually, you could use a loop to do it automatically. That's exactly what loops do in Ruby - they repeat code for you!

Loops are like a merry-go-round for code - they keep going around and around until you tell them to stop! 🎠

## Types of Loops in Ruby

### 1. The `times` Loop - The Counter 🔢

The `times` loop is perfect when you know exactly how many times you want to repeat something:

```ruby
# Say hello 5 times
5.times do
  puts "Hello there!"
end

# Output:
# Hello there!
# Hello there!
# Hello there!
# Hello there!
# Hello there!
```

You can also get the current number (starting from 0):

```ruby
5.times do |number|
  puts "This is round number #{number}"
end

# Output:
# This is round number 0
# This is round number 1
# This is round number 2
# This is round number 3
# This is round number 4
```

### 2. The `while` Loop - The Condition Checker 🔍

The `while` loop keeps going as long as something is true. It's like saying "while the music is playing, keep dancing!"

```ruby
# Count from 1 to 5
counter = 1

while counter <= 5
  puts "Count: #{counter}"
  counter = counter + 1  # Don't forget to change the counter!
end

# Output:
# Count: 1
# Count: 2
# Count: 3
# Count: 4
# Count: 5
```

**⚠️ Warning:** Be careful with while loops! If you forget to change the condition, your loop will run forever (like a hamster wheel)!

### 3. The `until` Loop - The Opposite Friend 🔄

The `until` loop is the opposite of `while`. It keeps going until something becomes true:

```ruby
# Count down until we reach 0
countdown = 5

until countdown == 0
  puts "#{countdown} seconds left!"
  countdown = countdown - 1
end

puts "Blast off! 🚀"

# Output:
# 5 seconds left!
# 4 seconds left!
# 3 seconds left!
# 2 seconds left!
# 1 seconds left!
# Blast off! 🚀
```

### 4. The `for` Loop - The Range Walker 🚶‍♂️

The `for` loop walks through a range or collection:

```ruby
# Count from 1 to 5
for number in 1..5
  puts "Number: #{number}"
end

# You can also loop through arrays
fruits = ["apple", "banana", "cherry"]
for fruit in fruits
  puts "I love #{fruit}s!"
end
```

### 5. The `loop` Loop - The Forever Friend ♾️

The `loop` method creates an infinite loop that you control with `break`:

```ruby
counter = 0

loop do
  puts "Counter: #{counter}"
  counter += 1
  
  if counter >= 3
    break  # Exit the loop
  end
end

puts "Done!"

# Output:
# Counter: 0
# Counter: 1
# Counter: 2
# Done!
```

## Loop Control Commands 🎮

### `break` - The Emergency Exit 🚪

Use `break` to exit a loop immediately:

```ruby
10.times do |i|
  if i == 3
    break  # Stop when we reach 3
  end
  puts "Number: #{i}"
end

# Output:
# Number: 0
# Number: 1
# Number: 2
```

### `next` - The Skip Button ⏭️

Use `next` to skip to the next iteration:

```ruby
5.times do |i|
  if i == 2
    next  # Skip when i is 2
  end
  puts "Number: #{i}"
end

# Output:
# Number: 0
# Number: 1
# Number: 3
# Number: 4
```

## Real-World Examples 🌍

### Password Checker

```ruby
puts "🔐 Welcome to the Secret Club!"
correct_password = "ruby123"
attempts = 0
max_attempts = 3

while attempts < max_attempts
  print "Enter password: "
  password = gets.chomp
  
  if password == correct_password
    puts "🎉 Welcome in!"
    break
  else
    attempts += 1
    remaining = max_attempts - attempts
    puts "❌ Wrong password! #{remaining} attempts left."
  end
end

if attempts == max_attempts
  puts "🚫 Too many failed attempts. Access denied!"
end
```

### Simple Calculator

```ruby
puts "🔢 Simple Calculator"
puts "Enter 'quit' to exit"

loop do
  print "Enter first number (or 'quit'): "
  input = gets.chomp
  
  break if input == "quit"
  
  num1 = input.to_f
  
  print "Enter second number: "
  num2 = gets.chomp.to_f
  
  print "Enter operation (+, -, *, /): "
  operation = gets.chomp
  
  case operation
  when "+"
    result = num1 + num2
  when "-"
    result = num1 - num2
  when "*"
    result = num1 * num2
  when "/"
    result = num1 / num2
  else
    puts "❌ Invalid operation!"
    next
  end
  
  puts "✅ Result: #{result}"
  puts "---"
end

puts "👋 Thanks for using the calculator!"
```

### Number Guessing Game

```ruby
puts "🎯 Guess the Number Game!"
secret_number = rand(1..10)  # Random number between 1 and 10
guess_count = 0
max_guesses = 3

puts "I'm thinking of a number between 1 and 10."
puts "You have #{max_guesses} guesses!"

while guess_count < max_guesses
  print "Your guess: "
  guess = gets.chomp.to_i
  guess_count += 1
  
  if guess == secret_number
    puts "🎉 Congratulations! You got it!"
    break
  elsif guess < secret_number
    puts "📈 Too low!"
  else
    puts "📉 Too high!"
  end
  
  remaining = max_guesses - guess_count
  if remaining > 0
    puts "#{remaining} guesses left."
  end
end

if guess_count == max_guesses && guess != secret_number
  puts "😞 Game over! The number was #{secret_number}."
end
```

## Fun Challenges 🎮

### Challenge 1: The Multiplication Table
Create a program that prints the multiplication table for any number:

```ruby
print "Enter a number: "
number = gets.chomp.to_i

puts "📊 Multiplication table for #{number}:"
1.upto(10) do |i|
  result = number * i
  puts "#{number} × #{i} = #{result}"
end
```

### Challenge 2: The Pattern Maker
Create different patterns with loops:

```ruby
# Triangle pattern
5.times do |i|
  stars = "*" * (i + 1)
  puts stars
end

# Output:
# *
# **
# ***
# ****
# *****
```

### Challenge 3: The Sum Calculator
Calculate the sum of numbers from 1 to any number:

```ruby
print "Enter a number: "
number = gets.chomp.to_i

sum = 0
1.upto(number) do |i|
  sum += i
end

puts "The sum of numbers from 1 to #{number} is: #{sum}"
```

## Loop Best Practices 💡

1. **Always make sure your loop can end** - avoid infinite loops!
2. **Use the right loop for the job**:
   - `times` for counting
   - `while` for conditions
   - `for` for collections
3. **Keep your loops simple** - if they get too complex, break them into smaller parts
4. **Use meaningful variable names** in your loops
5. **Be careful with loop control** - use `break` and `next` wisely

## What's Next? 🚀

Great job! You've learned how to make your code repeat actions automatically. Loops are super powerful tools that you'll use all the time in programming!

Next up, we'll learn about **blocks and iterators** - which are Ruby's special way of working with collections. They're like loops, but even more magical! ✨

## Quick Reference 📋

```ruby
# Times loop
5.times { |i| puts i }

# While loop
while condition
  # code
end

# Until loop
until condition
  # code
end

# For loop
for item in collection
  # code
end

# Infinite loop with break
loop do
  # code
  break if condition
end

# Loop controls
break  # Exit loop
next   # Skip to next iteration
```

Remember: Loops are like having a helpful robot that can do repetitive tasks for you! 🤖

[← Previous: Conditionals](./10-conditionals.md) | [Next: Blocks and Iterators →](./12-blocks-iterators.md)
