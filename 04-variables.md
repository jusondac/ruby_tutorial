# Chapter 4: Variables - Your Data Containers 📦

## 🤔 What Are Variables?

Imagine you have a bunch of boxes in your room. Each box has a label on it like "Toys", "Books", or "Snacks". You can put things in these boxes, take things out, or even replace what's inside. Variables in Ruby work exactly like these labeled boxes!

Variables are containers that hold information so you can use it later. They're like Ruby's memory system!

## 📝 Creating Your First Variables

In Ruby, creating a variable is super easy. You just give it a name and put something in it:

```ruby
name = "Alex"
age = 10
favorite_color = "blue"
is_happy = true

puts name          # Shows: Alex
puts age           # Shows: 10
puts favorite_color # Shows: blue
puts is_happy      # Shows: true
```

**What just happened?**
- `name = "Alex"` - Created a box called "name" and put "Alex" in it
- `age = 10` - Created a box called "age" and put the number 10 in it
- The `=` sign means "put this value in this box"

## 🏷️ Variable Naming Rules

Ruby has some rules for naming your variable boxes:

### ✅ Good Names:
```ruby
name = "Ruby"
my_age = 25
favorite_food = "pizza"
player_score = 100
is_sunny = true
```

### ❌ Bad Names:
```ruby
# Can't start with numbers
2cool = "nope"

# Can't have spaces
my name = "nope"

# Can't use special characters (except _)
my-name = "nope"
my@email = "nope"

# Can't use Ruby's special words
class = "nope"
def = "nope"
```

### 🎯 Good Naming Tips:
- Use **lowercase letters** and **underscores**
- Make names **descriptive**: `user_name` is better than `n`
- Use **snake_case**: `favorite_food` not `favoriteFood`

## 🎭 Types of Things Variables Can Hold

Variables can hold different types of things, just like your boxes can hold toys, books, or snacks:

### 1. Strings (Text) 📝
```ruby
first_name = "Ruby"
last_name = "Programmer"
favorite_quote = "Learning is fun!"
empty_string = ""

# You can use single or double quotes
message1 = "Hello world!"
message2 = 'Hello world!'
```

### 2. Numbers 🔢
```ruby
# Integers (whole numbers)
age = 15
score = 100
temperature = -5

# Floats (decimal numbers)
height = 5.5
price = 19.99
pi = 3.14159
```

### 3. Booleans (True/False) ✅❌
```ruby
is_sunny = true
is_raining = false
likes_ruby = true
is_sleeping = false
```

### 4. Nil (Nothing) ⭕
```ruby
nothing = nil  # This box is empty!
```

## 🔄 Changing What's in Your Variables

You can always change what's in a variable box:

```ruby
mood = "happy"
puts mood  # Shows: happy

mood = "excited"
puts mood  # Shows: excited

mood = "super excited!"
puts mood  # Shows: super excited!
```

## 🧮 Math with Variables

You can do math with number variables:

```ruby
apples = 5
oranges = 3

total_fruit = apples + oranges
puts "I have #{total_fruit} pieces of fruit!"

# You can even change a variable using itself!
score = 10
score = score + 5  # Now score is 15

# Ruby has a shortcut for this:
score += 5  # Same as: score = score + 5
```

## 🎪 Fun with String Variables

Strings have lots of cool tricks:

```ruby
first_name = "Ruby"
last_name = "Gem"

# Joining strings together
full_name = first_name + " " + last_name
puts full_name  # Shows: Ruby Gem

# Making strings longer
greeting = "Hello"
greeting += " there!"  # Same as: greeting = greeting + " there!"
puts greeting  # Shows: Hello there!

# String interpolation (putting variables inside strings)
name = "Alex"
age = 12
message = "Hi, I'm #{name} and I'm #{age} years old!"
puts message  # Shows: Hi, I'm Alex and I'm 12 years old!
```

## 🔍 Checking What Type Your Variable Is

Ruby can tell you what type of thing is in your variable:

```ruby
name = "Ruby"
age = 25
is_fun = true
nothing = nil

puts name.class    # Shows: String
puts age.class     # Shows: Integer
puts is_fun.class  # Shows: TrueClass
puts nothing.class # Shows: NilClass
```

## 🎯 Practical Variable Examples

### Example 1: A Simple Calculator
```ruby
puts "Simple Calculator!"

puts "Enter first number:"
first_number = gets.chomp.to_i

puts "Enter second number:"
second_number = gets.chomp.to_i

sum = first_number + second_number
difference = first_number - second_number
product = first_number * second_number

puts "#{first_number} + #{second_number} = #{sum}"
puts "#{first_number} - #{second_number} = #{difference}"
puts "#{first_number} × #{second_number} = #{product}"
```

### Example 2: Personal Information Storage
```ruby
puts "Let's store some information about you!"

puts "What's your name?"
user_name = gets.chomp

puts "How old are you?"
user_age = gets.chomp.to_i

puts "What's your favorite hobby?"
user_hobby = gets.chomp

puts "\n📋 Your Profile:"
puts "Name: #{user_name}"
puts "Age: #{user_age}"
puts "Hobby: #{user_hobby}"
puts "Next year you'll be #{user_age + 1} years old!"
```

## 🎨 String Tricks and Tips

```ruby
name = "ruby programming"

# Make it uppercase
puts name.upcase  # RUBY PROGRAMMING

# Make it lowercase
puts name.downcase  # ruby programming

# Capitalize first letter
puts name.capitalize  # Ruby programming

# Get the length
puts name.length  # 16

# Check if it includes something
puts name.include?("ruby")  # true
puts name.include?("python")  # false
```

## ⚠️ Common Variable Mistakes

### 1. Using a Variable Before Creating It
```ruby
# Wrong:
puts my_name  # Error! my_name doesn't exist yet

# Right:
my_name = "Alex"
puts my_name  # Works!
```

### 2. Forgetting Quotes for Text
```ruby
# Wrong:
name = Alex  # Ruby looks for a variable called Alex

# Right:
name = "Alex"  # Ruby knows this is text
```

### 3. Trying to Do Math with Text
```ruby
# This might not work as expected:
age = "25"
next_year = age + 1  # Error! Can't add number to text

# Better:
age = "25".to_i  # Convert to number first
next_year = age + 1  # Now it works!
```

## 🎲 Variable Scope (Where Variables Live)

Variables have a "home" - they only exist in certain places:

```ruby
# This variable lives everywhere in this file
global_name = "Ruby"

def my_method
  # This variable only lives inside this method
  local_name = "Local Ruby"
  puts local_name  # Works here
end

puts global_name  # Works here
puts local_name   # Error! local_name doesn't exist here
```

Don't worry about this too much yet - we'll learn more about methods later!

## 🎉 You're Getting Good at This!

Now you know how to:
- ✅ Create variables to store information
- ✅ Use different types of data (strings, numbers, booleans)
- ✅ Change what's stored in variables
- ✅ Do math with number variables
- ✅ Combine and manipulate text variables
- ✅ Check what type of data you have

Variables are like the foundation of programming - almost everything uses them!

---

## 🚀 What's Next?

Now that you can store information in variables, let's explore numbers and math in Ruby!

**[← Previous: Your First Ruby Program](./03-first-program.md)** | **[Next: Numbers and Math →](./05-numbers-math.md)**

---

### 🎯 Practice Challenges

Try these variable exercises:
1. **Temperature Converter**: Store temperature in Celsius, convert to Fahrenheit
2. **Name Mixer**: Take two names, create silly combinations
3. **Score Tracker**: Keep track of points in a game, add/subtract scores
4. **Mad Libs**: Store different words, create a funny story

Remember: Variables are your friends - use them to make your programs remember things! 🧠
