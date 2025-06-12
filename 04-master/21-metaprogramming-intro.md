# Chapter 21: Introduction to Metaprogramming 🧙‍♂️

## 🤯 What is Metaprogramming?

Imagine you have a magic wand that can create other magic wands! That's what metaprogramming is like. It's code that writes other code. It's like being a wizard who can teach other wizards how to cast spells!

In simple terms: **Metaprogramming is when your Ruby program can change itself while it's running.**

Think of it like this:
- 📝 Regular programming: You write code that does things
- 🧙‍♂️ Metaprogramming: You write code that writes more code that does things

## 🎭 Why is Metaprogramming Cool?

### 1. Less Repetitive Code
Instead of writing the same code over and over, you can write code that writes it for you!

### 2. Dynamic Behavior
Your program can adapt and change based on what's happening while it runs.

### 3. Ruby's Secret Sauce
Many of Ruby's coolest features (like Rails) use metaprogramming heavily.

## 🌟 Simple Metaprogramming Examples

Let's start with some easy examples to understand the concept:

### Example 1: Creating Methods on the Fly
```ruby
class Robot
  # This creates a method dynamically!
  define_method("say_hello") do
    puts "Hello, I'm a robot!"
  end
end

robot = Robot.new
robot.say_hello  # Hello, I'm a robot!
```

**What happened?** We used `define_method` to create a method while the program was running!

### Example 2: Creating Multiple Similar Methods
```ruby
class Animal
  # Create methods for different sounds
  ["bark", "meow", "moo", "oink"].each do |sound|
    define_method("make_#{sound}") do
      puts "The animal says #{sound}!"
    end
  end
end

dog = Animal.new
dog.make_bark  # The animal says bark!
dog.make_meow  # The animal says meow!
dog.make_moo   # The animal says moo!
dog.make_oink  # The animal says oink!
```

**Cool, right?** We created 4 methods with just a few lines of code!

## 🔍 Ruby's Introspection Powers

Ruby can look at itself and tell you what it contains. It's like having X-ray vision for code!

### Finding Out What Methods an Object Has
```ruby
class Person
  def initialize(name)
    @name = name
  end
  
  def say_hello
    puts "Hello, I'm #{@name}"
  end
  
  def wave
    puts "*waves*"
  end
end

person = Person.new("Alice")

# See all methods this object can use
puts person.methods.sort
# This shows TONS of methods! (including built-in Ruby methods)

# See just the methods we defined
puts person.methods(false).sort
# [:say_hello, :wave]

# Check if a method exists
puts person.respond_to?(:say_hello)  # true
puts person.respond_to?(:fly)        # false
```

### Finding Out About Classes
```ruby
# What class is this object?
puts "hello".class         # String
puts 42.class              # Integer
puts [1, 2, 3].class       # Array

# What's the parent class?
puts String.superclass     # Object
puts Integer.superclass    # Numeric

# What modules are included?
puts String.included_modules
```

## 🎯 Dynamic Method Calls

You can call methods using their names as strings! It's like having a phone book of methods.

### Using `send`
```ruby
class Calculator
  def add(a, b)
    a + b
  end
  
  def multiply(a, b)
    a * b
  end
  
  def subtract(a, b)
    a - b
  end
end

calc = Calculator.new

# Instead of: calc.add(5, 3)
result1 = calc.send("add", 5, 3)      # 8
result2 = calc.send(:multiply, 4, 7)  # 28

# Dynamic method calling based on user input
puts "What operation? (add, multiply, subtract)"
operation = gets.chomp

if calc.respond_to?(operation)
  result = calc.send(operation, 10, 5)
  puts "Result: #{result}"
else
  puts "I don't know how to #{operation}"
end
```

## 🎪 Creating Classes Dynamically

You can even create entire classes while your program is running!

```ruby
# Create a class dynamically
MyClass = Class.new do
  def initialize(name)
    @name = name
  end
  
  def greet
    puts "Hello from #{@name}!"
  end
end

# Use the dynamically created class
obj = MyClass.new("Dynamic Object")
obj.greet  # Hello from Dynamic Object!

# Create classes with different names
["Dog", "Cat", "Bird"].each do |animal|
  # This creates classes Dog, Cat, and Bird
  Object.const_set(animal, Class.new do
    define_method(:sound) do
      case self.class.name
      when "Dog" then "Woof!"
      when "Cat" then "Meow!"
      when "Bird" then "Tweet!"
      end
    end
  end)
end

dog = Dog.new
puts dog.sound  # Woof!

cat = Cat.new
puts cat.sound  # Meow!
```

## 🧠 The `class_eval` and `instance_eval` Methods

These let you run code in the context of a class or object:

### `class_eval` - Adding to Classes
```ruby
class Person
  attr_accessor :name
  
  def initialize(name)
    @name = name
  end
end

# Add a method to the Person class later
Person.class_eval do
  def age
    @age || 0
  end
  
  def age=(new_age)
    @age = new_age
  end
end

person = Person.new("Alice")
person.age = 25
puts person.age  # 25
```

### `instance_eval` - Adding to Specific Objects
```ruby
person = Person.new("Bob")

# Add a method to just this one person object
person.instance_eval do
  def special_power
    "#{@name} can fly!"
  end
end

puts person.special_power  # Bob can fly!

# Other Person objects don't have this method
other_person = Person.new("Carol")
# other_person.special_power  # This would cause an error!
```

## 🎮 Practical Metaprogramming Example

Let's build a simple configuration system using metaprogramming:

```ruby
class Config
  def initialize
    @settings = {}
  end
  
  # Dynamically create getter and setter methods
  def self.setting(name)
    # Create getter method
    define_method(name) do
      @settings[name]
    end
    
    # Create setter method
    define_method("#{name}=") do |value|
      @settings[name] = value
    end
  end
  
  # Define some settings
  setting :database_url
  setting :api_key
  setting :debug_mode
  setting :max_users
end

# Use our dynamic configuration
config = Config.new
config.database_url = "postgresql://localhost/myapp"
config.api_key = "secret123"
config.debug_mode = true
config.max_users = 1000

puts "Database: #{config.database_url}"
puts "API Key: #{config.api_key}"
puts "Debug: #{config.debug_mode}"
puts "Max Users: #{config.max_users}"
```

## ⚠️ Metaprogramming Warnings

Metaprogramming is powerful, but with great power comes great responsibility:

### 1. It Can Be Confusing
```ruby
# This creates methods, but it's not obvious where they come from
class Mystery
  ["a", "b", "c"].each { |letter| define_method(letter) { puts letter } }
end

mystery = Mystery.new
mystery.a  # Where did this method come from?
```

### 2. It Can Be Slow
Metaprogramming often happens at runtime, which can be slower than regular code.

### 3. It Can Break Tools
IDEs and other tools might not understand dynamically created methods.

### 4. It Can Make Debugging Hard
When methods are created dynamically, it's harder to track down where problems come from.

## 🎯 When to Use Metaprogramming

✅ **Good times to use it:**
- Eliminating repetitive code
- Creating DSLs (Domain Specific Languages)
- Building frameworks and libraries
- When you need flexible, configurable behavior

❌ **Bad times to use it:**
- When simple, regular code would work fine
- When it makes code harder to understand
- For showing off (resist the urge!)
- When performance is critical

## 🎉 Metaprogramming Mindset

Think of metaprogramming as having these superpowers:
- 🔍 **X-ray vision**: See inside objects and classes
- ⚡ **Shape-shifting**: Change objects and classes on the fly
- 🏗️ **Construction**: Build new methods and classes dynamically
- 📞 **Telepathy**: Call methods by name

## 🎭 Real-World Metaprogramming

Many Ruby gems use metaprogramming:

- **Rails**: `has_many`, `belongs_to`, `validates` are all metaprogramming
- **RSpec**: `describe`, `it`, `expect` create a testing DSL
- **ActiveRecord**: Database column methods are created dynamically
- **Sinatra**: Route definitions use metaprogramming

You've probably been using metaprogramming without realizing it!

---

## 🚀 What's Next?

Now that you understand the basics of metaprogramming, let's dive deeper into dynamic methods!

**[← Previous: Testing Your Code](../03-advanced/20-testing.md)** | **[Next: Dynamic Methods →](./22-dynamic-methods.md)**

---

### 🎯 Metaprogramming Challenges

Try these to practice:
1. Create a class that automatically generates getter/setter methods for any attribute
2. Build a simple command processor that calls methods based on user input
3. Create a "Parrot" class that can learn new phrases dynamically
4. Make a class that logs every method call automatically

Remember: Metaprogramming is like magic - use it wisely! 🧙‍♂️✨
