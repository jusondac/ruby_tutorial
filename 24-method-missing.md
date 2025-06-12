# Chapter 24: method_missing 👻

## 🕵️ What is method_missing?

Imagine you have a magical assistant who can figure out what you want even when you ask for something that doesn't exist! That's what `method_missing` does in Ruby.

When you call a method that doesn't exist, Ruby says "Wait! Before I give up, let me check if there's a `method_missing` method that might know what to do!"

Think of it like this:
- 😕 Normal situation: "I don't know that method - ERROR!"
- 🧙‍♂️ With method_missing: "I don't know that method, but let me ask my magical assistant!"

## 🎭 How method_missing Works

```ruby
class MagicBox
  def method_missing(method_name, *args, &block)
    puts "You called: #{method_name}"
    puts "With arguments: #{args.inspect}"
    puts "Hmm, I don't have that method, but I'll try to help!"
  end
end

box = MagicBox.new
box.dance           # You called: dance
box.fly("high")     # You called: fly, With arguments: ["high"]
box.whatever(1, 2, 3) # You called: whatever, With arguments: [1, 2, 3]
```

## 🎪 Simple method_missing Examples

### Echo Box - Repeats Everything
```ruby
class EchoBox
  def method_missing(method_name, *args)
    puts "Echo: #{method_name} #{args.join(' ')}"
  end
  
  def respond_to_missing?(method_name, include_private = false)
    true  # We can handle any method!
  end
end

echo = EchoBox.new
echo.hello("world")           # Echo: hello world
echo.ruby("is", "awesome")    # Echo: ruby is awesome
echo.anything("goes", "here") # Echo: anything goes here
```

**Important:** Always define `respond_to_missing?` when you use `method_missing`!

### Dynamic Property Bag
```ruby
class PropertyBag
  def initialize
    @properties = {}
  end
  
  def method_missing(method_name, *args)
    method_str = method_name.to_s
    
    if method_str.end_with?('=')
      # Setter method (name=)
      property_name = method_str.chomp('=')
      @properties[property_name] = args.first
    elsif method_str.end_with?('?')
      # Query method (name?)
      property_name = method_str.chomp('?')
      @properties.key?(property_name)
    else
      # Getter method (name)
      @properties[method_str]
    end
  end
  
  def respond_to_missing?(method_name, include_private = false)
    true
  end
  
  def properties
    @properties
  end
end

bag = PropertyBag.new

# Set properties
bag.name = "Ruby"
bag.age = 28
bag.hobby = "Programming"

# Get properties
puts bag.name    # Ruby
puts bag.age     # 28
puts bag.hobby   # Programming

# Check if properties exist
puts bag.name?   # true
puts bag.job?    # false

puts bag.properties.inspect
```

## 🤖 Building a Smart Calculator

```ruby
class SmartCalculator
  def initialize
    @memory = 0
  end
  
  def method_missing(method_name, *args)
    method_str = method_name.to_s
    
    # Handle operations like add_5, subtract_10, multiply_by_3
    if method_str.match?(/^(add|subtract|multiply|divide)_(.+)/)
      operation = $1
      value = $2.gsub('_', '.').to_f
      
      case operation
      when 'add'
        @memory += value
      when 'subtract'
        @memory -= value
      when 'multiply'
        @memory *= value
      when 'divide'
        @memory /= value if value != 0
      end
      
      puts "#{operation.capitalize}ed #{value}. Result: #{@memory}"
      @memory
      
    # Handle operations like double, triple, quadruple
    elsif method_str.match?(/^(double|triple|quadruple|quintuple)$/)
      multiplier = case method_str
                   when 'double' then 2
                   when 'triple' then 3
                   when 'quadruple' then 4
                   when 'quintuple' then 5
                   end
      
      @memory *= multiplier
      puts "#{method_str.capitalize}d the value. Result: #{@memory}"
      @memory
      
    # Handle square, cube, etc.
    elsif method_str.match?(/^(square|cube)$/)
      power = method_str == 'square' ? 2 : 3
      @memory = @memory ** power
      puts "#{method_str.capitalize}d the value. Result: #{@memory}"
      @memory
      
    else
      super  # Let Ruby handle the error normally
    end
  end
  
  def respond_to_missing?(method_name, include_private = false)
    method_str = method_name.to_s
    method_str.match?(/^(add|subtract|multiply|divide)_/) ||
    method_str.match?(/^(double|triple|quadruple|quintuple|square|cube)$/) ||
    super
  end
  
  def value
    @memory
  end
  
  def clear
    @memory = 0
  end
  
  def set(value)
    @memory = value
  end
end

calc = SmartCalculator.new
calc.set(10)

calc.add_5        # Added 5.0. Result: 15.0
calc.multiply_2   # Multiplied 2.0. Result: 30.0
calc.subtract_10  # Subtracted 10.0. Result: 20.0
calc.double       # Doubled the value. Result: 40.0
calc.square       # Squared the value. Result: 1600.0

puts "Final value: #{calc.value}"
```

## 🏗️ Dynamic Attribute Creator

```ruby
class DynamicObject
  def initialize
    @attributes = {}
  end
  
  def method_missing(method_name, *args)
    method_str = method_name.to_s
    
    if method_str.end_with?('=')
      # Setter: create the attribute and getter method
      attr_name = method_str.chomp('=')
      @attributes[attr_name] = args.first
      
      # Define the getter method for faster future access
      self.class.define_method(attr_name) do
        @attributes[attr_name]
      end
      
      # Define the setter method for faster future access
      self.class.define_method("#{attr_name}=") do |value|
        @attributes[attr_name] = value
      end
      
      puts "✅ Created attribute: #{attr_name}"
      @attributes[attr_name]
      
    elsif @attributes.key?(method_str)
      # Getter: return the attribute value
      @attributes[method_str]
      
    else
      super
    end
  end
  
  def respond_to_missing?(method_name, include_private = false)
    method_str = method_name.to_s
    method_str.end_with?('=') || @attributes.key?(method_str) || super
  end
  
  def attributes
    @attributes
  end
end

obj = DynamicObject.new

obj.name = "Ruby"        # ✅ Created attribute: name
obj.version = "3.1"      # ✅ Created attribute: version
obj.awesome = true       # ✅ Created attribute: awesome

puts obj.name            # Ruby
puts obj.version         # 3.1
puts obj.awesome         # true

# Now these are real methods!
puts obj.methods(false).sort  # [:awesome, :awesome=, :name, :name=, :version, :version=]
```

## 🎮 Building a Mini ORM (Object-Relational Mapping)

```ruby
class MiniRecord
  def initialize(data = {})
    @data = data
  end
  
  def method_missing(method_name, *args)
    method_str = method_name.to_s
    
    # Handle find_by_xxx methods
    if method_str.start_with?('find_by_')
      field = method_str.sub('find_by_', '')
      value = args.first
      
      puts "🔍 Finding records where #{field} = #{value}"
      # In a real ORM, this would query a database
      # Here we'll just simulate it
      if @data[field] == value
        puts "✅ Found: #{@data}"
        self
      else
        puts "❌ No records found"
        nil
      end
      
    # Handle where_xxx_is methods
    elsif method_str.match?(/^where_(.+)_is$/)
      field = $1
      value = args.first
      
      puts "🔍 Searching where #{field} is #{value}"
      if @data[field] == value
        [self]  # Return array like a real query result
      else
        []
      end
      
    # Handle xxx_like methods for pattern matching
    elsif method_str.match?(/^(.+)_like$/)
      field = $1
      pattern = args.first
      
      puts "🔍 Searching #{field} like '#{pattern}'"
      if @data[field].to_s.include?(pattern)
        [self]
      else
        []
      end
      
    else
      super
    end
  end
  
  def respond_to_missing?(method_name, include_private = false)
    method_str = method_name.to_s
    method_str.start_with?('find_by_') ||
    method_str.match?(/^where_.+_is$/) ||
    method_str.match?(/^.+_like$/) ||
    super
  end
  
  def to_s
    @data.inspect
  end
end

# Simulate a user record
user = MiniRecord.new(name: "Alice", email: "alice@example.com", age: 25)

user.find_by_name("Alice")           # ✅ Found: {name: "Alice", ...}
user.find_by_email("bob@example.com") # ❌ No records found

results = user.where_age_is(25)      # ✅ Found records
puts "Results: #{results.length}"

name_results = user.name_like("Al")  # ✅ Found records with name containing "Al"
puts "Name search: #{name_results.length}"
```

## 🎨 Creating a Fluent Interface

```ruby
class FluentCalculator
  def initialize(value = 0)
    @value = value
  end
  
  def method_missing(method_name, *args)
    method_str = method_name.to_s
    
    # Handle operations that return new calculator
    if method_str.match?(/^(plus|minus|times|divided_by)$/)
      arg = args.first || 0
      
      new_value = case method_str
                  when 'plus'
                    @value + arg
                  when 'minus'
                    @value - arg
                  when 'times'
                    @value * arg
                  when 'divided_by'
                    arg != 0 ? @value / arg.to_f : @value
                  end
      
      FluentCalculator.new(new_value)
      
    # Handle operations with 'and' prefix
    elsif method_str.match?(/^and_(plus|minus|times|divided_by)$/)
      operation = $1
      send(operation, *args)  # Delegate to the operation method
      
    else
      super
    end
  end
  
  def respond_to_missing?(method_name, include_private = false)
    method_str = method_name.to_s
    method_str.match?(/^(plus|minus|times|divided_by)$/) ||
    method_str.match?(/^and_(plus|minus|times|divided_by)$/) ||
    super
  end
  
  def value
    @value
  end
  
  def to_s
    @value.to_s
  end
end

result = FluentCalculator.new(10)
  .plus(5)           # 15
  .times(2)          # 30
  .minus(10)         # 20
  .divided_by(4)     # 5

puts result.value    # 5.0

# Or with 'and' for readability
result2 = FluentCalculator.new(100)
  .plus(50)
  .and_minus(25)
  .and_times(2)
  .and_divided_by(5)

puts result2.value   # 50.0
```

## ⚠️ method_missing Best Practices

### 1. Always Define respond_to_missing?
```ruby
class GoodExample
  def method_missing(method_name, *args)
    # Handle dynamic methods
  end
  
  def respond_to_missing?(method_name, include_private = false)
    # Return true if you can handle the method
    method_name.to_s.start_with?('dynamic_') || super
  end
end
```

### 2. Call super for Unknown Methods
```ruby
class SafeExample
  def method_missing(method_name, *args)
    if can_handle?(method_name)
      handle_method(method_name, *args)
    else
      super  # Let Ruby handle the error
    end
  end
end
```

### 3. Be Specific About What You Handle
```ruby
class SpecificExample
  def method_missing(method_name, *args)
    method_str = method_name.to_s
    
    if method_str.match?(/^find_by_\w+$/)
      handle_finder(method_str, args)
    elsif method_str.end_with?('=')
      handle_setter(method_str, args)
    else
      super
    end
  end
end
```

### 4. Consider Performance
```ruby
class PerformantExample
  def method_missing(method_name, *args)
    # Define the method for future calls
    self.class.define_method(method_name) do |*future_args|
      handle_dynamic_method(method_name, *future_args)
    end
    
    # Call the newly defined method
    send(method_name, *args)
  end
end
```

## 🎉 method_missing Mastery!

You now know how to:
- ✅ Handle calls to non-existent methods gracefully
- ✅ Create dynamic property systems
- ✅ Build fluent interfaces and DSLs
- ✅ Implement finder methods and query builders
- ✅ Use method_missing safely with proper practices
- ✅ Create methods dynamically for better performance

method_missing is like having a magical catch-all that can make your objects infinitely flexible!

---

## 🚀 What's Next?

Let's explore class methods and variables - sharing data and behavior across all instances!

**[← Previous: eval and send](./23-eval-send.md)** | **[Next: Class Methods and Variables →](./25-class-methods.md)**

---

### 🎯 method_missing Challenges

Try building:
1. **Dynamic API Client**: Handle any endpoint like `client.get_users`, `client.post_messages`
2. **Configuration Object**: Access config like `config.database.host`
3. **Chainable Query Builder**: Build queries like `User.where_name_is("Alice").and_age_over(18)`
4. **Mock Object Generator**: Create test doubles that respond to any method

method_missing is pure magic - use it to create amazing, flexible interfaces! ✨👻
