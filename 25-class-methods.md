# Chapter 25: Class Methods and Variables 🏛️

## 🤔 What Are Class Methods and Variables?

Imagine you have a school with many classrooms. Each classroom (instance) has its own students, desks, and decorations. But there are also things that belong to the whole school - like the school name, total number of students, and the principal's office.

In Ruby:
- 🏫 **Class methods and variables**: Belong to the entire class (the whole school)
- 🏫 **Instance methods and variables**: Belong to each individual object (each classroom)

## 🏛️ Class Methods - Methods That Belong to the Class

Class methods are called on the class itself, not on instances:

```ruby
class Robot
  # Class method - belongs to the Robot class
  def self.manufacturer
    "RoboCorp Industries"
  end
  
  # Another class method
  def self.models_available
    ["Helper-3000", "Worker-Pro", "Guard-Bot", "Cleaner-X"]
  end
  
  # Class method with parameters
  def self.create_random
    names = ["Beep", "Boop", "Whirr", "Buzz"]
    colors = ["red", "blue", "silver", "gold"]
    
    Robot.new(names.sample, colors.sample)
  end
  
  # Instance method - belongs to each robot object
  def initialize(name, color)
    @name = name
    @color = color
  end
  
  def introduce
    puts "Hi! I'm #{@name}, a #{@color} robot made by #{Robot.manufacturer}!"
  end
end

# Call class methods on the class itself
puts Robot.manufacturer         # "RoboCorp Industries"
puts Robot.models_available.inspect  # ["Helper-3000", "Worker-Pro", ...]

# Create instances and call instance methods
robot1 = Robot.new("R2D2", "blue")
robot2 = Robot.create_random    # Uses class method to create instance

robot1.introduce                # Uses instance method
robot2.introduce                # Uses instance method
```

## 📊 Class Variables (@@variables)

Class variables are shared by ALL instances of a class:

```ruby
class BankAccount
  @@total_accounts = 0       # Class variable - shared by all accounts
  @@bank_name = "Ruby Bank"  # Class variable - shared by all accounts
  @@interest_rate = 0.02     # Class variable - shared by all accounts
  
  def initialize(owner, initial_deposit = 0)
    @owner = owner           # Instance variable - unique to each account
    @balance = initial_deposit
    @account_number = generate_account_number
    
    @@total_accounts += 1    # Increment the shared counter
    
    puts "✅ Account #{@account_number} created for #{@owner}"
  end
  
  def deposit(amount)
    @balance += amount
    puts "Deposited $#{amount}. New balance: $#{@balance}"
  end
  
  def apply_interest
    interest = @balance * @@interest_rate
    @balance += interest
    puts "Interest applied: $#{interest.round(2)}. New balance: $#{@balance.round(2)}"
  end
  
  # Class methods to access class variables
  def self.total_accounts
    @@total_accounts
  end
  
  def self.bank_name
    @@bank_name
  end
  
  def self.set_interest_rate(rate)
    @@interest_rate = rate
    puts "Interest rate changed to #{(rate * 100).round(2)}%"
  end
  
  def self.bank_info
    puts "🏦 #{@@bank_name}"
    puts "Total accounts: #{@@total_accounts}"
    puts "Interest rate: #{(@@interest_rate * 100).round(2)}%"
  end
  
  def account_info
    puts "Account: #{@account_number}"
    puts "Owner: #{@owner}"
    puts "Balance: $#{@balance.round(2)}"
    puts "Bank: #{@@bank_name}"
  end
  
  private
  
  def generate_account_number
    "#{@@bank_name[0..2].upcase}#{@@total_accounts + 1}".gsub(" ", "")
  end
end

# Create accounts and see shared data
alice = BankAccount.new("Alice", 1000)
bob = BankAccount.new("Bob", 500)
charlie = BankAccount.new("Charlie", 750)

# Class methods show shared information
BankAccount.bank_info

# Change interest rate for ALL accounts
BankAccount.set_interest_rate(0.03)

# All accounts use the new rate
alice.apply_interest
bob.apply_interest
charlie.apply_interest

puts "\nFinal bank status:"
BankAccount.bank_info
```

## 🎮 Game Example: Player Statistics

```ruby
class Player
  @@total_players = 0
  @@total_score = 0
  @@high_score = 0
  @@high_score_holder = nil
  @@game_name = "Ruby Quest"
  
  attr_reader :name, :score, :level
  
  def initialize(name)
    @name = name
    @score = 0
    @level = 1
    @experience = 0
    
    @@total_players += 1
    
    puts "🎮 #{@name} joined #{@@game_name}! (Player ##{@@total_players})"
  end
  
  def gain_score(points)
    @score += points
    @@total_score += points
    
    puts "#{@name} gained #{points} points! Total score: #{@score}"
    
    # Check for new high score
    if @score > @@high_score
      @@high_score = @score
      @@high_score_holder = @name
      puts "🎉 NEW HIGH SCORE! #{@name} now holds the record with #{@score} points!"
    end
  end
  
  def gain_experience(exp)
    @experience += exp
    
    # Level up every 100 experience points
    if @experience >= @level * 100
      @level += 1
      @experience = 0
      puts "⭐ #{@name} leveled up! Now level #{@level}!"
    end
  end
  
  # Class methods for game statistics
  def self.game_stats
    puts "\n🎮 #{@@game_name} Statistics:"
    puts "=" * 30
    puts "Total players: #{@@total_players}"
    puts "Total points scored: #{@@total_score}"
    puts "Average score: #{@@total_players > 0 ? (@@total_score / @@total_players).round(1) : 0}"
    puts "High score: #{@@high_score} (#{@@high_score_holder || 'None'})"
  end
  
  def self.leaderboard(players)
    puts "\n🏆 Leaderboard:"
    puts "=" * 20
    sorted_players = players.sort_by { |player| -player.score }  # Sort by score (descending)
    
    sorted_players.each_with_index do |player, index|
      medal = case index
              when 0 then "🥇"
              when 1 then "🥈"
              when 2 then "🥉"
              else "  "
              end
      
      puts "#{medal} #{index + 1}. #{player.name} - #{player.score} points (Level #{player.level})"
    end
  end
  
  def self.reset_game
    @@total_players = 0
    @@total_score = 0
    @@high_score = 0
    @@high_score_holder = nil
    puts "🔄 Game statistics reset!"
  end
  
  def self.change_game_name(new_name)
    old_name = @@game_name
    @@game_name = new_name
    puts "📝 Game renamed from '#{old_name}' to '#{@@game_name}'"
  end
end

# Create players and simulate gameplay
alice = Player.new("Alice")
bob = Player.new("Bob")
charlie = Player.new("Charlie")

# Players gain scores and experience
alice.gain_score(150)
alice.gain_experience(80)

bob.gain_score(200)
bob.gain_experience(120)

charlie.gain_score(175)
charlie.gain_experience(95)

alice.gain_score(100)  # Alice gets more points
alice.gain_experience(50)  # Should level up!

# Show game statistics
Player.game_stats
Player.leaderboard([alice, bob, charlie])
```

## 🏭 Factory Pattern with Class Methods

Create a factory that makes different types of objects:

```ruby
class Vehicle
  @@vehicle_count = 0
  @@vehicles_created = []
  
  attr_reader :type, :brand, :model, :year, :vehicle_id
  
  def initialize(type, brand, model, year)
    @type = type
    @brand = brand
    @model = model
    @year = year
    
    @@vehicle_count += 1
    @vehicle_id = @@vehicle_count
    @@vehicles_created << self
    
    puts "🚗 Created #{@type}: #{@year} #{@brand} #{@model} (ID: #{@vehicle_id})"
  end
  
  # Factory methods - different ways to create vehicles
  def self.create_car(brand, model, year = 2024)
    new("Car", brand, model, year)
  end
  
  def self.create_truck(brand, model, year = 2024)
    new("Truck", brand, model, year)
  end
  
  def self.create_motorcycle(brand, model, year = 2024)
    new("Motorcycle", brand, model, year)
  end
  
  def self.create_random
    types = ["Car", "Truck", "Motorcycle"]
    brands = ["Toyota", "Ford", "Honda", "BMW", "Mercedes"]
    models = ["Model-A", "Model-B", "Model-C"]
    
    new(types.sample, brands.sample, models.sample, rand(2015..2024))
  end
  
  # Class methods for fleet management
  def self.fleet_summary
    puts "\n🚛 Fleet Summary:"
    puts "Total vehicles: #{@@vehicle_count}"
    
    # Group by type
    types = @@vehicles_created.group_by(&:type)
    types.each do |type, vehicles|
      puts "#{type}s: #{vehicles.length}"
    end
  end
  
  def self.find_by_brand(brand)
    @@vehicles_created.select { |vehicle| vehicle.brand == brand }
  end
  
  def self.vehicles_by_year(year)
    @@vehicles_created.select { |vehicle| vehicle.year == year }
  end
  
  def self.newest_vehicles(count = 5)
    @@vehicles_created.last(count)
  end
  
  def info
    puts "#{@type}: #{@year} #{@brand} #{@model} (ID: #{@vehicle_id})"
  end
end

# Use factory methods to create vehicles
car1 = Vehicle.create_car("Toyota", "Camry", 2023)
car2 = Vehicle.create_car("Honda", "Civic")
truck1 = Vehicle.create_truck("Ford", "F-150", 2022)
bike1 = Vehicle.create_motorcycle("BMW", "R1250GS")

# Create some random vehicles
3.times { Vehicle.create_random }

# Use class methods to analyze the fleet
Vehicle.fleet_summary

puts "\nToyota vehicles:"
Vehicle.find_by_brand("Toyota").each(&:info)

puts "\n2023 vehicles:"
Vehicle.vehicles_by_year(2023).each(&:info)
```

## 🎯 Singleton Pattern with Class Methods

Sometimes you want only ONE instance of a class to exist:

```ruby
class GameConfig
  @@instance = nil
  @@settings = {
    volume: 50,
    difficulty: "normal",
    graphics: "medium",
    player_name: "Player1"
  }
  
  private_class_method :new  # Prevent direct instantiation
  
  def self.instance
    @@instance ||= new  # Create only if it doesn't exist
  end
  
  def self.get_setting(key)
    @@settings[key]
  end
  
  def self.set_setting(key, value)
    old_value = @@settings[key]
    @@settings[key] = value
    puts "🔧 Setting '#{key}' changed from '#{old_value}' to '#{value}'"
  end
  
  def self.all_settings
    @@settings
  end
  
  def self.reset_to_defaults
    @@settings = {
      volume: 50,
      difficulty: "normal", 
      graphics: "medium",
      player_name: "Player1"
    }
    puts "🔄 Settings reset to defaults"
  end
  
  def self.save_settings
    puts "💾 Settings saved:"
    @@settings.each { |key, value| puts "  #{key}: #{value}" }
  end
end

# Usage - no need to create instances!
puts "Volume: #{GameConfig.get_setting(:volume)}"

GameConfig.set_setting(:volume, 75)
GameConfig.set_setting(:difficulty, "hard")
GameConfig.set_setting(:player_name, "RubyMaster")

GameConfig.save_settings

# This won't work - constructor is private!
# config = GameConfig.new  # Error!
```

## 🧮 Math Utilities with Class Methods

```ruby
class MathUtils
  @@calculation_count = 0
  
  # Mathematical constants
  PI = 3.14159265359
  E = 2.71828182846
  
  def self.factorial(n)
    @@calculation_count += 1
    return 1 if n <= 1
    n * factorial(n - 1)
  end
  
  def self.fibonacci(n)
    @@calculation_count += 1
    return n if n <= 1
    fibonacci(n - 1) + fibonacci(n - 2)
  end
  
  def self.circle_area(radius)
    @@calculation_count += 1
    PI * radius * radius
  end
  
  def self.distance(x1, y1, x2, y2)
    @@calculation_count += 1
    Math.sqrt((x2 - x1)**2 + (y2 - y1)**2)
  end
  
  def self.is_prime?(n)
    @@calculation_count += 1
    return false if n < 2
    (2..Math.sqrt(n)).none? { |i| n % i == 0 }
  end
  
  def self.calculation_stats
    puts "🧮 MathUtils Statistics:"
    puts "Total calculations performed: #{@@calculation_count}"
  end
  
  def self.reset_stats
    @@calculation_count = 0
    puts "📊 Calculation statistics reset"
  end
end

# Use the math utilities
puts "5! = #{MathUtils.factorial(5)}"
puts "10th Fibonacci: #{MathUtils.fibonacci(10)}"
puts "Circle area (r=5): #{MathUtils.circle_area(5).round(2)}"
puts "Distance from (0,0) to (3,4): #{MathUtils.distance(0, 0, 3, 4)}"
puts "Is 17 prime? #{MathUtils.is_prime?(17)}"

MathUtils.calculation_stats
```

## ⚠️ Class Variables vs Class Instance Variables

There's a subtle difference between class variables (@@) and class instance variables (@):

```ruby
class Example
  @@class_variable = "shared by all"     # Class variable
  @class_instance_variable = "belongs to this class only"  # Class instance variable
  
  def self.show_class_instance_var
    @class_instance_variable
  end
  
  def self.show_class_var
    @@class_variable
  end
  
  def show_class_var_from_instance
    @@class_variable  # Instance can access class variables
  end
end

class SubExample < Example
  @@class_variable = "changed by subclass"  # This affects the parent too!
  @class_instance_variable = "subclass only"  # This doesn't affect parent
end

puts Example.show_class_var          # "changed by subclass" (shared!)
puts Example.show_class_instance_var # "belongs to this class only"
puts SubExample.show_class_instance_var # "subclass only"
```

**Recommendation:** Use class instance variables (@) instead of class variables (@@) to avoid inheritance issues!

## 🎉 Class Methods and Variables Mastery!

You now understand:
- ✅ Creating class methods with `self.method_name`
- ✅ Using class variables (@@) for shared data
- ✅ Building factory methods to create objects
- ✅ Implementing singleton patterns
- ✅ Creating utility classes with class methods
- ✅ Managing application-wide configuration
- ✅ Understanding the difference between class variables and class instance variables

Class methods and variables help you organize functionality at the class level!

---

## 🚀 What's Next?

Let's explore monkey patching - Ruby's ability to modify existing classes!

**[← Previous: method_missing](./24-method-missing.md)** | **[Next: Monkey Patching →](./26-monkey-patching.md)**

---

### 🎯 Class Methods and Variables Challenges

Try building:
1. **ID Generator**: Create unique IDs across all instances of a class
2. **Logger System**: Track all messages from all objects
3. **Game Statistics**: Track scores, levels, achievements across all players
4. **Configuration Manager**: Manage app settings with class methods

Class-level programming helps you coordinate behavior across all instances! 🏛️✨
