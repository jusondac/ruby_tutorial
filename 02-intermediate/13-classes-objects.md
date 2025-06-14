# Chapter 13: Classes and Objects 🏗️

[← Previous: Blocks and Iterators](./12-blocks-iterators.md) | [Next: Inheritance →](./14-inheritance.md)

## What is Object-Oriented Programming? 🌟

Before we dive into classes and objects, let's understand the **big picture**! Object-Oriented Programming (OOP) is a way of thinking about and organizing code that mirrors how we think about the real world.

### The Real World is Full of Objects! 🌍

Look around you right now. Everything you see is an "object":
- 🚗 Your car has properties (color, model, fuel level) and behaviors (start, stop, accelerate)
- 📱 Your phone has properties (battery level, contacts) and behaviors (call, text, take photos)
- 🐕 Your pet has properties (name, age, breed) and behaviors (eat, sleep, play)

OOP lets us model these real-world things in our code!

### The Four Pillars of OOP 🏛️

#### 1. **Encapsulation** 📦
*"Keeping related things together"*

Just like a car's engine is encapsulated under the hood, we group related data and functions together. You don't need to know how the engine works internally - you just turn the key!

```ruby
# All dog-related data and behaviors are encapsulated in one place
class Dog
  def initialize(name)
    @name = name
    @hunger = 0  # Internal state - hidden from outside
  end
  
  def feed  # Public behavior - anyone can use this
    @hunger = 0
    puts "#{@name} is fed!"
  end
  
  private  # Internal method - only the dog itself can use this
  
  def digest_food
    # Complex internal process hidden from users
  end
end
```

#### 2. **Inheritance** 👨‍👩‍👧‍👦
*"Sharing characteristics from parent to child"*

Just like you inherit traits from your parents, classes can inherit from other classes!

```ruby
class Animal  # Parent class
  def breathe
    puts "Breathing..."
  end
end

class Dog < Animal  # Child class inherits from Animal
  def bark
    puts "Woof!"
  end
end

# Dogs can both breathe (inherited) and bark (their own)
buddy = Dog.new
buddy.breathe  # From Animal class
buddy.bark     # From Dog class
```

#### 3. **Polymorphism** 🎭
*"Same action, different ways"*

Different objects can respond to the same message in their own way. Like how different animals all "speak" but in different ways!

```ruby
class Dog
  def speak
    puts "Woof!"
  end
end

class Cat
  def speak
    puts "Meow!"
  end
end

class Duck
  def speak
    puts "Quack!"
  end
end

# Same method name, different behaviors
animals = [Dog.new, Cat.new, Duck.new]
animals.each { |animal| animal.speak }
# Output: Woof! Meow! Quack!
```

#### 4. **Abstraction** 🎨
*"Hiding complexity, showing simplicity"*

You can drive a car without knowing how the transmission works. Abstraction hides complex implementation details!

```ruby
class BankAccount
  def initialize(balance)
    @balance = balance
  end
  
  def withdraw(amount)
    # Simple interface for complex operation
    if valid_withdrawal?(amount)
      process_withdrawal(amount)
      update_records(amount)
      send_notification
      puts "Withdrew $#{amount}"
    else
      puts "Insufficient funds"
    end
  end
  
  private  # All the complex stuff is hidden
  
  def valid_withdrawal?(amount)
    # Complex validation logic
  end
  
  def process_withdrawal(amount)
    # Complex banking logic
  end
  
  # ... more complex internal methods
end

# Users only see the simple interface
account = BankAccount.new(1000)
account.withdraw(50)  # Simple to use, complex underneath
```

### Why Use OOP? 🤔

#### 1. **Organization** 📁
Instead of having hundreds of loose functions, everything is organized into logical groups (classes).

#### 2. **Reusability** ♻️
Write a class once, use it many times. Create many objects from the same blueprint!

#### 3. **Maintainability** 🔧
When you need to fix a bug or add a feature, you know exactly where to look.

#### 4. **Real-World Modeling** 🌍
Code structure matches how we think about the world, making it more intuitive.

#### 5. **Collaboration** 🤝
Teams can work on different classes without stepping on each other's toes.

### OOP vs Other Programming Styles 🥊

#### Procedural Programming (What we've been doing so far)
```ruby
# Everything is functions and variables
def calculate_area(length, width)
  length * width
end

def calculate_perimeter(length, width)
  2 * (length + width)
end

length = 10
width = 5
area = calculate_area(length, width)
```

#### Object-Oriented Programming
```ruby
# Everything is objects with data and behaviors
class Rectangle
  def initialize(length, width)
    @length = length
    @width = width
  end
  
  def area
    @length * @width
  end
  
  def perimeter
    2 * (@length + @width)
  end
end

rectangle = Rectangle.new(10, 5)
area = rectangle.area
```

### Ruby's OOP Philosophy 💎

Ruby takes OOP to the extreme - **EVERYTHING is an object**!

```ruby
# Even numbers are objects!
42.class           # Integer
42.methods.count   # Over 100 methods!

# Strings are objects!
"Hello".upcase     # "HELLO"
"Hello".length     # 5

# Arrays are objects!
[1, 2, 3].reverse  # [3, 2, 1]

# Even classes are objects!
String.class       # Class
Class.class        # Class
```

This means Ruby is **purely object-oriented** - there's no separation between "primitive types" and "objects" like in some other languages.

### Thinking in Objects 🧠

Before writing OOP code, ask yourself:

1. **What are the "things" (nouns) in my problem?**
   - These become your classes: User, Car, BankAccount, Game

2. **What properties do these things have?**
   - These become your instance variables: @name, @age, @balance

3. **What can these things do?**
   - These become your methods: drive, deposit, play

4. **How do these things interact?**
   - These become method calls between objects

### Example: Modeling a Library 📚

Let's think through a library system:

**Things (Classes):** Book, Author, Library, Member
**Properties:** title, pages, name, books, members
**Behaviors:** check_out, return_book, add_book, register_member

```ruby
class Book
  # Properties
  def initialize(title, author, pages)
    @title = title
    @author = author
    @pages = pages
    @checked_out = false
  end
  
  # Behaviors
  def check_out
    @checked_out = true
  end
  
  def return_book
    @checked_out = false
  end
  
  def available?
    !@checked_out
  end
end

class Library
  def initialize
    @books = []
    @members = []
  end
  
  def add_book(book)
    @books << book
  end
  
  def find_available_books
    @books.select { |book| book.available? }
  end
end
```

See how the code structure mirrors our real-world understanding? 🎯

## 🤔 What Are Classes and Objects?

Now that you understand OOP concepts, let's dive deeper into classes and objects specifically!

Imagine you have a blueprint for building houses. The blueprint shows where the rooms go, how big they should be, and what features each house should have. A **class** is like that blueprint, and an **object** is like an actual house built from that blueprint!

- 📋 **Class**: The blueprint or template
- 🏠 **Object**: The actual thing made from the blueprint

You can build many houses (objects) from the same blueprint (class), and each house can be different even though they follow the same basic plan!

## 🏠 Creating Your First Class

```ruby
class Dog
  # This method runs when a new dog is created
  def initialize(name, breed)
    @name = name    # @ means this belongs to THIS specific dog
    @breed = breed
    @energy = 100
  end
  
  # Methods that every dog can do
  def bark
    puts "#{@name} says: WOOF! WOOF!"
  end
  
  def sleep
    @energy = 100
    puts "#{@name} is sleeping... 😴 Energy restored!"
  end
  
  def play
    if @energy > 20
      @energy -= 20
      puts "#{@name} is playing! 🎾 Energy: #{@energy}"
    else
      puts "#{@name} is too tired to play!"
    end
  end
  
  def info
    puts "Name: #{@name}, Breed: #{@breed}, Energy: #{@energy}"
  end
end

# Creating objects (instances) from the class
buddy = Dog.new("Buddy", "Golden Retriever")
max = Dog.new("Max", "German Shepherd")

# Each dog is different!
buddy.bark    # Buddy says: WOOF! WOOF!
max.bark      # Max says: WOOF! WOOF!

buddy.play    # Buddy is playing! 🎾 Energy: 80
buddy.play    # Buddy is playing! 🎾 Energy: 60
max.info      # Name: Max, Breed: German Shepherd, Energy: 100
```

## 🎯 Instance Variables (@variables)

Instance variables start with `@` and belong to a specific object:

```ruby
class Robot
  def initialize(name, color)
    @name = name        # This robot's name
    @color = color      # This robot's color
    @battery = 100      # This robot's battery level
    @tasks = []         # This robot's task list
  end
  
  def introduce
    puts "Hi! I'm #{@name}, a #{@color} robot!"
  end
  
  def add_task(task)
    @tasks << task
    puts "#{@name} added task: #{task}"
  end
  
  def do_task
    if @tasks.empty?
      puts "#{@name} has no tasks to do!"
    elsif @battery < 10
      puts "#{@name}'s battery is too low!"
    else
      current_task = @tasks.shift  # Remove first task
      @battery -= 10
      puts "#{@name} completed: #{current_task} (Battery: #{@battery}%)"
    end
  end
  
  def recharge
    @battery = 100
    puts "#{@name} is fully charged! ⚡"
  end
  
  def status
    puts "Robot: #{@name} (#{@color})"
    puts "Battery: #{@battery}%"
    puts "Tasks: #{@tasks.join(', ')}"
  end
end

# Create different robots
helper = Robot.new("Helper", "blue")
worker = Robot.new("Worker", "red")

helper.add_task("Clean kitchen")
helper.add_task("Water plants")
worker.add_task("Build website")

helper.do_task   # Helper completed: Clean kitchen (Battery: 90%)
worker.do_task   # Worker completed: Build website (Battery: 90%)

helper.status
worker.status
```

## 🔧 Getters and Setters (attr_accessor)

Sometimes you want to access or change instance variables from outside the class:

```ruby
class Person
  # The long way to create getters and setters
  def initialize(name, age)
    @name = name
    @age = age
  end
  
  # Getter method
  def name
    @name
  end
  
  # Setter method
  def name=(new_name)
    @name = new_name
  end
  
  # Getter method
  def age
    @age
  end
  
  # Setter method
  def age=(new_age)
    if new_age >= 0
      @age = new_age
    else
      puts "Age can't be negative!"
    end
  end
end

# Ruby has shortcuts for this!
class Student
  attr_reader :student_id     # Only getter (read-only)
  attr_writer :password      # Only setter (write-only)
  attr_accessor :name, :grade # Both getter and setter
  
  def initialize(name, student_id)
    @name = name
    @student_id = student_id
    @grade = "A"
  end
  
  def study(subject)
    puts "#{@name} is studying #{subject}"
  end
end

student = Student.new("Alice", "12345")
puts student.name        # Alice (getter)
puts student.student_id  # 12345 (getter)

student.name = "Alice Smith"  # Setter
student.grade = "A+"          # Setter

puts student.name        # Alice Smith
# puts student.password  # Error! No getter for password
```

## 🎪 Class Methods vs Instance Methods

```ruby
class Calculator
  # Class method - belongs to the Calculator class itself
  def self.about
    puts "I'm the Calculator class! I make math easy!"
  end
  
  # Another class method
  def self.version
    "1.0.0"
  end
  
  # Instance methods - belong to each calculator object
  def initialize
    @memory = 0
  end
  
  def add(number)
    @memory += number
    puts "Added #{number}. Total: #{@memory}"
  end
  
  def clear
    @memory = 0
    puts "Memory cleared!"
  end
  
  def result
    @memory
  end
end

# Call class methods on the class itself
Calculator.about    # I'm the Calculator class! I make math easy!
puts Calculator.version  # 1.0.0

# Create objects and call instance methods
calc1 = Calculator.new
calc2 = Calculator.new

calc1.add(10)  # Added 10. Total: 10
calc1.add(5)   # Added 5. Total: 15

calc2.add(100) # Added 100. Total: 100

puts calc1.result  # 15
puts calc2.result  # 100 (each calculator has its own memory!)
```

## 🎮 Building a Game Character Class

```ruby
class GameCharacter
  attr_reader :name, :level, :health, :max_health
  attr_accessor :x_position, :y_position
  
  def initialize(name, character_class = "Warrior")
    @name = name
    @character_class = character_class
    @level = 1
    @max_health = 100
    @health = @max_health
    @experience = 0
    @x_position = 0
    @y_position = 0
    @inventory = []
  end
  
  def take_damage(damage)
    @health -= damage
    @health = 0 if @health < 0
    
    puts "#{@name} takes #{damage} damage! Health: #{@health}/#{@max_health}"
    
    if @health == 0
      puts "💀 #{@name} has been defeated!"
    end
  end
  
  def heal(amount)
    old_health = @health
    @health += amount
    @health = @max_health if @health > @max_health
    
    healed = @health - old_health
    puts "#{@name} heals for #{healed} health! Health: #{@health}/#{@max_health}"
  end
  
  def gain_experience(exp)
    @experience += exp
    puts "#{@name} gains #{exp} experience!"
    
    # Check for level up
    if @experience >= @level * 100
      level_up!
    end
  end
  
  def level_up!
    @level += 1
    @experience = 0
    old_max_health = @max_health
    @max_health += 20
    @health = @max_health  # Full heal on level up
    
    puts "🎉 #{@name} reached level #{@level}!"
    puts "Max health increased from #{old_max_health} to #{@max_health}"
  end
  
  def move(x, y)
    @x_position = x
    @y_position = y
    puts "#{@name} moved to position (#{x}, #{y})"
  end
  
  def add_item(item)
    @inventory << item
    puts "#{@name} found: #{item}"
  end
  
  def use_item(item)
    if @inventory.include?(item)
      @inventory.delete(item)
      case item
      when "Health Potion"
        heal(50)
      when "Energy Drink"
        puts "#{@name} feels energized!"
      else
        puts "#{@name} used #{item}"
      end
    else
      puts "#{@name} doesn't have #{item}!"
    end
  end
  
  def status
    puts "\n" + "=" * 30
    puts "🗡️  #{@name} the #{@character_class}"
    puts "Level: #{@level}"
    puts "Health: #{@health}/#{@max_health}"
    puts "Experience: #{@experience}/#{@level * 100}"
    puts "Position: (#{@x_position}, #{@y_position})"
    puts "Inventory: #{@inventory.join(', ')}"
    puts "=" * 30
  end
  
  def alive?
    @health > 0
  end
end

# Create a character and play with it!
hero = GameCharacter.new("Aragorn", "Ranger")

hero.move(10, 5)
hero.add_item("Health Potion")
hero.add_item("Magic Sword")
hero.take_damage(30)
hero.use_item("Health Potion")
hero.gain_experience(150)  # Should level up!
hero.status
```

## 🏭 Class Variables (@@variables)

Class variables are shared among ALL objects of the same class:

```ruby
class BankAccount
  @@total_accounts = 0      # Shared by ALL bank accounts
  @@bank_name = "Ruby Bank"
  
  attr_reader :account_number, :balance
  
  def initialize(owner_name, initial_deposit = 0)
    @@total_accounts += 1  # Increment the shared counter
    @account_number = @@total_accounts
    @owner_name = owner_name
    @balance = initial_deposit
    
    puts "✅ Account ##{@account_number} created for #{@owner_name}"
  end
  
  def deposit(amount)
    @balance += amount
    puts "Deposited $#{amount}. New balance: $#{@balance}"
  end
  
  def withdraw(amount)
    if amount <= @balance
      @balance -= amount
      puts "Withdrew $#{amount}. New balance: $#{@balance}"
    else
      puts "Insufficient funds!"
    end
  end
  
  def self.total_accounts
    @@total_accounts
  end
  
  def self.bank_name
    @@bank_name
  end
  
  def account_info
    puts "#{@@bank_name} - Account ##{@account_number}"
    puts "Owner: #{@owner_name}"
    puts "Balance: $#{@balance}"
  end
end

# Create multiple accounts
alice_account = BankAccount.new("Alice", 1000)
bob_account = BankAccount.new("Bob", 500)
charlie_account = BankAccount.new("Charlie", 750)

puts "Total accounts: #{BankAccount.total_accounts}"  # 3
puts "Bank name: #{BankAccount.bank_name}"

alice_account.deposit(100)
bob_account.withdraw(50)

alice_account.account_info
```

## 🎨 Constants

Constants are values that don't change:

```ruby
class Circle
  PI = 3.14159  # Constant - should not change
  
  attr_reader :radius
  
  def initialize(radius)
    @radius = radius
  end
  
  def area
    PI * @radius * @radius
  end
  
  def circumference
    2 * PI * @radius
  end
  
  def diameter
    @radius * 2
  end
end

circle = Circle.new(5)
puts "Area: #{circle.area}"
puts "Circumference: #{circle.circumference}"
puts "PI constant: #{Circle::PI}"  # Access constant with ::
```

## 🎯 Practical Example: Todo List

```ruby
class TodoList
  attr_reader :name
  
  def initialize(name)
    @name = name
    @tasks = []
    @next_id = 1
  end
  
  def add_task(description, priority = "normal")
    task = {
      id: @next_id,
      description: description,
      priority: priority,
      completed: false,
      created_at: Time.now
    }
    
    @tasks << task
    @next_id += 1
    
    puts "✅ Added: #{description}"
    task[:id]
  end
  
  def complete_task(id)
    task = find_task(id)
    if task
      task[:completed] = true
      puts "🎉 Completed: #{task[:description]}"
    else
      puts "❌ Task #{id} not found"
    end
  end
  
  def delete_task(id)
    task = find_task(id)
    if task
      @tasks.delete(task)
      puts "🗑️ Deleted: #{task[:description]}"
    else
      puts "❌ Task #{id} not found"
    end
  end
  
  def list_tasks(filter = "all")
    puts "\n📋 #{@name}'s Todo List"
    puts "-" * 30
    
    filtered_tasks = case filter
                     when "completed"
                       @tasks.select { |task| task[:completed] }
                     when "pending"
                       @tasks.select { |task| !task[:completed] }
                     else
                       @tasks
                     end
    
    if filtered_tasks.empty?
      puts "No tasks!"
    else
      filtered_tasks.each do |task|
        status = task[:completed] ? "✅" : "⏳"
        priority_icon = case task[:priority]
                        when "high" then "🔥"
                        when "low" then "🟢"
                        else "🟡"
                        end
        
        puts "#{status} #{task[:id]}. #{task[:description]} #{priority_icon}"
      end
    end
    
    puts "-" * 30
  end
  
  def stats
    total = @tasks.length
    completed = @tasks.count { |task| task[:completed] }
    pending = total - completed
    
    puts "\n📊 Statistics:"
    puts "Total tasks: #{total}"
    puts "Completed: #{completed}"
    puts "Pending: #{pending}"
    puts "Completion rate: #{total > 0 ? (completed * 100 / total) : 0}%"
  end
  
  private  # Methods below this are private (only usable inside the class)
  
  def find_task(id)
    @tasks.find { |task| task[:id] == id }
  end
end

# Create and use a todo list
my_list = TodoList.new("Work Projects")

task1 = my_list.add_task("Learn Ruby", "high")
task2 = my_list.add_task("Build a website", "normal")
task3 = my_list.add_task("Write documentation", "low")

my_list.list_tasks

my_list.complete_task(task1)
my_list.list_tasks("pending")

my_list.stats
```

## 🎉 Classes and Objects Mastery!

You now understand:
- ✅ How to create classes as blueprints for objects
- ✅ Using `initialize` to set up new objects
- ✅ Instance variables (@) that belong to specific objects
- ✅ Class variables (@@) shared by all objects
- ✅ Creating getters and setters with attr_accessor
- ✅ Class methods vs instance methods
- ✅ Constants that don't change
- ✅ Private methods that are only usable inside the class

Classes and objects are the foundation of object-oriented programming!

---

## 🚀 What's Next?

Now let's learn about inheritance - how classes can share and extend each other's abilities!

**[← Previous: Blocks and Iterators](./12-blocks-iterators.md)** | **[Next: Inheritance - Family Trees →](./14-inheritance.md)**

---

### 🎯 Class and Object Challenges

Try building these:
1. **Library System**: Books, members, checkouts
2. **Pet Store**: Different animals with shared and unique behaviors
3. **RPG Character Creator**: Warriors, mages, rogues with different stats
4. **Bank Account System**: Checking, savings, credit accounts

Classes help you organize code and model real-world things! 🏗️✨
