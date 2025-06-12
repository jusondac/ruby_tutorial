# Chapter 22: Dynamic Methods 🎪

## 🎭 What Are Dynamic Methods?

Dynamic methods are like shape-shifting spells! Instead of writing methods by hand, you create them on the fly while your program is running. It's like having a robot that can build new tools whenever you need them!

Think of it this way:
- 🔧 Regular methods: Tools you built beforehand
- ⚡ Dynamic methods: Tools you create exactly when you need them

## 🧙‍♂️ The `define_method` Spell

The most common way to create dynamic methods is with `define_method`:

### Basic Example
```ruby
class MagicBox
  # Create a method dynamically
  define_method("say_hello") do
    puts "Hello from the magic box!"
  end
  
  # Create another method with parameters
  define_method("say_goodbye") do |name|
    puts "Goodbye, #{name}!"
  end
end

box = MagicBox.new
box.say_hello           # Hello from the magic box!
box.say_goodbye("Alice") # Goodbye, Alice!
```

### Creating Multiple Similar Methods
```ruby
class Robot
  # Create methods for different emotions
  emotions = ["happy", "sad", "excited", "confused", "angry"]
  
  emotions.each do |emotion|
    define_method("feel_#{emotion}") do
      puts "🤖 *robot feels #{emotion}*"
    end
  end
end

robot = Robot.new
robot.feel_happy     # 🤖 *robot feels happy*
robot.feel_confused  # 🤖 *robot feels confused*
robot.feel_angry     # 🤖 *robot feels angry*
```

**Awesome!** We created 5 methods with just a few lines of code!

## 🎯 Method Factories

You can create methods that create other methods! It's like building a factory that makes tools:

```ruby
class AnimalSounds
  def self.create_sound_method(animal, sound)
    define_method("#{animal}_says") do
      puts "The #{animal} says #{sound}!"
    end
  end
  
  # Create a bunch of animal sound methods
  create_sound_method("dog", "woof")
  create_sound_method("cat", "meow")
  create_sound_method("cow", "moo")
  create_sound_method("sheep", "baa")
  create_sound_method("duck", "quack")
end

sounds = AnimalSounds.new
sounds.dog_says   # The dog says woof!
sounds.cat_says   # The cat says meow!
sounds.cow_says   # The cow says moo!
```

## 🔄 Dynamic Getters and Setters

Create getter and setter methods automatically:

```ruby
class SmartPerson
  def initialize
    @attributes = {}
  end
  
  # Create getter and setter for any attribute
  def self.attribute(name)
    # Getter method
    define_method(name) do
      @attributes[name]
    end
    
    # Setter method
    define_method("#{name}=") do |value|
      @attributes[name] = value
    end
  end
  
  # Define some attributes
  attribute :name
  attribute :age
  attribute :hobby
  attribute :favorite_color
end

person = SmartPerson.new
person.name = "Alice"
person.age = 25
person.hobby = "Ruby programming"
person.favorite_color = "blue"

puts "#{person.name} is #{person.age} years old"
puts "They love #{person.hobby} and their favorite color is #{person.favorite_color}"
```

## 🎮 Interactive Method Creator

Let's build something that creates methods based on user input:

```ruby
class CustomCalculator
  def initialize
    puts "🧮 Welcome to the Custom Calculator!"
    puts "You can create your own calculation methods!"
  end
  
  def create_method(method_name, calculation_block)
    self.class.define_method(method_name, calculation_block)
    puts "✅ Created method: #{method_name}"
  end
  
  def list_custom_methods
    custom_methods = self.methods(false)
    if custom_methods.empty?
      puts "No custom methods yet!"
    else
      puts "Custom methods: #{custom_methods.join(', ')}"
    end
  end
end

calc = CustomCalculator.new

# Create a method that doubles a number
calc.create_method("double") do |number|
  number * 2
end

# Create a method that finds the area of a circle
calc.create_method("circle_area") do |radius|
  3.14159 * radius * radius
end

# Create a method that converts Celsius to Fahrenheit
calc.create_method("celsius_to_fahrenheit") do |celsius|
  (celsius * 9.0 / 5.0) + 32
end

# Use our dynamically created methods
puts calc.double(5)                    # 10
puts calc.circle_area(3)               # 28.27...
puts calc.celsius_to_fahrenheit(20)    # 68.0

calc.list_custom_methods
```

## 🏗️ Building a REST API Simulator

Here's a more advanced example that creates CRUD methods dynamically:

```ruby
class SimpleAPI
  def initialize
    @data = {}
  end
  
  # Create CRUD methods for any resource
  def self.resource(name)
    # CREATE
    define_method("create_#{name}") do |attributes|
      id = (@data[name.to_s] ||= []).length + 1
      item = attributes.merge(id: id)
      @data[name.to_s] << item
      puts "✅ Created #{name} with ID #{id}"
      item
    end
    
    # READ (all)
    define_method("get_all_#{name}s") do
      @data[name.to_s] || []
    end
    
    # READ (by ID)
    define_method("get_#{name}") do |id|
      list = @data[name.to_s] || []
      list.find { |item| item[:id] == id }
    end
    
    # UPDATE
    define_method("update_#{name}") do |id, new_attributes|
      list = @data[name.to_s] || []
      item = list.find { |item| item[:id] == id }
      if item
        item.merge!(new_attributes)
        puts "✅ Updated #{name} with ID #{id}"
        item
      else
        puts "❌ #{name} with ID #{id} not found"
        nil
      end
    end
    
    # DELETE
    define_method("delete_#{name}") do |id|
      list = @data[name.to_s] || []
      item = list.find { |item| item[:id] == id }
      if item
        list.delete(item)
        puts "✅ Deleted #{name} with ID #{id}"
        item
      else
        puts "❌ #{name} with ID #{id} not found"
        nil
      end
    end
  end
  
  # Define resources
  resource :user
  resource :post
  resource :comment
end

api = SimpleAPI.new

# Use the dynamically created methods
user1 = api.create_user(name: "Alice", email: "alice@example.com")
user2 = api.create_user(name: "Bob", email: "bob@example.com")

post1 = api.create_post(title: "My First Post", content: "Hello world!")

puts "\nAll users:"
puts api.get_all_users.inspect

puts "\nUser 1:"
puts api.get_user(1).inspect

api.update_user(1, name: "Alice Smith")
puts "\nUpdated user 1:"
puts api.get_user(1).inspect
```

## 🎨 Method Aliases and Variations

Create multiple names for the same method:

```ruby
class FlexibleGreeter
  def initialize(name)
    @name = name
  end
  
  # Create the main greeting method
  define_method("greet") do |style = "normal"|
    case style
    when "formal"
      "Good day, I am #{@name}."
    when "casual"
      "Hey! I'm #{@name}!"
    when "excited"
      "HI!!! I'M #{@name}!!! 🎉"
    else
      "Hello, I'm #{@name}."
    end
  end
  
  # Create aliases for different greeting styles
  ["hello", "hi", "hey", "greetings"].each do |greeting_word|
    define_method(greeting_word) do |style = "normal"|
      greet(style)
    end
  end
  
  # Create methods for specific styles
  define_method("formal_greeting") do
    greet("formal")
  end
  
  define_method("casual_greeting") do
    greet("casual")
  end
  
  define_method("excited_greeting") do
    greet("excited")
  end
end

greeter = FlexibleGreeter.new("Ruby")

puts greeter.hello              # Hello, I'm Ruby.
puts greeter.hi("casual")       # Hey! I'm Ruby!
puts greeter.greetings("formal") # Good day, I am Ruby.
puts greeter.excited_greeting   # HI!!! I'M RUBY!!! 🎉
```

## 🧪 Dynamic Method Conditions

Create methods that behave differently based on conditions:

```ruby
class ConditionalMethods
  def initialize(mode)
    @mode = mode
  end
  
  # Create methods that behave differently based on mode
  ["process", "handle", "execute"].each do |action|
    define_method(action) do |data|
      case @mode
      when "debug"
        puts "🐛 DEBUG MODE: #{action.upcase}ING #{data.inspect}"
        data
      when "silent"
        # Do nothing, just return the data
        data
      when "verbose"
        puts "📢 VERBOSE: Starting to #{action} #{data}"
        result = data.to_s.upcase
        puts "📢 VERBOSE: Finished #{action}ing. Result: #{result}"
        result
      else
        puts "Processing #{data}"
        data
      end
    end
  end
end

# Test different modes
debug_processor = ConditionalMethods.new("debug")
silent_processor = ConditionalMethods.new("silent")
verbose_processor = ConditionalMethods.new("verbose")

puts "=== Debug Mode ==="
debug_processor.process("hello")

puts "\n=== Silent Mode ==="
silent_processor.handle("world")

puts "\n=== Verbose Mode ==="
verbose_processor.execute("ruby")
```

## 🔧 Method Utilities

Create helper methods for managing dynamic methods:

```ruby
class MethodManager
  def initialize
    @dynamic_methods = []
  end
  
  def create_method(name, &block)
    self.class.define_method(name, &block)
    @dynamic_methods << name
    puts "✅ Created method: #{name}"
  end
  
  def remove_method(name)
    if @dynamic_methods.include?(name)
      self.class.undef_method(name)
      @dynamic_methods.delete(name)
      puts "🗑️ Removed method: #{name}"
    else
      puts "❌ Method #{name} doesn't exist or wasn't created dynamically"
    end
  end
  
  def list_dynamic_methods
    if @dynamic_methods.empty?
      puts "No dynamic methods created yet"
    else
      puts "Dynamic methods: #{@dynamic_methods.join(', ')}"
    end
  end
  
  def method_exists?(name)
    @dynamic_methods.include?(name)
  end
end

manager = MethodManager.new

# Create some methods
manager.create_method("say_hi") { puts "Hi there!" }
manager.create_method("add_numbers") { |a, b| a + b }

manager.list_dynamic_methods
manager.say_hi
puts manager.add_numbers(5, 3)

# Remove a method
manager.remove_method("say_hi")
manager.list_dynamic_methods
```

## ⚠️ Dynamic Methods Best Practices

### 1. Document What You're Doing
```ruby
class DocumentedDynamicMethods
  # Creates getter and setter methods for the specified attributes
  # Example: attribute(:name) creates name() and name=() methods
  def self.attribute(name)
    define_method(name) { @attributes[name] }
    define_method("#{name}=") { |value| @attributes[name] = value }
  end
end
```

### 2. Provide Method Lists
```ruby
class TransparentDynamicMethods
  def self.dynamic_methods
    @dynamic_methods ||= []
  end
  
  def self.create_method(name, &block)
    define_method(name, &block)
    dynamic_methods << name
  end
  
  def available_methods
    self.class.dynamic_methods
  end
end
```

### 3. Handle Errors Gracefully
```ruby
class SafeDynamicMethods
  def call_dynamic_method(method_name, *args)
    if respond_to?(method_name)
      send(method_name, *args)
    else
      puts "Method #{method_name} doesn't exist"
      nil
    end
  end
end
```

## 🎉 Dynamic Methods Mastery!

You now know how to:
- ✅ Create methods on the fly with `define_method`
- ✅ Build method factories that create multiple similar methods
- ✅ Generate getters and setters automatically
- ✅ Create interactive systems that build methods from user input
- ✅ Build flexible APIs with dynamic CRUD operations
- ✅ Manage and organize dynamic methods

Dynamic methods are incredibly powerful for eliminating repetitive code and creating flexible, adaptable systems!

---

## 🚀 What's Next?

Now let's explore `eval` and `send` - more tools for dynamic code execution!

**[← Previous: Introduction to Metaprogramming](./21-metaprogramming-intro.md)** | **[Next: eval and send →](./23-eval-send.md)**

---

### 🎯 Dynamic Method Challenges

Practice with these projects:
1. **Dynamic Calculator**: Let users define custom mathematical operations
2. **Form Builder**: Create form field methods based on a configuration
3. **Game Character**: Create skill methods based on character attributes
4. **Database Model**: Build basic ORM with dynamic finders like `find_by_name`

Dynamic methods are like having a magic workshop - you can build any tool you need! 🔧✨
