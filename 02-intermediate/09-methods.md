# Chapter 9: Methods - Your Own Commands 🧙‍♂️

## 🤔 What Are Methods?

Methods are like creating your own magic spells! Instead of writing the same code over and over, you can package it into a method and use it whenever you need it. Think of methods as custom commands that you teach Ruby to understand.

```ruby
# Instead of writing this every time:
puts "Hello there!"
puts "How are you today?"
puts "Welcome to Ruby!"

# You can create a method:
def greet
  puts "Hello there!"
  puts "How are you today?"
  puts "Welcome to Ruby!"
end

# Now just call it:
greet  # Runs all the code inside the method!
```

## 📝 Creating Your First Method

```ruby
# Basic method
def say_hello
  puts "Hello, Ruby world!"
end

# Method with parameters
def greet_person(name)
  puts "Hello, #{name}! Nice to meet you!"
end

# Method that returns a value
def add_numbers(a, b)
  result = a + b
  return result  # 'return' is optional - Ruby returns the last line
end

# Using the methods
say_hello                    # Hello, Ruby world!
greet_person("Alice")        # Hello, Alice! Nice to meet you!
sum = add_numbers(5, 3)      # sum = 8
puts sum
```

## 🎯 Method Parameters

Methods can accept different types of parameters:

### Required Parameters
```ruby
def introduce(name, age)
  puts "Hi, I'm #{name} and I'm #{age} years old."
end

introduce("Ruby", 28)  # Works!
# introduce("Ruby")    # Error! Missing age parameter
```

### Optional Parameters (Default Values)
```ruby
def greet(name, greeting = "Hello")
  puts "#{greeting}, #{name}!"
end

greet("Alice")           # Hello, Alice!
greet("Bob", "Hi")       # Hi, Bob!
greet("Charlie", "Hey")  # Hey, Charlie!
```

### Variable Number of Parameters (*args)
```ruby
def sum_all(*numbers)
  total = 0
  numbers.each { |num| total += num }
  total
end

puts sum_all(1, 2, 3)        # 6
puts sum_all(10, 20, 30, 40) # 100
puts sum_all(5)              # 5
```

### Keyword Parameters
```ruby
def create_profile(name:, age:, city: "Unknown")
  puts "Name: #{name}"
  puts "Age: #{age}"  
  puts "City: #{city}"
end

create_profile(name: "Alice", age: 25)
create_profile(name: "Bob", age: 30, city: "Tokyo")
```

## 🔄 Return Values

Methods can return values back to whoever called them:

```ruby
def multiply(a, b)
  a * b  # Ruby returns the last line automatically
end

def circle_area(radius)
  pi = 3.14159
  pi * radius * radius
end

def is_even?(number)
  number % 2 == 0  # Returns true or false
end

# Using return values
product = multiply(6, 7)     # 42
area = circle_area(5)        # 78.53975
even = is_even?(10)          # true

puts "Product: #{product}"
puts "Area: #{area}"
puts "Is even: #{even}"
```

## 🎪 Practical Method Examples

### Example 1: Temperature Converter
```ruby
def celsius_to_fahrenheit(celsius)
  (celsius * 9.0 / 5.0) + 32
end

def fahrenheit_to_celsius(fahrenheit)
  (fahrenheit - 32) * 5.0 / 9.0
end

def temperature_converter
  puts "🌡️  Temperature Converter"
  puts "1. Celsius to Fahrenheit"
  puts "2. Fahrenheit to Celsius"
  puts "Enter choice (1 or 2):"
  
  choice = gets.chomp.to_i
  
  case choice
  when 1
    puts "Enter temperature in Celsius:"
    temp = gets.chomp.to_f
    result = celsius_to_fahrenheit(temp)
    puts "#{temp}°C = #{result.round(2)}°F"
  when 2
    puts "Enter temperature in Fahrenheit:"
    temp = gets.chomp.to_f
    result = fahrenheit_to_celsius(temp)
    puts "#{temp}°F = #{result.round(2)}°C"
  else
    puts "Invalid choice!"
  end
end

# temperature_converter  # Uncomment to try it!
```

### Example 2: Text Formatter
```ruby
def format_title(text)
  text.split.map(&:capitalize).join(' ')
end

def format_sentence(text)
  text.strip.capitalize + '.'
end

def word_count(text)
  text.split.length
end

def char_count(text, include_spaces = false)
  if include_spaces
    text.length
  else
    text.gsub(' ', '').length
  end
end

def text_analysis(text)
  puts "📝 Text Analysis"
  puts "=" * 30
  puts "Original: #{text}"
  puts "Title case: #{format_title(text)}"
  puts "Sentence: #{format_sentence(text)}"
  puts "Words: #{word_count(text)}"
  puts "Characters (no spaces): #{char_count(text)}"
  puts "Characters (with spaces): #{char_count(text, true)}"
end

text_analysis("hello world ruby programming")
```

### Example 3: Simple Calculator
```ruby
def add(a, b)
  a + b
end

def subtract(a, b)
  a - b
end

def multiply(a, b)
  a * b
end

def divide(a, b)
  if b != 0
    a / b.to_f
  else
    "Cannot divide by zero!"
  end
end

def power(base, exponent)
  base ** exponent
end

def calculator
  puts "🧮 Simple Calculator"
  puts "Available operations: +, -, *, /, **"
  
  puts "Enter first number:"
  num1 = gets.chomp.to_f
  
  puts "Enter operation (+, -, *, /, **):"
  operation = gets.chomp
  
  puts "Enter second number:"
  num2 = gets.chomp.to_f
  
  result = case operation
           when "+"
             add(num1, num2)
           when "-"
             subtract(num1, num2)
           when "*"
             multiply(num1, num2)
           when "/"
             divide(num1, num2)
           when "**"
             power(num1, num2)
           else
             "Unknown operation!"
           end
  
  puts "Result: #{num1} #{operation} #{num2} = #{result}"
end

# calculator  # Uncomment to try it!
```

## 🎮 Building a Game with Methods

```ruby
def generate_random_number(min = 1, max = 100)
  rand(min..max)
end

def get_user_guess
  puts "Enter your guess:"
  gets.chomp.to_i
end

def check_guess(guess, secret)
  if guess == secret
    "correct"
  elsif guess < secret
    "too_low"
  else
    "too_high"
  end
end

def give_hint(result, guess, secret)
  case result
  when "too_low"
    puts "📈 Too low! Try a higher number."
  when "too_high"
    puts "📉 Too high! Try a lower number."
  when "correct"
    puts "🎉 Congratulations! You guessed it!"
  end
end

def play_guessing_game
  puts "🎮 Number Guessing Game!"
  puts "I'm thinking of a number between 1 and 100."
  
  secret_number = generate_random_number(1, 100)
  attempts = 0
  max_attempts = 7
  
  loop do
    attempts += 1
    puts "\nAttempt #{attempts}/#{max_attempts}"
    
    guess = get_user_guess
    result = check_guess(guess, secret_number)
    
    if result == "correct"
      give_hint(result, guess, secret_number)
      puts "You won in #{attempts} attempts! 🏆"
      break
    elsif attempts >= max_attempts
      puts "😞 Game over! The number was #{secret_number}."
      break
    else
      give_hint(result, guess, secret_number)
    end
  end
end

# play_guessing_game  # Uncomment to play!
```

## 🔧 Method Best Practices

### 1. Keep Methods Small and Focused
```ruby
# Good - does one thing well
def calculate_tax(price, tax_rate)
  price * tax_rate
end

# Less good - does too many things
def process_order(items, customer_info, payment_info)
  # Calculate total
  # Apply discounts
  # Process payment
  # Send confirmation
  # Update inventory
  # Too much!
end
```

### 2. Use Descriptive Names
```ruby
# Good names
def calculate_total_price(items)
  # ...
end

def is_valid_email?(email)
  # ...
end

def send_welcome_email(user)
  # ...
end

# Bad names
def calc(x)
  # ...
end

def check(thing)
  # ...
end

def do_stuff(data)
  # ...
end
```

### 3. Return Consistently
```ruby
# Good - always returns the same type
def find_user(id)
  user = database.find(id)
  user || nil  # Always returns User object or nil
end

# Less good - inconsistent return types
def find_user(id)
  user = database.find(id)
  if user
    user
  else
    "User not found"  # String instead of User object
  end
end
```

## 🎯 Method Scope and Local Variables

Variables inside methods stay inside methods:

```ruby
def example_method
  local_var = "I only exist inside this method"
  puts local_var
end

example_method  # Works fine

# puts local_var  # Error! local_var doesn't exist here

# Global variables (avoid these!)
$global_var = "I exist everywhere"

def another_method
  puts $global_var  # Works, but not recommended
end
```

## 🎪 Methods with Blocks

Methods can accept blocks of code:

```ruby
def repeat_action(times)
  times.times do
    yield  # Runs the block passed to this method
  end
end

def greet_multiple(names)
  names.each do |name|
    yield(name)  # Passes each name to the block
  end
end

# Using methods with blocks
repeat_action(3) do
  puts "Hello!"
end

greet_multiple(["Alice", "Bob", "Charlie"]) do |name|
  puts "Welcome, #{name}!"
end
```

## 🎨 Chaining Methods

You can chain methods together:

```ruby
def format_name(name)
  name.strip.downcase.split.map(&:capitalize).join(' ')
end

def add_greeting(name)
  "Hello, #{name}!"
end

def add_excitement(text)
  text + " 🎉"
end

# Chain them together
result = add_excitement(add_greeting(format_name("  alice SMITH  ")))
puts result  # Hello, Alice Smith! 🎉

# Or create a method that chains them
def process_name(name)
  formatted = format_name(name)
  greeted = add_greeting(formatted)
  add_excitement(greeted)
end

puts process_name("  bob JONES  ")  # Hello, Bob Jones! 🎉
```

## 🎉 Methods Mastery!

You now know how to:
- ✅ Create methods to organize and reuse code
- ✅ Use different types of parameters (required, optional, variable)
- ✅ Return values from methods
- ✅ Build complex programs by combining simple methods
- ✅ Follow best practices for method design
- ✅ Understand method scope and local variables
- ✅ Use methods with blocks and chaining

Methods are the building blocks of clean, organized code!

---

## 🚀 What's Next?

Now let's learn about conditionals - how to make your programs make decisions!

**[← Previous: Hashes - Smart Dictionaries](../01-beginner/08-hashes.md)** | **[Next: Conditionals - Making Decisions →](./10-conditionals.md)**

---

### 🎯 Method Challenges

Try building these method-based projects:
1. **Password Generator**: Methods for different password types and strengths
2. **Unit Converter**: Methods for different measurement conversions
3. **Text Processor**: Methods for various text transformations
4. **Math Library**: Methods for common mathematical operations

Methods help you organize code and avoid repetition! 🧙‍♂️✨
