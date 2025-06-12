# Ruby Quick Reference Card

## Variables and Data Types
```ruby
# Variables
name = "Ruby"              # String
age = 25                   # Integer
price = 19.99             # Float
active = true             # Boolean
items = ["a", "b", "c"]   # Array
person = { name: "John" } # Hash

# Constants
MAX_SIZE = 100

# Symbols
:symbol_name
```

## String Operations
```ruby
str = "Hello World"
str.length                # 11
str.upcase                # "HELLO WORLD"
str.downcase              # "hello world"
str.include?("World")     # true
str.split(" ")            # ["Hello", "World"]
str.gsub("World", "Ruby") # "Hello Ruby"

# String interpolation
name = "Ruby"
"Hello #{name}!"          # "Hello Ruby!"
```

## Arrays
```ruby
arr = [1, 2, 3, 4, 5]
arr.length                # 5
arr.first                 # 1
arr.last                  # 5
arr.push(6)               # [1, 2, 3, 4, 5, 6]
arr << 7                  # [1, 2, 3, 4, 5, 6, 7]
arr.pop                   # 7
arr.include?(3)           # true
arr.join(", ")            # "1, 2, 3, 4, 5, 6"

# Array methods
arr.each { |item| puts item }
arr.map { |x| x * 2 }
arr.select { |x| x > 3 }
arr.find { |x| x > 3 }
```

## Hashes
```ruby
hash = { "name" => "John", "age" => 30 }
hash = { name: "John", age: 30 }  # Symbol keys

hash[:name]               # "John"
hash[:age] = 31          # Update
hash.keys                # [:name, :age]
hash.values              # ["John", 31]
hash.has_key?(:name)     # true

# Hash iteration
hash.each { |key, value| puts "#{key}: #{value}" }
```

## Control Structures
```ruby
# If/else
if condition
  # code
elsif another_condition
  # code
else
  # code
end

# Unless
unless condition
  # code
end

# Case/when
case variable
when value1
  # code
when value2
  # code
else
  # code
end

# Ternary operator
result = condition ? true_value : false_value
```

## Loops
```ruby
# While loop
while condition
  # code
end

# Until loop
until condition
  # code
end

# For loop
for i in 1..5
  puts i
end

# Times loop
5.times do |i|
  puts i
end

# Each loop
[1, 2, 3].each do |item|
  puts item
end

# Range iteration
(1..5).each { |i| puts i }
```

## Methods
```ruby
# Method definition
def method_name(param1, param2 = default_value)
  # code
  return result  # optional
end

# Method with block
def with_block
  yield if block_given?
end

# Call with block
with_block { puts "Hello!" }

# Method with splat
def variable_args(*args)
  args.each { |arg| puts arg }
end
```

## Classes and Objects
```ruby
class Person
  attr_reader :name
  attr_writer :age
  attr_accessor :email

  def initialize(name, age)
    @name = name
    @age = age
  end

  def greet
    "Hello, I'm #{@name}"
  end

  def self.class_method
    "This is a class method"
  end

  private

  def private_method
    "Only accessible within the class"
  end
end

# Usage
person = Person.new("John", 30)
person.name          # "John"
person.greet         # "Hello, I'm John"
Person.class_method  # "This is a class method"
```

## Modules
```ruby
module Greetings
  def hello
    "Hello!"
  end

  def goodbye
    "Goodbye!"
  end
end

class Person
  include Greetings
end

person = Person.new
person.hello  # "Hello!"
```

## File Operations
```ruby
# Reading files
content = File.read("file.txt")
lines = File.readlines("file.txt")

# Writing files
File.write("file.txt", "content")
File.open("file.txt", "w") { |f| f.write("content") }

# File existence
File.exist?("file.txt")
File.directory?("path")
```

## Error Handling
```ruby
begin
  # risky code
rescue StandardError => e
  puts "Error: #{e.message}"
rescue SpecificError => e
  puts "Specific error: #{e.message}"
ensure
  # always executed
end

# Raising exceptions
raise "Something went wrong"
raise ArgumentError, "Invalid argument"
```

## Regular Expressions
```ruby
pattern = /\d+/           # Match digits
text = "Age: 25"

text =~ pattern           # 5 (position of match)
text.match(pattern)       # MatchData object
text.scan(pattern)        # ["25"]
text.gsub(pattern, "XX")  # "Age: XX"

# Common patterns
/\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i  # Email
/^\d{3}-\d{3}-\d{4}$/                                # Phone
```

## Blocks, Procs, and Lambdas
```ruby
# Block
[1, 2, 3].each { |x| puts x }

# Proc
my_proc = Proc.new { |x| puts x }
my_proc.call(5)

# Lambda
my_lambda = lambda { |x| puts x }
my_lambda = ->(x) { puts x }
my_lambda.call(5)
```

## Common Enumerables
```ruby
arr = [1, 2, 3, 4, 5]

arr.each { |x| puts x }      # Iterate
arr.map { |x| x * 2 }        # Transform: [2, 4, 6, 8, 10]
arr.select { |x| x > 3 }     # Filter: [4, 5]
arr.reject { |x| x > 3 }     # Inverse filter: [1, 2, 3]
arr.find { |x| x > 3 }       # First match: 4
arr.reduce(:+)               # Sum: 15
arr.any? { |x| x > 3 }       # true
arr.all? { |x| x > 0 }       # true
```

## Useful Methods
```ruby
# Object inspection
obj.class                 # Object's class
obj.methods               # Available methods
obj.instance_variables    # Instance variables
obj.respond_to?(:method)  # Check if method exists

# Type checking
obj.is_a?(String)         # Check type
obj.nil?                  # Check if nil
obj.empty?                # Check if empty (String/Array)

# Conversion
"123".to_i                # 123
123.to_s                  # "123"
"3.14".to_f               # 3.14
```

## Common Gems
```ruby
# In Gemfile
gem 'rails'               # Web framework
gem 'sinatra'             # Lightweight web framework
gem 'rspec'               # Testing framework
gem 'nokogiri'            # HTML/XML parser
gem 'httparty'            # HTTP client
gem 'json'                # JSON handling
gem 'redis'               # Redis client
gem 'pg'                  # PostgreSQL adapter
```

## Best Practices
- Use snake_case for variables and methods
- Use CamelCase for classes and modules
- Use SCREAMING_SNAKE_CASE for constants
- Prefer symbols over strings for hash keys
- Use meaningful variable and method names
- Keep methods short and focused
- Handle exceptions appropriately
- Write tests for your code
- Follow the DRY principle (Don't Repeat Yourself)
- Use Ruby conventions and idioms
