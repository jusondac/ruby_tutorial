# Chapter 10: Conditionals - Making Decisions 🤔

## 🎭 What Are Conditionals?

Conditionals are how you teach your programs to make decisions! Just like how you decide what to wear based on the weather, or what to eat based on what's in the fridge, programs use conditionals to choose what to do based on different situations.

Think of conditionals as:
- 🌤️ **Weather decisions**: "If it's raining, bring an umbrella"
- 🚦 **Traffic lights**: "If the light is red, stop"
- 🎮 **Game logic**: "If the player has enough coins, let them buy the item"

## 🔍 The `if` Statement

The most basic conditional is `if`:

```ruby
temperature = 75

if temperature > 70
  puts "It's warm outside! 🌞"
end

age = 16

if age >= 18
  puts "You can vote! 🗳️"
end

if age >= 16
  puts "You can drive! 🚗"
end
```

## 🔄 The `if-else` Statement

Sometimes you want to do one thing if the condition is true, and something else if it's false:

```ruby
score = 85

if score >= 60
  puts "You passed! 🎉"
else
  puts "You need to study more 📚"
end

weather = "rainy"

if weather == "sunny"
  puts "Let's go to the beach! 🏖️"
else
  puts "Let's stay inside and code! 💻"
end
```

## 🎚️ The `elsif` Statement

When you have multiple conditions to check:

```ruby
grade = 88

if grade >= 90
  puts "Grade: A 🌟"
elsif grade >= 80
  puts "Grade: B 👍"
elsif grade >= 70
  puts "Grade: C 😐"
elsif grade >= 60
  puts "Grade: D 😟"
else
  puts "Grade: F 😱"
end

time_of_day = 14  # 24-hour format

if time_of_day < 12
  puts "Good morning! ☀️"
elsif time_of_day < 17
  puts "Good afternoon! 🌤️"
elsif time_of_day < 21
  puts "Good evening! 🌆"
else
  puts "Good night! 🌙"
end
```

## 🎯 Comparison Operators

Ruby has several ways to compare values:

```ruby
x = 10
y = 5

# Equal to
puts x == y    # false (10 is not equal to 5)
puts x == 10   # true

# Not equal to
puts x != y    # true (10 is not equal to 5)
puts x != 10   # false

# Greater than
puts x > y     # true (10 is greater than 5)

# Less than
puts x < y     # false (10 is not less than 5)

# Greater than or equal to
puts x >= 10   # true
puts x >= 15   # false

# Less than or equal to
puts y <= 5    # true
puts y <= 3    # false
```

## 🔗 Logical Operators

Combine multiple conditions:

```ruby
age = 25
has_license = true
has_car = false

# AND (&&) - both conditions must be true
if age >= 18 && has_license
  puts "You can drive legally! 🚗"
end

# OR (||) - at least one condition must be true
if has_license || age >= 21
  puts "You meet at least one requirement!"
end

# NOT (!) - reverses true/false
if !has_car
  puts "You don't have a car 😔"
end

# More complex example
weather = "sunny"
temperature = 75
have_sunscreen = true

if weather == "sunny" && temperature > 70 && have_sunscreen
  puts "Perfect beach day! 🏖️"
elsif weather == "sunny" && temperature > 70
  puts "Great day, but don't forget sunscreen! ☀️"
elsif weather == "sunny"
  puts "Sunny but a bit cool 🌤️"
else
  puts "Maybe stay inside today 🏠"
end
```

## 🎮 Practical Examples

### Example 1: Simple Password Checker
```ruby
def check_password(password)
  if password.length < 8
    puts "❌ Password too short! Must be at least 8 characters."
  elsif password == password.downcase
    puts "❌ Password must contain uppercase letters!"
  elsif password == password.upcase
    puts "❌ Password must contain lowercase letters!"
  elsif !password.match?(/\d/)
    puts "❌ Password must contain numbers!"
  else
    puts "✅ Strong password!"
  end
end

check_password("abc")           # Too short
check_password("abcdefgh")      # No uppercase
check_password("ABCDEFGH")      # No lowercase
check_password("Abcdefgh")      # No numbers
check_password("Abcdefgh1")     # Strong!
```

### Example 2: Grade Calculator
```ruby
def calculate_grade(score)
  if score < 0 || score > 100
    puts "❌ Invalid score! Must be between 0 and 100."
  elsif score >= 97
    puts "🌟 A+ (#{score}%) - Outstanding!"
  elsif score >= 93
    puts "⭐ A (#{score}%) - Excellent!"
  elsif score >= 90
    puts "🎯 A- (#{score}%) - Great work!"
  elsif score >= 87
    puts "👍 B+ (#{score}%) - Good job!"
  elsif score >= 83
    puts "😊 B (#{score}%) - Well done!"
  elsif score >= 80
    puts "🙂 B- (#{score}%) - Not bad!"
  elsif score >= 77
    puts "😐 C+ (#{score}%) - Okay!"
  elsif score >= 73
    puts "😕 C (#{score}%) - Could be better."
  elsif score >= 70
    puts "😟 C- (#{score}%) - Need improvement."
  elsif score >= 60
    puts "😰 D (#{score}%) - Study harder!"
  else
    puts "😱 F (#{score}%) - Need to retake!"
  end
end

calculate_grade(95)   # A
calculate_grade(78)   # C+
calculate_grade(45)   # F
```

### Example 3: Simple Game Logic
```ruby
def adventure_game
  puts "🎮 Welcome to the Ruby Adventure!"
  puts "You're standing at a crossroads."
  puts "Which way do you go? (left/right/straight)"
  
  direction = gets.chomp.downcase
  
  if direction == "left"
    puts "🌲 You enter a dark forest..."
    puts "You see a treasure chest! Open it? (yes/no)"
    choice = gets.chomp.downcase
    
    if choice == "yes"
      puts "💰 You found 100 gold coins! You win!"
    else
      puts "🚶 You walk away safely, but with no treasure."
    end
    
  elsif direction == "right"
    puts "🏔️ You climb a steep mountain..."
    puts "You meet a friendly dragon! Talk to it? (yes/no)"
    choice = gets.chomp.downcase
    
    if choice == "yes"
      puts "🐉 The dragon gives you a magic sword! You win!"
    else
      puts "🏃 You run away in fear."
    end
    
  elsif direction == "straight"
    puts "🏰 You approach a mysterious castle..."
    puts "The door is locked. Try to pick the lock? (yes/no)"
    choice = gets.chomp.downcase
    
    if choice == "yes"
      luck = rand(1..2)  # Random number 1 or 2
      if luck == 1
        puts "🔓 Success! You find a princess and become a hero!"
      else
        puts "🚨 Guards catch you! Game over!"
      end
    else
      puts "🚪 You knock on the door and are welcomed as a guest!"
    end
    
  else
    puts "🤷 You stand there confused and nothing happens."
  end
end

# adventure_game  # Uncomment to play!
```

## 🎯 The Ternary Operator

A shortcut for simple if-else statements:

```ruby
# Long way
age = 20
if age >= 18
  status = "adult"
else
  status = "minor"
end

# Short way (ternary operator)
age = 20
status = age >= 18 ? "adult" : "minor"
puts status  # "adult"

# More examples
weather = "sunny"
activity = weather == "sunny" ? "go outside" : "stay inside"
puts activity  # "go outside"

score = 85
result = score >= 60 ? "pass" : "fail"
puts result  # "pass"

# Ternary can be chained (but can get confusing)
grade = score >= 90 ? "A" : score >= 80 ? "B" : score >= 70 ? "C" : "F"
puts grade  # "B"
```

## 🎪 The `case` Statement

When you have many conditions, `case` is cleaner than many `elsif` statements:

```ruby
day = "Monday"

case day
when "Monday"
  puts "😫 Ugh, Monday..."
when "Tuesday"
  puts "😐 Tuesday blues"
when "Wednesday"
  puts "🐫 Hump day!"
when "Thursday"
  puts "😊 Almost there!"
when "Friday"
  puts "🎉 TGIF!"
when "Saturday", "Sunday"
  puts "😎 Weekend vibes!"
else
  puts "🤔 Not sure what day that is..."
end

# Case with ranges
score = 85

case score
when 90..100
  puts "Grade: A"
when 80..89
  puts "Grade: B"
when 70..79
  puts "Grade: C"
when 60..69
  puts "Grade: D"
else
  puts "Grade: F"
end

# Case with different types
user_input = "42"

case user_input
when String
  puts "You entered text: #{user_input}"
when Integer
  puts "You entered a number: #{user_input}"
when Array
  puts "You entered a list"
else
  puts "Unknown input type"
end
```

## 🔧 Advanced Conditional Techniques

### Unless Statement
```ruby
age = 15

# Instead of: if !(age >= 18)
unless age >= 18
  puts "You cannot vote yet"
end

# With else
weather = "rainy"

unless weather == "sunny"
  puts "Stay inside"
else
  puts "Go outside!"
end
```

### Conditional Assignment
```ruby
# Set a default value only if variable is nil or false
name = nil
name ||= "Anonymous"  # Same as: name = name || "Anonymous"
puts name  # "Anonymous"

# Only assign if condition is true
score = 85
bonus = 10 if score > 80
puts bonus  # 10

# Multiple assignment with conditions
x, y = 5, 10
smaller, larger = x < y ? [x, y] : [y, x]
puts "Smaller: #{smaller}, Larger: #{larger}"
```

### Guard Clauses
```ruby
def process_user(user)
  return "No user provided" if user.nil?
  return "User must be an adult" if user[:age] < 18
  return "User must have email" if user[:email].nil?
  
  # Main logic here
  "Processing user: #{user[:name]}"
end

puts process_user(nil)
puts process_user({name: "Bob", age: 16, email: "bob@test.com"})
puts process_user({name: "Alice", age: 25, email: "alice@test.com"})
```

## 🎉 Conditionals Mastery!

You now know how to:
- ✅ Use `if`, `else`, and `elsif` for decision making
- ✅ Compare values with ==, !=, >, <, >=, <=
- ✅ Combine conditions with &&, ||, and !
- ✅ Use the ternary operator for simple conditions
- ✅ Handle multiple conditions with `case` statements
- ✅ Apply conditionals in practical, real-world scenarios
- ✅ Use advanced techniques like guard clauses and conditional assignment

Conditionals are the foundation of program logic and decision-making!

---

## 🚀 What's Next?

Now let's learn about loops - how to make your programs repeat actions!

**[← Previous: Methods - Your Own Commands](./09-methods.md)** | **[Next: Loops - Doing Things Again →](./11-loops.md)**

---

### 🎯 Conditional Challenges

Try building these decision-making programs:
1. **Rock Paper Scissors**: Compare user choice vs computer choice
2. **Login System**: Check username and password combinations
3. **BMI Calculator**: Categorize health based on BMI ranges
4. **Quiz Game**: Check answers and give appropriate feedback

Conditionals help your programs think and decide! 🤔✨
