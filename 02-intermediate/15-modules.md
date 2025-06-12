# Chapter 15: Modules - Code Libraries 📚

[← Previous: Inheritance](./14-inheritance.md) | [Next: File Operations →](../03-advanced/16-file-operations.md)

## What Are Modules? 🧩

Imagine you have a magical toolbox filled with useful tools that any craftsperson can borrow! That's exactly what modules are in Ruby - they're like toolboxes full of methods that different classes can use.

Modules solve a problem: what if you want to share code between classes that aren't related by inheritance? For example, both a `Bird` and an `Airplane` can fly, but they're completely different things! 🐦✈️

## Creating Your First Module 🔧

Modules look similar to classes but use the `module` keyword:

```ruby
module Greetings
  def say_hello
    puts "Hello there! 👋"
  end
  
  def say_goodbye
    puts "Goodbye! See you later! 👋"
  end
end

# Include the module in a class
class Person
  include Greetings  # Now Person has greeting methods!
  
  def initialize(name)
    @name = name
  end
end

class Robot
  include Greetings  # Robot can greet too!
  
  def initialize(model)
    @model = model
  end
end

# Both can use the greeting methods!
alice = Person.new("Alice")
alice.say_hello    # "Hello there! 👋"

robo = Robot.new("R2D2")
robo.say_goodbye   # "Goodbye! See you later! 👋"
```

## Different Ways to Use Modules 🎯

### 1. `include` - Instance Methods 👤

When you `include` a module, its methods become instance methods:

```ruby
module Walkable
  def walk
    puts "Walking step by step... 🚶"
  end
  
  def run
    puts "Running fast! 🏃"
  end
end

class Human
  include Walkable
end

class Dog
  include Walkable
end

# Both can walk and run
person = Human.new
person.walk  # "Walking step by step... 🚶"

buddy = Dog.new
buddy.run    # "Running fast! 🏃"
```

### 2. `extend` - Class Methods 🏛️

When you `extend` a module, its methods become class methods:

```ruby
module Countable
  def count
    @count ||= 0
  end
  
  def increment_count
    @count = count + 1
  end
end

class Visitor
  extend Countable  # Module methods become class methods
end

# Use as class methods
Visitor.increment_count
Visitor.increment_count
puts Visitor.count  # 2
```

### 3. `prepend` - Method Priority 🎯

`prepend` is like `include`, but the module's methods have higher priority:

```ruby
module Enhanced
  def greet
    puts "Enhanced greeting!"
    super  # Call the original method
  end
end

class BasicGreeter
  def greet
    puts "Basic greeting"
  end
end

class AdvancedGreeter < BasicGreeter
  prepend Enhanced  # Enhanced methods come first
end

greeter = AdvancedGreeter.new
greeter.greet
# Output:
# Enhanced greeting!
# Basic greeting
```

## Modules as Namespaces 🏠

Modules can also organize your code by creating namespaces (like putting things in different rooms):

```ruby
module Games
  class Card
    def initialize(suit, value)
      @suit = suit
      @value = value
    end
    
    def to_s
      "#{@value} of #{@suit}"
    end
  end
  
  class Deck
    def initialize
      @cards = []
      suits = ['Hearts', 'Diamonds', 'Clubs', 'Spades']
      values = ['A', '2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K']
      
      suits.each do |suit|
        values.each do |value|
          @cards << Card.new(suit, value)
        end
      end
    end
    
    def shuffle!
      @cards.shuffle!
    end
    
    def draw_card
      @cards.pop
    end
  end
end

# Use the namespaced classes
deck = Games::Deck.new
deck.shuffle!
card = deck.draw_card
puts card  # "K of Spades" (for example)
```

## Real-World Example: Animal Abilities 🦁

Let's create a zoo management system with different animal abilities:

```ruby
# Flying ability
module Flyable
  def fly
    puts "#{self.class} #{@name} soars through the sky! 🦅"
  end
  
  def land
    puts "#{self.class} #{@name} gracefully lands. 🛬"
  end
end

# Swimming ability
module Swimmable
  def swim
    puts "#{self.class} #{@name} glides through the water! 🏊"
  end
  
  def dive
    puts "#{self.class} #{@name} dives deep underwater! 🤿"
  end
end

# Climbing ability
module Climbable
  def climb
    puts "#{self.class} #{@name} climbs up high! 🧗"
  end
  
  def swing
    puts "#{self.class} #{@name} swings from branch to branch! 🐒"
  end
end

# Hunting ability
module Huntable
  def hunt
    puts "#{self.class} #{@name} stalks its prey silently... 🐅"
  end
  
  def pounce
    puts "#{self.class} #{@name} pounces with lightning speed! ⚡"
  end
end

# Base animal class
class Animal
  attr_reader :name
  
  def initialize(name)
    @name = name
  end
  
  def eat
    puts "#{self.class} #{@name} is eating. 🍽️"
  end
  
  def sleep
    puts "#{self.class} #{@name} is sleeping peacefully. 😴"
  end
end

# Different animals with different abilities
class Eagle < Animal
  include Flyable
  include Huntable
end

class Dolphin < Animal
  include Swimmable
  include Huntable
end

class Monkey < Animal
  include Climbable
  include Swimmable  # Some monkeys can swim!
end

class Penguin < Animal
  include Swimmable
  include Flyable     # Penguins "fly" underwater!
  
  # Override flying for penguins
  def fly
    puts "#{self.class} #{@name} 'flies' underwater like a torpedo! 🐧"
  end
end

class Duck < Animal
  include Flyable
  include Swimmable
end

# Create a zoo!
puts "🎪 Welcome to Ruby Zoo!"
puts "=" * 30

eagle = Eagle.new("Eddie")
dolphin = Dolphin.new("Dolly")
monkey = Monkey.new("Max")
penguin = Penguin.new("Penny")
duck = Duck.new("Daisy")

# Show off their abilities
eagle.fly
eagle.hunt

dolphin.swim
dolphin.dive

monkey.climb
monkey.swing

penguin.swim
penguin.fly  # Special penguin flying!

duck.fly
duck.swim
```

## Module Constants and Methods 📊

Modules can also hold constants and module methods:

```ruby
module Math
  PI = 3.14159
  E = 2.71828
  
  def self.circle_area(radius)
    PI * radius * radius
  end
  
  def self.circle_circumference(radius)
    2 * PI * radius
  end
  
  # Alternative syntax for module methods
  module_function
  
  def square_area(side)
    side * side
  end
  
  def rectangle_area(length, width)
    length * width
  end
end

# Use module constants and methods
puts Math::PI  # 3.14159

puts Math.circle_area(5)        # 78.53975
puts Math.square_area(4)        # 16
puts Math.rectangle_area(3, 7)  # 21
```

## Mixins - Multiple Modules 🎭

You can include multiple modules in one class - this is called a "mixin":

```ruby
module Readable
  def read
    puts "Reading some text... 📖"
  end
end

module Writable
  def write(text)
    puts "Writing: #{text} ✍️"
  end
end

module Executable
  def execute
    puts "Executing code... ⚡"
  end
end

class TextEditor
  include Readable
  include Writable
  include Executable
  
  def initialize(name)
    @name = name
  end
end

editor = TextEditor.new("VS Code")
editor.read
editor.write("Hello, World!")
editor.execute
```

## Module Callbacks 🪝

Modules can have special methods that get called automatically:

```ruby
module Trackable
  def self.included(base)
    puts "#{self} was included in #{base}!"
    base.extend(ClassMethods)
  end
  
  def self.extended(base)
    puts "#{self} was extended by #{base}!"
  end
  
  module ClassMethods
    def track_instances
      @instances ||= []
    end
    
    def new(*args)
      instance = super
      track_instances << instance
      instance
    end
    
    def instance_count
      track_instances.length
    end
  end
  
  def track_action(action)
    puts "#{self.class} performed: #{action}"
  end
end

class User
  include Trackable
  
  def initialize(name)
    @name = name
  end
  
  def login
    track_action("login")
  end
end

# The magic happens automatically!
user1 = User.new("Alice")  # "Trackable was included in User!"
user2 = User.new("Bob")

puts User.instance_count   # 2

user1.login               # "User performed: login"
```

## Practical Example: User Permissions 🔐

Let's build a user permission system using modules:

```ruby
# Permission modules
module CanRead
  def read_file(filename)
    puts "📖 Reading file: #{filename}"
  end
  
  def view_data
    puts "👀 Viewing data..."
  end
end

module CanWrite
  def write_file(filename, content)
    puts "✍️ Writing to file: #{filename}"
    puts "Content: #{content}"
  end
  
  def update_data(data)
    puts "📝 Updating data: #{data}"
  end
end

module CanDelete
  def delete_file(filename)
    puts "🗑️ Deleting file: #{filename}"
  end
  
  def remove_data(id)
    puts "❌ Removing data with ID: #{id}"
  end
end

module CanAdmin
  def manage_users
    puts "👥 Managing user accounts..."
  end
  
  def system_settings
    puts "⚙️ Accessing system settings..."
  end
end

# Base user class
class User
  attr_reader :name, :role
  
  def initialize(name, role)
    @name = name
    @role = role
  end
  
  def info
    puts "User: #{@name}, Role: #{@role}"
  end
end

# Different user types with different permissions
class Viewer < User
  include CanRead
  
  def initialize(name)
    super(name, "Viewer")
  end
end

class Editor < User
  include CanRead
  include CanWrite
  
  def initialize(name)
    super(name, "Editor")
  end
end

class Moderator < User
  include CanRead
  include CanWrite
  include CanDelete
  
  def initialize(name)
    super(name, "Moderator")
  end
end

class Administrator < User
  include CanRead
  include CanWrite
  include CanDelete
  include CanAdmin
  
  def initialize(name)
    super(name, "Administrator")
  end
end

# Test the permission system
puts "🏢 Company Permission System"
puts "=" * 35

alice = Viewer.new("Alice")
bob = Editor.new("Bob")
charlie = Moderator.new("Charlie")
diana = Administrator.new("Diana")

# Everyone can read
[alice, bob, charlie, diana].each { |user| user.read_file("report.txt") }

puts "\n--- Writing (Editors and above) ---"
[bob, charlie, diana].each { |user| user.write_file("notes.txt", "Important notes") }

puts "\n--- Deleting (Moderators and above) ---"
[charlie, diana].each { |user| user.delete_file("old_file.txt") }

puts "\n--- Admin tasks (Administrators only) ---"
diana.manage_users
diana.system_settings
```

## Module Best Practices 💡

1. **Use descriptive names** ending in `-able` for behavior modules (`Readable`, `Walkable`)
2. **Keep modules focused** - each should have a single responsibility
3. **Document what your modules do** and how to use them
4. **Prefer composition over complex inheritance hierarchies**
5. **Use namespaces** to organize related classes and modules
6. **Test module functionality** separately from the classes that use them

## Common Module Patterns 📋

### 1. Utility Modules
```ruby
module StringUtils
  def self.palindrome?(string)
    string.downcase == string.downcase.reverse
  end
  
  def self.word_count(string)
    string.split.length
  end
end

puts StringUtils.palindrome?("racecar")  # true
puts StringUtils.word_count("Hello world")  # 2
```

### 2. Configuration Modules
```ruby
module AppConfig
  DATABASE_URL = "localhost:5432"
  API_KEY = "secret123"
  DEBUG_MODE = true
  
  def self.environment
    DEBUG_MODE ? "development" : "production"
  end
end
```

### 3. Enumerable-like Modules
```ruby
module Listable
  def each
    @items.each { |item| yield(item) }
  end
  
  def map(&block)
    result = []
    each { |item| result << block.call(item) }
    result
  end
  
  def select(&block)
    result = []
    each { |item| result << item if block.call(item) }
    result
  end
end
```

## What's Next? 🚀

Fantastic! You've mastered modules - Ruby's flexible way of sharing code between classes. Modules give you the superpower to mix and match functionality exactly where you need it!

Next up, we'll dive into **File Operations** - learning how to read from and write to files, which is essential for building real applications! 📁

## Quick Reference 📋

```ruby
# Create a module
module ModuleName
  def method_name
    # code
  end
end

# Include as instance methods
class MyClass
  include ModuleName
end

# Extend as class methods
class MyClass
  extend ModuleName
end

# Prepend (higher priority)
class MyClass
  prepend ModuleName
end

# Namespace
module Namespace
  class MyClass
  end
end

# Access namespaced class
Namespace::MyClass.new

# Module methods
module Utils
  def self.helper_method
    # code
  end
end

Utils.helper_method
```

Remember: Modules are like toolboxes that any class can borrow from! 🧰✨

[← Previous: Inheritance](./14-inheritance.md) | [Next: File Operations →](../03-advanced/16-file-operations.md)
