# Chapter 17: Error Handling - When Things Go Wrong 🛡️

[← Previous: File Operations](./16-file-operations.md) | [Next: Regular Expressions →](./18-regex.md)

## What is Error Handling? 🤔

Imagine you're driving a car and suddenly it starts raining. Do you crash into the first tree you see? Of course not! You turn on your windshield wipers, slow down, and drive carefully. That's exactly what error handling does in programming - it helps your program deal with unexpected situations gracefully! 🌧️

Errors happen all the time in programming:
- Files that don't exist
- Network connections that fail
- Users typing letters when you expect numbers
- Running out of memory

Good programmers plan for these situations!

## Types of Errors in Ruby 🎭

### Syntax Errors - The Grammar Police 📝

These happen when Ruby can't understand your code:

```ruby
# Missing 'end'
def broken_method
  puts "Hello"
# SyntaxError: unexpected end-of-input

# Misspelled keywords
if true
  puts "This works"
ned  # Should be 'end'
# SyntaxError: unexpected identifier
```

### Runtime Errors - The Unexpected Visitors 💥

These happen while your program is running:

```ruby
# Division by zero
result = 10 / 0
# ZeroDivisionError: divided by 0

# Calling methods on nil
name = nil
name.upcase
# NoMethodError: undefined method `upcase' for nil:NilClass

# File not found
File.read("nonexistent.txt")
# Errno::ENOENT: No such file or directory
```

## The `begin-rescue-end` Block 🚑

This is Ruby's way of saying "Try this, and if something goes wrong, do this instead":

```ruby
begin
  # Try to do something risky
  result = 10 / 0
  puts "This won't print"
rescue
  # Handle the error
  puts "Oops! Something went wrong! 😅"
end

puts "Program continues normally"
```

### Catching Specific Errors

You can catch specific types of errors:

```ruby
begin
  print "Enter a number: "
  number = gets.chomp.to_i
  result = 100 / number
  puts "100 divided by #{number} is #{result}"
rescue ZeroDivisionError
  puts "❌ You can't divide by zero!"
rescue StandardError => e
  puts "❌ Something else went wrong: #{e.message}"
end
```

### Getting Error Information

```ruby
begin
  File.read("missing_file.txt")
rescue => error  # This catches StandardError and subclasses
  puts "Error type: #{error.class}"
  puts "Error message: #{error.message}"
  puts "Where it happened: #{error.backtrace.first}"
end
```

## Multiple Rescue Blocks 🎯

You can handle different errors in different ways:

```ruby
def safe_calculator
  print "Enter first number: "
  num1 = gets.chomp.to_f
  
  print "Enter operation (+, -, *, /): "
  operation = gets.chomp
  
  print "Enter second number: "
  num2 = gets.chomp.to_f
  
  begin
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
      raise "Invalid operation: #{operation}"
    end
    
    puts "Result: #{result} ✅"
    
  rescue ZeroDivisionError
    puts "❌ Error: Cannot divide by zero!"
  rescue ArgumentError => e
    puts "❌ Invalid number format: #{e.message}"
  rescue StandardError => e
    puts "❌ Error: #{e.message}"
  end
end

safe_calculator
```

## The `ensure` Block - Always Happens 🔒

The `ensure` block runs no matter what - even if there's an error:

```ruby
def read_file_safely(filename)
  file = nil
  
  begin
    file = File.open(filename, "r")
    content = file.read
    puts "File read successfully! 📖"
    return content
  rescue Errno::ENOENT
    puts "❌ File not found: #{filename}"
    return nil
  rescue => e
    puts "❌ Error reading file: #{e.message}"
    return nil
  ensure
    # This ALWAYS runs - perfect for cleanup!
    if file
      file.close
      puts "🔒 File closed safely"
    end
  end
end

read_file_safely("example.txt")
```

## The `else` Block - When Everything Goes Well 🎉

The `else` block only runs if NO errors occurred:

```ruby
begin
  print "Enter a positive number: "
  number = gets.chomp.to_f
  
  if number <= 0
    raise "Number must be positive!"
  end
  
  square_root = Math.sqrt(number)
  
rescue => e
  puts "❌ Error: #{e.message}"
else
  # This only runs if no error occurred
  puts "✅ Square root of #{number} is #{square_root}"
ensure
  puts "🏁 Calculation complete"
end
```

## Raising Your Own Errors 🚨

Sometimes you want to create your own errors:

```ruby
def validate_age(age)
  if age < 0
    raise ArgumentError, "Age cannot be negative!"
  elsif age > 150
    raise ArgumentError, "Age seems unrealistic!"
  elsif age < 18
    raise "Too young for this application"
  end
  
  puts "Age #{age} is valid! ✅"
end

begin
  validate_age(-5)
rescue ArgumentError => e
  puts "❌ Invalid age: #{e.message}"
rescue => e
  puts "❌ Error: #{e.message}"
end
```

## Custom Error Classes 🎨

You can create your own error types:

```ruby
# Define custom errors
class InsufficientFundsError < StandardError
  def initialize(balance, amount)
    @balance = balance
    @amount = amount
    super("Insufficient funds: tried to withdraw $#{amount}, but balance is only $#{balance}")
  end
end

class InvalidAccountError < StandardError; end

class BankAccount
  attr_reader :balance
  
  def initialize(initial_balance = 0)
    raise ArgumentError, "Initial balance cannot be negative" if initial_balance < 0
    @balance = initial_balance
  end
  
  def withdraw(amount)
    raise ArgumentError, "Withdrawal amount must be positive" if amount <= 0
    raise InsufficientFundsError.new(@balance, amount) if amount > @balance
    
    @balance -= amount
    puts "💸 Withdrew $#{amount}. New balance: $#{@balance}"
  end
  
  def deposit(amount)
    raise ArgumentError, "Deposit amount must be positive" if amount <= 0
    
    @balance += amount
    puts "💰 Deposited $#{amount}. New balance: $#{@balance}"
  end
end

# Using the bank account
begin
  account = BankAccount.new(100)
  account.deposit(50)
  account.withdraw(200)  # This will raise InsufficientFundsError
rescue InsufficientFundsError => e
  puts "❌ #{e.message}"
rescue ArgumentError => e
  puts "❌ Invalid operation: #{e.message}"
end
```

## Real-World Examples 🌍

### Safe File Processor

```ruby
class FileProcessor
  def self.process_text_file(filename)
    line_count = 0
    word_count = 0
    
    begin
      File.open(filename, "r") do |file|
        file.each_line do |line|
          line_count += 1
          word_count += line.split.length
        end
      end
      
      puts "📊 File Statistics:"
      puts "   Lines: #{line_count}"
      puts "   Words: #{word_count}"
      puts "   Average words per line: #{(word_count.to_f / line_count).round(2)}"
      
    rescue Errno::ENOENT
      puts "❌ File not found: #{filename}"
      puts "💡 Make sure the file exists and try again"
    rescue Errno::EACCES
      puts "❌ Permission denied: #{filename}"
      puts "💡 Check if you have permission to read this file"
    rescue => e
      puts "❌ Unexpected error: #{e.message}"
      puts "🐛 Error type: #{e.class}"
    end
  end
end

FileProcessor.process_text_file("story.txt")
```

### Web Request Simulator

```ruby
class WebRequest
  def self.fetch_data(url)
    puts "🌐 Fetching data from #{url}..."
    
    begin
      # Simulate different scenarios
      case url
      when /timeout/
        raise Timeout::Error, "Request timed out"
      when /404/
        raise "404 Not Found"
      when /500/
        raise "500 Internal Server Error"
      when /valid/
        return { status: "success", data: "Here's your data!" }
      else
        raise "Unknown URL pattern"
      end
      
    rescue Timeout::Error => e
      puts "⏰ Request timed out: #{e.message}"
      puts "💡 Try again later or check your connection"
      return { status: "timeout", data: nil }
      
    rescue => e
      puts "❌ Request failed: #{e.message}"
      puts "💡 Check the URL and try again"
      return { status: "error", data: nil }
    end
  end
end

# Test different scenarios
urls = [
  "http://example.com/valid",
  "http://example.com/404",
  "http://example.com/timeout",
  "http://example.com/500"
]

urls.each do |url|
  result = WebRequest.fetch_data(url)
  puts "Result: #{result}\n\n"
end
```

### User Input Validator

```ruby
class UserValidator
  def self.get_valid_email
    max_attempts = 3
    attempts = 0
    
    while attempts < max_attempts
      print "Enter your email: "
      email = gets.chomp
      
      begin
        validate_email(email)
        puts "✅ Valid email: #{email}"
        return email
      rescue => e
        attempts += 1
        remaining = max_attempts - attempts
        puts "❌ #{e.message}"
        
        if remaining > 0
          puts "💡 You have #{remaining} attempts left"
        else
          puts "❌ Too many invalid attempts"
          return nil
        end
      end
    end
  end
  
  def self.validate_email(email)
    raise "Email cannot be empty" if email.empty?
    raise "Email must contain @" unless email.include?("@")
    raise "Email must contain a domain" unless email.match(/\.\w+$/)
    raise "Email cannot start with @" if email.start_with?("@")
    raise "Email cannot end with @" if email.end_with?("@")
  end
  
  def self.get_valid_age
    begin
      print "Enter your age: "
      age_input = gets.chomp
      
      # Try to convert to integer
      age = Integer(age_input)
      
      # Validate range
      raise "Age must be between 0 and 120" unless (0..120).include?(age)
      
      puts "✅ Valid age: #{age}"
      return age
      
    rescue ArgumentError
      puts "❌ Please enter a valid number"
      retry  # Ask again
    rescue => e
      puts "❌ #{e.message}"
      retry  # Ask again
    end
  end
end

puts "🔐 User Registration"
puts "=" * 20

email = UserValidator.get_valid_email
if email
  age = UserValidator.get_valid_age
  puts "\n🎉 Registration successful!"
  puts "Email: #{email}"
  puts "Age: #{age}"
else
  puts "\n❌ Registration failed"
end
```

## Retry Logic - Try Again! 🔄

Sometimes you want to retry an operation that failed:

```ruby
def unreliable_operation
  attempts = 0
  max_attempts = 3
  
  begin
    attempts += 1
    puts "Attempt #{attempts}..."
    
    # Simulate an operation that sometimes fails
    if rand(1..10) <= 3  # 30% success rate
      puts "✅ Operation succeeded!"
      return "Success!"
    else
      raise "Operation failed"
    end
    
  rescue => e
    if attempts < max_attempts
      puts "❌ #{e.message} - Retrying..."
      sleep(1)  # Wait a bit before retrying
      retry     # Go back to the beginning of begin block
    else
      puts "❌ Operation failed after #{max_attempts} attempts"
      raise e   # Re-raise the error
    end
  end
end

unreliable_operation
```

## Error Handling Best Practices 💡

### 1. Be Specific with Your Rescues

```ruby
# Good - catch specific errors
begin
  risky_operation
rescue FileNotFoundError
  handle_missing_file
rescue PermissionError
  handle_permission_issue
end

# Avoid - catching everything
begin
  risky_operation
rescue  # This catches everything!
  puts "Something went wrong"
end
```

### 2. Don't Ignore Errors Silently

```ruby
# Bad - silent failure
begin
  risky_operation
rescue
  # Ignoring the error completely
end

# Good - at least log the error
begin
  risky_operation
rescue => e
  puts "Warning: #{e.message}"
  # Or log to a file
end
```

### 3. Provide Helpful Error Messages

```ruby
def divide_numbers(a, b)
  begin
    result = a / b
  rescue ZeroDivisionError
    puts "❌ Cannot divide by zero!"
    puts "💡 Please use a non-zero number for division"
    return nil
  end
  
  result
end
```

### 4. Clean Up Resources

```ruby
def process_file(filename)
  file = nil
  
  begin
    file = File.open(filename)
    # Process the file
  rescue => e
    puts "Error: #{e.message}"
  ensure
    file&.close  # Safe navigation - only close if file exists
  end
end
```

## Common Error Patterns 📋

### The Guardian Pattern

```ruby
def safe_array_access(array, index)
  return nil if array.nil? || index.nil?
  return nil if index < 0 || index >= array.length
  
  array[index]
end

# Usage
numbers = [1, 2, 3, 4, 5]
puts safe_array_access(numbers, 2)    # 3
puts safe_array_access(numbers, 10)   # nil
puts safe_array_access(nil, 0)        # nil
```

### The Default Value Pattern

```ruby
def get_config_value(key, default = nil)
  config = load_config
  config[key]
rescue => e
  puts "Warning: Could not load config, using default"
  default
end
```

### The Circuit Breaker Pattern

```ruby
class CircuitBreaker
  def initialize(failure_threshold = 5)
    @failure_threshold = failure_threshold
    @failure_count = 0
    @last_failure_time = nil
    @state = :closed  # :closed, :open, :half_open
  end
  
  def call
    case @state
    when :open
      if Time.now - @last_failure_time > 60  # 1 minute timeout
        @state = :half_open
      else
        raise "Circuit breaker is open"
      end
    end
    
    begin
      result = yield  # Execute the operation
      on_success
      result
    rescue => e
      on_failure
      raise e
    end
  end
  
  private
  
  def on_success
    @failure_count = 0
    @state = :closed
  end
  
  def on_failure
    @failure_count += 1
    @last_failure_time = Time.now
    
    if @failure_count >= @failure_threshold
      @state = :open
    end
  end
end
```

## Fun Challenges 🎮

### Challenge 1: Robust Calculator
Create a calculator that handles all possible errors gracefully and keeps asking for input until the user enters valid data.

### Challenge 2: File Backup System
Create a system that backs up files safely, handling all possible file errors and providing helpful feedback.

### Challenge 3: Network Request Simulator
Build a system that simulates network requests with various failure modes and implements retry logic.

## What's Next? 🚀

Fantastic! You've learned how to make your programs resilient and handle unexpected situations gracefully. Your code is now much more professional and user-friendly! 🛡️

Next up, we'll explore **Regular Expressions** - Ruby's pattern-matching superpower that lets you find and manipulate text in incredibly sophisticated ways! 🔍

## Quick Reference 📋

```ruby
# Basic error handling
begin
  risky_code
rescue
  handle_error
end

# Specific error handling
begin
  risky_code
rescue SpecificError => e
  puts e.message
rescue => e  # Catch all StandardError
  puts "Unknown error: #{e.message}"
else
  puts "No errors occurred"
ensure
  puts "This always runs"
end

# Raising errors
raise "Something is wrong"
raise ArgumentError, "Invalid argument"

# Retry
begin
  unreliable_operation
rescue
  retry  # Try again
end

# Custom errors
class MyError < StandardError; end
```

Remember: Errors are like rain - you can't prevent them, but you can be prepared with an umbrella! ☔🛡️

[← Previous: File Operations](./16-file-operations.md) | [Next: Regular Expressions →](./18-regex.md)
