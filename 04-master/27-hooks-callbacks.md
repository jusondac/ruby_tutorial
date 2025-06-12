# Chapter 27: Hooks and Callbacks 🪝

## 🤔 What Are Hooks and Callbacks?

Hooks and callbacks are like having invisible helpers that automatically do things when certain events happen! Think of them as "if this happens, then do that" instructions that Ruby follows automatically.

Imagine you have a smart home that:
- 🚪 Turns on lights when you enter a room (hook)
- 📱 Sends you a text when someone rings the doorbell (callback)
- 🌡️ Adjusts temperature when the weather changes (hook)

In Ruby, hooks and callbacks work the same way - they run code automatically when specific events occur!

## 🎣 Ruby's Built-in Hooks

Ruby has several built-in hooks that you can override to run your own code:

### Class and Module Hooks
```ruby
class SmartClass
  # This runs whenever someone inherits from this class
  def self.inherited(subclass)
    puts "🎉 #{subclass} just inherited from #{self}!"
    puts "Welcome to the family!"
  end
  
  # This runs when a module is included
  def self.included(base)
    puts "📦 #{self} was included in #{base}"
  end
  
  # This runs when a module is extended
  def self.extended(object)
    puts "🔧 #{self} was extended by #{object}"
  end
end

class ChildClass < SmartClass
  # The inherited hook runs automatically here!
end

# Output: 🎉 ChildClass just inherited from SmartClass!
#         Welcome to the family!
```

### Method Hooks
```ruby
class MethodTracker
  # This runs every time a method is added to the class
  def self.method_added(method_name)
    puts "➕ Method '#{method_name}' was added to #{self}"
  end
  
  # This runs when a method is removed
  def self.method_removed(method_name)
    puts "➖ Method '#{method_name}' was removed from #{self}"
  end
  
  # This runs when a method is undefined
  def self.method_undefined(method_name)
    puts "🚫 Method '#{method_name}' was undefined in #{self}"
  end
  
  def say_hello
    puts "Hello!"
  end
  
  def say_goodbye
    puts "Goodbye!"
  end
end

# Output: 
# ➕ Method 'say_hello' was added to MethodTracker
# ➕ Method 'say_goodbye' was added to MethodTracker
```

## 🔄 Creating Your Own Callbacks

You can create your own callback system for custom events:

```ruby
class EventEmitter
  def initialize
    @callbacks = {}
  end
  
  # Register a callback for an event
  def on(event, &callback)
    @callbacks[event] ||= []
    @callbacks[event] << callback
    puts "📋 Registered callback for '#{event}' event"
  end
  
  # Trigger all callbacks for an event
  def emit(event, *args)
    return unless @callbacks[event]
    
    puts "🚀 Emitting '#{event}' event"
    @callbacks[event].each do |callback|
      callback.call(*args)
    end
  end
  
  # Remove callbacks for an event
  def off(event)
    @callbacks.delete(event)
    puts "🗑️ Removed all callbacks for '#{event}' event"
  end
end

# Using the event system
emitter = EventEmitter.new

# Register callbacks
emitter.on(:user_login) do |username|
  puts "👋 Welcome back, #{username}!"
end

emitter.on(:user_login) do |username|
  puts "📊 Logging user activity for #{username}"
end

emitter.on(:user_logout) do |username|
  puts "👋 Goodbye, #{username}!"
end

# Trigger events
emitter.emit(:user_login, "Alice")
emitter.emit(:user_logout, "Alice")
```

## 🎮 Game Event System

```ruby
class GameCharacter
  attr_reader :name, :health, :level, :experience
  
  def initialize(name)
    @name = name
    @health = 100
    @level = 1
    @experience = 0
    @callbacks = {}
  end
  
  # Callback registration
  def on(event, &callback)
    @callbacks[event] ||= []
    @callbacks[event] << callback
  end
  
  # Trigger callbacks
  def trigger(event, *args)
    return unless @callbacks[event]
    @callbacks[event].each { |callback| callback.call(*args) }
  end
  
  def take_damage(amount)
    old_health = @health
    @health -= amount
    @health = 0 if @health < 0
    
    trigger(:damage_taken, amount, old_health, @health)
    
    if @health == 0
      trigger(:character_died, @name)
    elsif @health < 20
      trigger(:low_health, @health)
    end
  end
  
  def heal(amount)
    old_health = @health
    @health += amount
    @health = 100 if @health > 100
    
    trigger(:healed, amount, old_health, @health)
  end
  
  def gain_experience(amount)
    old_experience = @experience
    old_level = @level
    @experience += amount
    
    # Check for level up
    while @experience >= @level * 100
      @experience -= @level * 100
      @level += 1
    end
    
    trigger(:experience_gained, amount, old_experience, @experience)
    
    if @level > old_level
      trigger(:level_up, old_level, @level)
    end
  end
  
  def status
    puts "#{@name}: Level #{@level}, Health #{@health}, XP #{@experience}/#{@level * 100}"
  end
end

# Create character and set up callbacks
hero = GameCharacter.new("Aragorn")

# Set up event handlers
hero.on(:damage_taken) do |amount, old_hp, new_hp|
  puts "💥 #{hero.name} took #{amount} damage! (#{old_hp} → #{new_hp})"
end

hero.on(:low_health) do |current_health|
  puts "⚠️ WARNING: #{hero.name} has low health (#{current_health})!"
end

hero.on(:character_died) do |name|
  puts "💀 #{name} has fallen in battle!"
end

hero.on(:healed) do |amount, old_hp, new_hp|
  puts "💚 #{hero.name} healed for #{amount}! (#{old_hp} → #{new_hp})"
end

hero.on(:experience_gained) do |amount, old_xp, new_xp|
  puts "⭐ #{hero.name} gained #{amount} XP! (#{old_xp} → #{new_xp})"
end

hero.on(:level_up) do |old_level, new_level|
  puts "🎉 LEVEL UP! #{hero.name} reached level #{new_level}!"
end

# Simulate gameplay
hero.status
hero.take_damage(30)
hero.take_damage(50)
hero.heal(25)
hero.gain_experience(150)  # Should level up!
hero.take_damage(90)       # Should trigger low health and death
```

## 🏭 Observable Pattern with Hooks

```ruby
module Observable
  def self.included(base)
    base.extend(ClassMethods)
  end
  
  module ClassMethods
    def observable_attr(attr_name)
      # Create getter
      define_method(attr_name) do
        instance_variable_get("@#{attr_name}")
      end
      
      # Create setter with notification
      define_method("#{attr_name}=") do |new_value|
        old_value = instance_variable_get("@#{attr_name}")
        instance_variable_set("@#{attr_name}", new_value)
        
        # Notify observers
        notify_observers(attr_name, old_value, new_value)
      end
    end
  end
  
  def initialize
    super if defined?(super)
    @observers = {}
  end
  
  def add_observer(event, &callback)
    @observers[event] ||= []
    @observers[event] << callback
  end
  
  def notify_observers(event, *args)
    return unless @observers[event]
    @observers[event].each { |callback| callback.call(*args) }
  end
end

class BankAccount
  include Observable
  
  observable_attr :balance
  observable_attr :interest_rate
  
  def initialize(owner, initial_balance = 0)
    @owner = owner
    @balance = initial_balance
    @interest_rate = 0.02
    super()  # Call Observable's initialize
  end
  
  def deposit(amount)
    self.balance = @balance + amount
  end
  
  def withdraw(amount)
    if amount <= @balance
      self.balance = @balance - amount
    else
      puts "❌ Insufficient funds!"
    end
  end
end

# Create account and add observers
account = BankAccount.new("Alice", 1000)

# Add balance change observer
account.add_observer(:balance) do |old_balance, new_balance|
  change = new_balance - old_balance
  if change > 0
    puts "💰 Deposited $#{change}. New balance: $#{new_balance}"
  else
    puts "💸 Withdrew $#{-change}. New balance: $#{new_balance}"
  end
  
  # Check for low balance
  if new_balance < 100
    puts "⚠️ Low balance warning!"
  end
end

# Add interest rate observer
account.add_observer(:interest_rate) do |old_rate, new_rate|
  puts "📈 Interest rate changed from #{(old_rate * 100).round(2)}% to #{(new_rate * 100).round(2)}%"
end

# Test the observers
account.deposit(500)
account.withdraw(200)
account.withdraw(1200)  # Should trigger low balance
account.interest_rate = 0.025
```

## 🎯 Lifecycle Hooks for Classes

```ruby
module Lifecycle
  def self.included(base)
    base.extend(ClassMethods)
  end
  
  module ClassMethods
    def before_initialize(&block)
      @before_initialize_hooks ||= []
      @before_initialize_hooks << block
    end
    
    def after_initialize(&block)
      @after_initialize_hooks ||= []
      @after_initialize_hooks << block
    end
    
    def before_destroy(&block)
      @before_destroy_hooks ||= []
      @before_destroy_hooks << block
    end
    
    def get_hooks(type)
      instance_variable_get("@#{type}_hooks") || []
    end
  end
  
  def initialize(*args)
    run_hooks(:before_initialize)
    super(*args) if defined?(super)
    run_hooks(:after_initialize)
  end
  
  def destroy
    run_hooks(:before_destroy)
    puts "🗑️ Object destroyed!"
  end
  
  private
  
  def run_hooks(type)
    self.class.get_hooks(type).each { |hook| instance_eval(&hook) }
  end
end

class User
  include Lifecycle
  
  attr_reader :name, :email, :created_at
  
  before_initialize do
    puts "🔄 Preparing to create new user..."
  end
  
  after_initialize do
    puts "✅ User #{@name} created successfully!"
    puts "📧 Welcome email sent to #{@email}"
  end
  
  before_destroy do
    puts "⚠️ Cleaning up user data for #{@name}..."
  end
  
  def initialize(name, email)
    @name = name
    @email = email
    @created_at = Time.now
    super()  # This triggers the lifecycle hooks
  end
end

# Test lifecycle hooks
user = User.new("Alice", "alice@example.com")
# Output:
# 🔄 Preparing to create new user...
# ✅ User Alice created successfully!
# 📧 Welcome email sent to alice@example.com

user.destroy
# Output:
# ⚠️ Cleaning up user data for Alice...
# 🗑️ Object destroyed!
```

## 🔧 Method Wrapping with Hooks

```ruby
module MethodWrapper
  def self.included(base)
    base.extend(ClassMethods)
  end
  
  module ClassMethods
    def wrap_method(method_name, before: nil, after: nil)
      original_method = instance_method(method_name)
      
      define_method(method_name) do |*args, &block|
        # Before hook
        before.call(self, method_name, args) if before
        
        # Call original method
        result = original_method.bind(self).call(*args, &block)
        
        # After hook
        after.call(self, method_name, args, result) if after
        
        result
      end
    end
  end
end

class Calculator
  include MethodWrapper
  
  def add(a, b)
    a + b
  end
  
  def multiply(a, b)
    a * b
  end
  
  def divide(a, b)
    a / b.to_f
  end
  
  # Wrap methods with logging
  wrap_method :add,
    before: ->(obj, method, args) { puts "🔢 Calculating #{args[0]} + #{args[1]}" },
    after: ->(obj, method, args, result) { puts "✅ Result: #{result}" }
  
  wrap_method :multiply,
    before: ->(obj, method, args) { puts "🔢 Calculating #{args[0]} × #{args[1]}" },
    after: ->(obj, method, args, result) { puts "✅ Result: #{result}" }
  
  wrap_method :divide,
    before: ->(obj, method, args) { puts "🔢 Calculating #{args[0]} ÷ #{args[1]}" },
    after: ->(obj, method, args, result) { puts "✅ Result: #{result}" }
end

calc = Calculator.new
calc.add(5, 3)        # Logs before and after
calc.multiply(4, 7)   # Logs before and after
calc.divide(10, 3)    # Logs before and after
```

## 🎉 Hooks and Callbacks Mastery!

You now understand:
- ✅ Ruby's built-in hooks (inherited, method_added, etc.)
- ✅ Creating custom event systems with callbacks
- ✅ Building observable patterns for automatic notifications
- ✅ Implementing lifecycle hooks for object management
- ✅ Wrapping methods with before/after hooks
- ✅ Using hooks for logging, monitoring, and automation

Hooks and callbacks make your code more modular and reactive!

---

## 🚀 What's Next?

Now let's explore Domain Specific Languages (DSLs) - creating your own mini-languages!

**[← Previous: Monkey Patching](./26-monkey-patching.md)** | **[Next: Domain Specific Languages →](./28-dsl.md)**

---

### 🎯 Hooks and Callbacks Challenges

Try building:
1. **Audit Logger**: Automatically log all method calls and changes
2. **Cache System**: Automatically cache method results with hooks
3. **Validation System**: Run validations before saving objects
4. **Plugin Architecture**: Allow plugins to hook into core functionality

Hooks and callbacks help you build reactive, extensible systems! 🪝✨
