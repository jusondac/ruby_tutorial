# Chapter 23: eval and send 🔮

## 🧙‍♂️ What Are eval and send?

Imagine you have a magic crystal ball that can read spells written on paper and cast them immediately! That's what `eval` and `send` do - they take Ruby code as text and run it as if you typed it directly.

- 🔮 **eval**: Runs Ruby code from a string
- 📞 **send**: Calls methods by their name (as a string or symbol)

These are some of the most powerful (and dangerous) tools in Ruby's metaprogramming toolbox!

## 📞 The `send` Method - Calling Methods by Name

`send` lets you call any method using its name as a string or symbol:

### Basic send Usage
```ruby
class Calculator
  def add(a, b)
    a + b
  end
  
  def multiply(a, b)
    a * b
  end
  
  def greet
    puts "Hello, I'm a calculator!"
  end
end

calc = Calculator.new

# Normal method call
puts calc.add(5, 3)  # 8

# Using send (same result!)
puts calc.send("add", 5, 3)     # 8
puts calc.send(:multiply, 4, 6)  # 24
calc.send("greet")              # Hello, I'm a calculator!
```

### Dynamic Method Calling
```ruby
class Robot
  def walk
    puts "🤖 *walking*"
  end
  
  def jump
    puts "🤖 *jumping*"
  end
  
  def dance
    puts "🤖 *dancing*"
  end
  
  def wave
    puts "🤖 *waving*"
  end
end

robot = Robot.new
actions = ["walk", "jump", "dance", "wave"]

# Make the robot do all actions
actions.each do |action|
  robot.send(action)
end

# Interactive robot controller
puts "What should the robot do? (walk, jump, dance, wave)"
user_command = gets.chomp

if robot.respond_to?(user_command)
  robot.send(user_command)
else
  puts "Robot doesn't know how to #{user_command}"
end
```

### send with Private Methods
`send` is special - it can even call private methods!

```ruby
class Secret
  def public_method
    puts "This is public"
  end
  
  private
  
  def secret_method
    puts "This is secret!"
  end
end

secret = Secret.new
secret.public_method           # This is public
# secret.secret_method         # Error! Can't call private method normally
secret.send(:secret_method)    # This is secret! (send can access private methods!)
```

**Note:** There's also `public_send` which only calls public methods - it's safer!

## 🔮 The `eval` Method - Running Code from Strings

`eval` takes a string containing Ruby code and executes it:

### Basic eval Usage
```ruby
# Simple expressions
puts eval("2 + 3")           # 5
puts eval("'hello'.upcase")  # HELLO

# Variables work too
name = "Ruby"
puts eval('"Hello, #{name}!"')  # Hello, Ruby!

# Even method definitions!
eval("def say_wow; puts 'WOW!'; end")
say_wow  # WOW!
```

### Dynamic Code Generation
```ruby
class MathWizard
  def create_operation(operation_name, formula)
    code = "
      def #{operation_name}(x, y)
        #{formula}
      end
    "
    
    eval(code)
    puts "✅ Created operation: #{operation_name}"
  end
end

wizard = MathWizard.new

# Create custom math operations
wizard.create_operation("hypotenuse", "Math.sqrt(x**2 + y**2)")
wizard.create_operation("average", "(x + y) / 2.0")
wizard.create_operation("max_difference", "(x - y).abs")

puts wizard.hypotenuse(3, 4)     # 5.0
puts wizard.average(10, 20)      # 15.0
puts wizard.max_difference(8, 3) # 5
```

### Building a Simple Calculator with eval
```ruby
class StringCalculator
  def calculate(expression)
    # Basic safety check
    if expression.match?(/^[\d\s\+\-\*\/\(\)\.]+$/)
      begin
        result = eval(expression)
        puts "#{expression} = #{result}"
        result
      rescue => e
        puts "Error: #{e.message}"
        nil
      end
    else
      puts "Invalid expression - only numbers and basic operators allowed"
      nil
    end
  end
end

calc = StringCalculator.new

calc.calculate("2 + 3")           # 2 + 3 = 5
calc.calculate("10 * (5 + 3)")    # 10 * (5 + 3) = 80
calc.calculate("100 / 4")         # 100 / 4 = 25
calc.calculate("2 ** 8")          # 2 ** 8 = 256
```

## 🎮 Interactive Ruby Console

Let's build a mini IRB (Interactive Ruby):

```ruby
class MiniIRB
  def initialize
    @local_variables = {}
    puts "🎮 Mini Ruby Console (type 'exit' to quit)"
    puts "You can use variables and they'll be remembered!"
  end
  
  def start
    loop do
      print "mini-irb> "
      input = gets.chomp
      
      break if input.downcase == "exit"
      
      begin
        # Create local variables in the binding
        @local_variables.each do |name, value|
          eval("#{name} = #{value.inspect}")
        end
        
        result = eval(input)
        
        # Check if a new variable was created
        if input.match?(/^([a-z_]\w*)\s*=\s*(.+)/)
          var_name = $1
          @local_variables[var_name] = result
        end
        
        puts "=> #{result.inspect}"
        
      rescue => e
        puts "Error: #{e.message}"
      end
    end
    
    puts "Goodbye! 👋"
  end
end

# Uncomment to try it:
# MiniIRB.new.start
```

## 🏗️ Dynamic Class Creation with eval

Create entire classes from strings:

```ruby
class ClassBuilder
  def self.create_animal_class(animal_name, sound, color)
    class_code = <<~RUBY
      class #{animal_name.capitalize}
        def initialize(name)
          @name = name
          @color = "#{color}"
        end
        
        def speak
          puts "\#{@name} the #{color} #{animal_name.downcase} says #{sound}!"
        end
        
        def info
          puts "This is \#{@name}, a #{color} #{animal_name.downcase}."
        end
        
        attr_reader :color
        attr_accessor :name
      end
    RUBY
    
    eval(class_code)
    puts "✅ Created #{animal_name.capitalize} class!"
  end
end

# Create animal classes dynamically
ClassBuilder.create_animal_class("Dog", "woof", "brown")
ClassBuilder.create_animal_class("Cat", "meow", "orange")
ClassBuilder.create_animal_class("Bird", "tweet", "blue")

# Use the dynamically created classes
dog = Dog.new("Buddy")
cat = Cat.new("Whiskers")
bird = Bird.new("Tweety")

dog.speak   # Buddy the brown dog says woof!
cat.info    # This is Whiskers, a orange cat.
bird.speak  # Tweety the blue bird says tweet!
```

## 🎪 Command Pattern with send

Build a flexible command system:

```ruby
class GameCharacter
  def initialize(name)
    @name = name
    @health = 100
    @energy = 50
    @inventory = []
  end
  
  def attack(target = "enemy")
    if @energy >= 10
      @energy -= 10
      puts "#{@name} attacks #{target}! (-10 energy)"
    else
      puts "#{@name} is too tired to attack!"
    end
  end
  
  def heal
    @health = [@health + 20, 100].min
    puts "#{@name} heals! Health: #{@health}"
  end
  
  def rest
    @energy = [@energy + 15, 100].min
    puts "#{@name} rests! Energy: #{@energy}"
  end
  
  def status
    puts "#{@name}: Health=#{@health}, Energy=#{@energy}, Items=#{@inventory.join(',')}"
  end
  
  def pickup(item)
    @inventory << item
    puts "#{@name} picked up #{item}"
  end
  
  def execute_command(command_string)
    parts = command_string.split(' ')
    action = parts[0]
    args = parts[1..-1]
    
    if respond_to?(action)
      if args.empty?
        send(action)
      else
        send(action, *args)
      end
    else
      puts "#{@name} doesn't know how to #{action}"
    end
  end
end

hero = GameCharacter.new("Heroina")

# Game loop
puts "🎮 Game Commands: attack, heal, rest, status, pickup [item], quit"
loop do
  print "Command> "
  command = gets.chomp
  
  break if command.downcase == "quit"
  
  hero.execute_command(command)
end
```

## 🔧 Building a Configuration System

Use eval to create flexible configuration:

```ruby
class AppConfig
  def initialize
    @config = {}
  end
  
  def load_config(config_string)
    # Create a safe environment for the config
    config_binding = binding
    
    # Define helper methods available in config
    config_binding.eval <<~RUBY
      def set(key, value)
        @config[key] = value
      end
      
      def database(options)
        @config[:database] = options
      end
      
      def server(options)
        @config[:server] = options
      end
    RUBY
    
    # Execute the configuration
    config_binding.eval(config_string)
  end
  
  def get(key)
    @config[key]
  end
  
  def all_config
    @config
  end
end

# Configuration as a string (could come from a file)
config_text = <<~CONFIG
  set :app_name, "My Awesome App"
  set :version, "1.0.0"
  set :debug, true
  
  database host: "localhost",
           port: 5432,
           name: "myapp_db"
  
  server port: 3000,
         workers: 4
CONFIG

config = AppConfig.new
config.load_config(config_text)

puts "App: #{config.get(:app_name)}"
puts "Database: #{config.get(:database)}"
puts "All config: #{config.all_config}"
```

## ⚠️ Dangers of eval and send

### 1. Security Risks
```ruby
# NEVER do this with user input!
user_input = gets.chomp
eval(user_input)  # User could type: system("rm -rf /")
```

### 2. Performance Issues
```ruby
# eval is slow because it has to parse and compile code
1000.times do
  eval("2 + 2")  # Slow!
end

# Direct method calls are fast
1000.times do
  2 + 2  # Fast!
end
```

### 3. Debugging Difficulties
```ruby
# Hard to debug because the source of errors is unclear
eval("some_method_that_might_not_exist")  # Where did this come from?
```

## 🛡️ Safe Alternatives

### Use send with Validation
```ruby
class SafeMethodCaller
  ALLOWED_METHODS = ["add", "multiply", "greet"].freeze
  
  def safe_call(method_name, *args)
    if ALLOWED_METHODS.include?(method_name.to_s)
      send(method_name, *args)
    else
      puts "Method #{method_name} not allowed"
    end
  end
end
```

### Use proc/lambda Instead of eval
```ruby
# Instead of eval for simple expressions
formula = ->(x, y) { x + y }
puts formula.call(5, 3)  # Safer than eval("5 + 3")
```

### Use method_missing for Unknown Methods
```ruby
class DynamicMethodHandler
  def method_missing(method_name, *args)
    puts "Called #{method_name} with #{args}"
  end
end
```

## 🎉 eval and send Mastery!

You now understand:
- ✅ How to call methods dynamically with `send`
- ✅ How to execute code from strings with `eval`
- ✅ Building interactive systems and command processors
- ✅ Creating classes and methods dynamically
- ✅ The security risks and how to mitigate them
- ✅ When to use these tools and when to avoid them

These are powerful tools - use them wisely!

---

## 🚀 What's Next?

Let's explore `method_missing` - Ruby's way of handling calls to methods that don't exist!

**[← Previous: Dynamic Methods](./22-dynamic-methods.md)** | **[Next: method_missing →](./24-method-missing.md)**

---

### 🎯 eval and send Challenges

Try building:
1. **Command Line Calculator**: Parse and evaluate math expressions safely
2. **Mini Templating System**: Replace variables in text templates
3. **Dynamic API**: Create endpoints by sending method names
4. **Configuration DSL**: Build a domain-specific language for app settings

Remember: With great power comes great responsibility! 🕷️✨
