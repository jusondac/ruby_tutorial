# Chapter 14: Inheritance - Family Trees 🌳

[← Previous: Classes and Objects](./13-classes-objects.md) | [Next: Modules →](./15-modules.md)

## What is Inheritance? 👨‍👩‍👧‍👦

Imagine you're part of a family. You might have your dad's eyes, your mom's smile, and your grandpa's sense of humor. In programming, inheritance works the same way - classes can inherit features from other classes!

Think of inheritance like a family tree where children get traits from their parents, but they can also have their own unique features. It's Ruby's way of saying "Hey, this new class is like that other class, but with some extra cool stuff!" 🎁

## The Parent and Child Relationship 👶

In Ruby, we call the original class the **parent class** (or superclass), and the new class that inherits from it is called the **child class** (or subclass).

### Basic Inheritance Example

```ruby
# Parent class (superclass)
class Animal
  def initialize(name)
    @name = name
  end
  
  def speak
    puts "#{@name} makes a sound"
  end
  
  def sleep
    puts "#{@name} is sleeping... 😴"
  end
end

# Child class (subclass)
class Dog < Animal  # The < symbol means "inherits from"
  def speak  # Override the parent's speak method
    puts "#{@name} says Woof! 🐕"
  end
  
  def fetch
    puts "#{@name} fetches the ball! 🎾"
  end
end

# Another child class
class Cat < Animal
  def speak
    puts "#{@name} says Meow! 🐱"
  end
  
  def climb_tree
    puts "#{@name} climbs up the tree! 🌳"
  end
end
```

Let's see inheritance in action:

```ruby
# Create animals
buddy = Dog.new("Buddy")
whiskers = Cat.new("Whiskers")

# They inherit methods from Animal
buddy.sleep      # "Buddy is sleeping... 😴"
whiskers.sleep   # "Whiskers is sleeping... 😴"

# They have their own versions of speak
buddy.speak      # "Buddy says Woof! 🐕"
whiskers.speak   # "Whiskers says Meow! 🐱"

# They have their own unique methods
buddy.fetch          # "Buddy fetches the ball! 🎾"
whiskers.climb_tree  # "Whiskers climbs up the tree! 🌳"
```

## Using `super` - Calling the Parent 📞

Sometimes you want to use the parent's method but add your own twist. That's where `super` comes in - it's like calling your parent for help!

```ruby
class Vehicle
  def initialize(brand, model)
    @brand = brand
    @model = model
    @engine_started = false
  end
  
  def start_engine
    @engine_started = true
    puts "🔧 Engine started!"
  end
  
  def info
    puts "#{@brand} #{@model}"
  end
end

class Car < Vehicle
  def initialize(brand, model, doors)
    super(brand, model)  # Call parent's initialize
    @doors = doors       # Add our own stuff
  end
  
  def start_engine
    super  # Call parent's start_engine first
    puts "🚗 Car is ready to drive!"
  end
  
  def info
    super  # Call parent's info first
    puts "Doors: #{@doors}"
  end
end

# Try it out!
my_car = Car.new("Toyota", "Camry", 4)

my_car.start_engine
# Output:
# 🔧 Engine started!
# 🚗 Car is ready to drive!

my_car.info
# Output:
# Toyota Camry
# Doors: 4
```

## Multiple Levels of Inheritance 🏗️

You can have inheritance chains - like great-grandparents, grandparents, parents, and children!

```ruby
# Level 1: The root
class LivingThing
  def initialize(name)
    @name = name
  end
  
  def breathe
    puts "#{@name} is breathing... 💨"
  end
end

# Level 2: Animals inherit from LivingThing
class Animal < LivingThing
  def move
    puts "#{@name} is moving around 🚶"
  end
end

# Level 3: Mammals inherit from Animal
class Mammal < Animal
  def feed_milk
    puts "#{@name} feeds milk to babies 🍼"
  end
end

# Level 4: Dogs inherit from Mammal
class Dog < Mammal
  def bark
    puts "#{@name} barks: Woof! 🐕"
  end
end

# Create a dog and see all inherited abilities
buddy = Dog.new("Buddy")

buddy.breathe     # From LivingThing
buddy.move        # From Animal  
buddy.feed_milk   # From Mammal
buddy.bark        # From Dog itself
```

## Real-World Example: Game Characters 🎮

Let's create a role-playing game character system:

```ruby
# Base character class
class Character
  attr_reader :name, :health, :level
  
  def initialize(name)
    @name = name
    @health = 100
    @level = 1
    @experience = 0
  end
  
  def attack(target)
    damage = calculate_damage
    puts "#{@name} attacks #{target.name} for #{damage} damage! ⚔️"
    target.take_damage(damage)
  end
  
  def take_damage(damage)
    @health -= damage
    puts "#{@name} takes #{damage} damage! Health: #{@health} ❤️"
    
    if @health <= 0
      puts "#{@name} has been defeated! 💀"
    end
  end
  
  def heal(amount)
    @health += amount
    @health = [@health, 100].min  # Cap at 100
    puts "#{@name} heals for #{amount}! Health: #{@health} 💚"
  end
  
  def gain_experience(exp)
    @experience += exp
    puts "#{@name} gains #{exp} experience!"
    
    if @experience >= @level * 100
      level_up
    end
  end
  
  protected
  
  def calculate_damage
    rand(10..20)  # Random damage between 10-20
  end
  
  def level_up
    @level += 1
    @experience = 0
    @health = 100
    puts "🌟 #{@name} reached level #{@level}!"
  end
end

# Warrior class - good at physical combat
class Warrior < Character
  def initialize(name)
    super(name)
    @strength = 15
  end
  
  def power_attack(target)
    puts "#{@name} charges up for a POWER ATTACK! 💪"
    damage = calculate_damage * 2
    puts "#{@name} deals a devastating blow to #{target.name} for #{damage} damage!"
    target.take_damage(damage)
  end
  
  protected
  
  def calculate_damage
    super + @strength  # Warriors do more damage
  end
end

# Mage class - can cast spells
class Mage < Character
  def initialize(name)
    super(name)
    @mana = 50
    @magic_power = 12
  end
  
  def cast_fireball(target)
    if @mana >= 10
      @mana -= 10
      damage = @magic_power + rand(5..15)
      puts "#{@name} casts FIREBALL! 🔥 Mana: #{@mana}"
      puts "#{@name} blasts #{target.name} for #{damage} magical damage!"
      target.take_damage(damage)
    else
      puts "#{@name} doesn't have enough mana! 💙"
    end
  end
  
  def heal_spell(target = self)
    if @mana >= 5
      @mana -= 5
      heal_amount = rand(15..25)
      puts "#{@name} casts HEAL! ✨ Mana: #{@mana}"
      target.heal(heal_amount)
    else
      puts "#{@name} doesn't have enough mana! 💙"
    end
  end
  
  def meditate
    @mana += 20
    @mana = [@mana, 50].min  # Cap at 50
    puts "#{@name} meditates and recovers mana. Mana: #{@mana} 🧘"
  end
end

# Rogue class - fast and sneaky
class Rogue < Character
  def initialize(name)
    super(name)
    @agility = 18
  end
  
  def sneak_attack(target)
    if rand(1..10) > 3  # 70% chance to succeed
      damage = calculate_damage * 3
      puts "#{@name} sneaks behind #{target.name}! 🗡️"
      puts "CRITICAL HIT! #{damage} damage!"
      target.take_damage(damage)
    else
      puts "#{@name} tries to sneak but gets spotted! 👀"
      attack(target)  # Regular attack instead
    end
  end
  
  def dodge
    puts "#{@name} prepares to dodge the next attack! 🤸"
    @dodging = true
  end
  
  def take_damage(damage)
    if @dodging
      puts "#{@name} dodges the attack! No damage taken! 🌪️"
      @dodging = false
    else
      super(damage)
    end
  end
end
```

Let's see our characters in action:

```ruby
# Create different character types
hero = Warrior.new("Sir Braveheart")
wizard = Mage.new("Gandalf the Wise")
thief = Rogue.new("Shadow")

puts "🎮 Epic Battle Begins!"
puts "=" * 30

# Warrior power attack
hero.power_attack(wizard)

# Mage retaliates with fireball
wizard.cast_fireball(hero)

# Rogue tries sneak attack
thief.sneak_attack(wizard)

# Mage heals himself
wizard.heal_spell

# Everyone gains experience
[hero, wizard, thief].each { |char| char.gain_experience(150) }
```

## Checking Class Relationships 🔍

Ruby provides methods to check inheritance relationships:

```ruby
class Animal; end
class Dog < Animal; end
class Labrador < Dog; end

buddy = Labrador.new

# Check if an object is an instance of a class
puts buddy.is_a?(Labrador)  # true
puts buddy.is_a?(Dog)       # true (inheritance!)
puts buddy.is_a?(Animal)    # true (inheritance!)
puts buddy.is_a?(String)    # false

# Check the exact class
puts buddy.class            # Labrador

# Check the parent class
puts Labrador.superclass    # Dog
puts Dog.superclass         # Animal
puts Animal.superclass      # Object (everything inherits from Object!)

# Get all ancestors
puts Labrador.ancestors
# Output: [Labrador, Dog, Animal, Object, Kernel, BasicObject]
```

## Method Visibility in Inheritance 👁️

Methods can be public, private, or protected, and this affects inheritance:

```ruby
class Parent
  def public_method
    puts "Everyone can see this!"
  end
  
  protected
  
  def protected_method
    puts "Only family members can use this!"
  end
  
  private
  
  def private_method
    puts "Only I can use this!"
  end
end

class Child < Parent
  def test_access
    public_method     # ✅ Works
    protected_method  # ✅ Works (inherited)
    private_method    # ✅ Works (inherited)
  end
end

child = Child.new
child.public_method   # ✅ Works
child.test_access     # ✅ Works

# These would cause errors:
# child.protected_method  # ❌ Error
# child.private_method    # ❌ Error
```

## When to Use Inheritance 🤔

### Good Uses of Inheritance:
- When you have an "is-a" relationship (Dog is an Animal)
- When you want to share common behavior
- When you want to create variations of similar things

### When NOT to Use Inheritance:
- When you have a "has-a" relationship (Car has an Engine - use composition instead)
- When classes are completely different
- When you're just trying to reuse some methods (use modules instead)

## Common Inheritance Patterns 📋

### 1. Template Method Pattern
```ruby
class Report
  def generate
    gather_data
    format_data
    output_report
  end
  
  protected
  
  def gather_data
    # Default implementation
    puts "Gathering basic data..."
  end
  
  def format_data
    raise "Subclasses must implement format_data"
  end
  
  def output_report
    puts "Report generated!"
  end
end

class SalesReport < Report
  protected
  
  def format_data
    puts "Formatting sales data with charts and graphs"
  end
end
```

### 2. Extending Behavior
```ruby
class Logger
  def log(message)
    puts "[LOG] #{message}"
  end
end

class TimestampLogger < Logger
  def log(message)
    super("[#{Time.now}] #{message}")
  end
end

class FileLogger < TimestampLogger
  def initialize(filename)
    @file = File.open(filename, 'a')
  end
  
  def log(message)
    super  # Still print to console
    @file.puts(message)  # Also write to file
    @file.flush
  end
end
```

## Best Practices 💡

1. **Keep inheritance hierarchies shallow** - don't go too many levels deep
2. **Use `super` when you want to extend, not replace** parent behavior
3. **Make parent classes focused** - they should have a clear purpose
4. **Prefer composition over inheritance** when the relationship isn't clear
5. **Document your inheritance hierarchies** so others understand them

## Fun Challenges 🎮

### Challenge 1: Vehicle Hierarchy
Create a vehicle hierarchy with different types of vehicles and their specific behaviors.

### Challenge 2: Shape Calculator
Build a shape system where all shapes can calculate area and perimeter, but each does it differently.

### Challenge 3: Employee Management
Create an employee system with different types of workers (Manager, Developer, Designer) that inherit common employee features but have unique roles.

## What's Next? 🚀

Awesome! You've learned how to create family trees of classes and share behavior between them. Inheritance is a powerful tool for organizing your code and avoiding repetition!

Next up, we'll explore **Modules** - Ruby's way of sharing code between classes without inheritance. It's like having superpowers that any class can borrow! 🦸‍♂️

## Quick Reference 📋

```ruby
# Basic inheritance
class Child < Parent
  # Child inherits all Parent methods
end

# Override parent method
def method_name
  # Your implementation
end

# Call parent method
def method_name
  super  # Calls parent's method_name
  # Your additional code
end

# Check relationships
obj.is_a?(Class)        # Check if object is instance of class
obj.class               # Get exact class
Class.superclass        # Get parent class
Class.ancestors         # Get inheritance chain
```

Remember: Inheritance is like a family tree - children get their parents' traits but can also have their own special abilities! 👨‍👩‍👧‍👦✨

[← Previous: Classes and Objects](./13-classes-objects.md) | [Next: Modules →](./15-modules.md)
