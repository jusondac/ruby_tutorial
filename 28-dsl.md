# Chapter 28: Domain Specific Languages (DSL) 🏗️

## 🤔 What is a Domain Specific Language?

A Domain Specific Language (DSL) is like creating your own mini-language inside Ruby! Instead of writing regular Ruby code, you create a special way of writing that feels natural for a specific task.

Think of it like this:
- 🗣️ **Regular language**: How we normally talk
- 🎵 **Music notation**: Special language for writing music
- 🧑‍💻 **DSL**: Special language for a specific programming task

DSLs make code read more like natural language and hide complex implementation details!

## 🌟 Simple DSL Examples You've Seen

You've probably used DSLs without realizing it:

### RSpec (Testing DSL)
```ruby
describe "Calculator" do
  it "adds two numbers" do
    expect(2 + 2).to eq(4)
  end
end
```

### Rails Routes (Web DSL)
```ruby
Rails.application.routes.draw do
  get '/users', to: 'users#index'
  post '/users', to: 'users#create'
end
```

### Sinatra (Web Framework DSL)
```ruby
get '/' do
  "Hello World!"
end

post '/users' do
  # Create user
end
```

These don't look like normal Ruby code, but they ARE Ruby code using DSL magic!

## 🏠 Building Your First DSL: House Builder

Let's create a DSL for building virtual houses:

```ruby
class House
  attr_reader :rooms, :features
  
  def initialize
    @rooms = []
    @features = []
  end
  
  # DSL method for adding rooms
  def room(type, size: "medium", &block)
    new_room = Room.new(type, size)
    
    # If a block is given, configure the room
    if block_given?
      new_room.instance_eval(&block)
    end
    
    @rooms << new_room
    puts "✅ Added #{size} #{type}"
  end
  
  # DSL method for adding features
  def feature(name)
    @features << name
    puts "✅ Added feature: #{name}"
  end
  
  # DSL method for multiple rooms at once
  def rooms(*room_types)
    room_types.each { |type| room(type) }
  end
  
  def describe
    puts "\n🏠 House Description:"
    puts "Rooms: #{@rooms.map(&:description).join(', ')}"
    puts "Features: #{@features.join(', ')}"
    puts "Total rooms: #{@rooms.length}"
  end
end

class Room
  attr_reader :type, :size, :items
  
  def initialize(type, size)
    @type = type
    @size = size
    @items = []
  end
  
  # DSL method for adding items to rooms
  def item(name, quantity = 1)
    @items << { name: name, quantity: quantity }
    puts "  📦 Added #{quantity} #{name}(s) to #{@type}"
  end
  
  # DSL method for multiple items
  def items(*item_names)
    item_names.each { |name| item(name) }
  end
  
  def description
    "#{@size} #{@type}"
  end
end

# DSL helper method to create houses
def build_house(&block)
  house = House.new
  house.instance_eval(&block)
  house
end

# Using our DSL!
my_house = build_house do
  room "living room", size: "large" do
    item "sofa"
    item "TV"
    item "coffee table"
  end
  
  room "kitchen" do
    items "stove", "refrigerator", "dishwasher"
    item "chair", 4
  end
  
  rooms "bedroom", "bathroom", "garage"
  
  feature "swimming pool"
  feature "garden"
  feature "fireplace"
end

my_house.describe
```

## 🍕 Recipe DSL

Let's create a DSL for writing recipes:

```ruby
class Recipe
  attr_reader :name, :ingredients, :steps, :cook_time, :servings
  
  def initialize(name)
    @name = name
    @ingredients = []
    @steps = []
    @cook_time = 0
    @servings = 1
  end
  
  # DSL methods
  def ingredient(name, amount = nil, unit = nil)
    @ingredients << {
      name: name,
      amount: amount,
      unit: unit
    }
  end
  
  def step(instruction)
    @steps << instruction
  end
  
  def serves(count)
    @servings = count
  end
  
  def takes(time_in_minutes)
    @cook_time = time_in_minutes
  end
  
  def display
    puts "\n👨‍🍳 #{@name}"
    puts "=" * (@name.length + 4)
    puts "🕐 Cook time: #{@cook_time} minutes"
    puts "🍽️  Serves: #{@servings}"
    
    puts "\n📝 Ingredients:"
    @ingredients.each_with_index do |ing, i|
      amount_text = ing[:amount] ? "#{ing[:amount]} #{ing[:unit]} " : ""
      puts "  #{i + 1}. #{amount_text}#{ing[:name]}"
    end
    
    puts "\n🔥 Instructions:"
    @steps.each_with_index do |step, i|
      puts "  #{i + 1}. #{step}"
    end
  end
end

def recipe(name, &block)
  new_recipe = Recipe.new(name)
  new_recipe.instance_eval(&block)
  new_recipe
end

# Using the Recipe DSL
chocolate_cake = recipe "Chocolate Cake" do
  serves 8
  takes 45
  
  ingredient "flour", 2, "cups"
  ingredient "sugar", 1.5, "cups"
  ingredient "cocoa powder", 0.75, "cups"
  ingredient "eggs", 2
  ingredient "milk", 1, "cup"
  ingredient "butter", 0.5, "cup"
  
  step "Preheat oven to 350°F"
  step "Mix dry ingredients in a large bowl"
  step "Beat eggs and milk in separate bowl"
  step "Combine wet and dry ingredients"
  step "Pour into greased pan"
  step "Bake for 30-35 minutes"
  step "Let cool before serving"
end

chocolate_cake.display
```

## 🎮 Game Configuration DSL

Create a DSL for configuring game characters:

```ruby
class GameCharacter
  attr_reader :name, :stats, :skills, :equipment
  
  def initialize(name)
    @name = name
    @stats = { strength: 10, agility: 10, intelligence: 10, health: 100 }
    @skills = []
    @equipment = []
  end
  
  # DSL methods
  def strength(value)
    @stats[:strength] = value
  end
  
  def agility(value)
    @stats[:agility] = value
  end
  
  def intelligence(value)
    @stats[:intelligence] = value
  end
  
  def health(value)
    @stats[:health] = value
  end
  
  def skill(name, level = 1)
    @skills << { name: name, level: level }
  end
  
  def weapon(name, damage = 10)
    @equipment << { type: "weapon", name: name, damage: damage }
  end
  
  def armor(name, defense = 5)
    @equipment << { type: "armor", name: name, defense: defense }
  end
  
  def display
    puts "\n⚔️  #{@name}"
    puts "=" * (@name.length + 4)
    
    puts "\n📊 Stats:"
    @stats.each { |stat, value| puts "  #{stat.capitalize}: #{value}" }
    
    puts "\n🎯 Skills:"
    @skills.each { |skill| puts "  #{skill[:name]} (Level #{skill[:level]})" }
    
    puts "\n🛡️  Equipment:"
    @equipment.each do |item|
      case item[:type]
      when "weapon"
        puts "  ⚔️ #{item[:name]} (Damage: #{item[:damage]})"
      when "armor"
        puts "  🛡️ #{item[:name]} (Defense: #{item[:defense]})"
      end
    end
  end
end

def character(name, &block)
  char = GameCharacter.new(name)
  char.instance_eval(&block)
  char
end

# Using the Game Character DSL
warrior = character "Sir Bravealot" do
  strength 18
  agility 12
  intelligence 8
  health 150
  
  skill "Sword Fighting", 5
  skill "Shield Mastery", 3
  skill "Battle Cry", 2
  
  weapon "Excalibur", 25
  armor "Plate Mail", 15
end

mage = character "Merlin the Wise" do
  strength 8
  agility 10
  intelligence 20
  health 80
  
  skill "Fireball", 8
  skill "Teleportation", 4
  skill "Mind Reading", 6
  
  weapon "Magic Staff", 15
  armor "Robes of Power", 8
end

warrior.display
mage.display
```

## 🏗️ HTML Builder DSL

Create a DSL for building HTML:

```ruby
class HTMLBuilder
  def initialize
    @elements = []
  end
  
  # Generic method to handle any HTML tag
  def method_missing(tag_name, *args, &block)
    options = args.first || {}
    content = options.delete(:content) || ""
    
    # Build attributes string
    attrs = options.map { |k, v| "#{k}='#{v}'" }.join(' ')
    attrs = " #{attrs}" unless attrs.empty?
    
    if block_given?
      # Nested content
      nested_builder = HTMLBuilder.new
      nested_builder.instance_eval(&block)
      content = nested_builder.to_html
    end
    
    if content.empty? && %w[br hr img input].include?(tag_name.to_s)
      # Self-closing tags
      @elements << "<#{tag_name}#{attrs} />"
    else
      @elements << "<#{tag_name}#{attrs}>#{content}</#{tag_name}>"
    end
  end
  
  def respond_to_missing?(method_name, include_private = false)
    true  # We can handle any HTML tag
  end
  
  def text(content)
    @elements << content.to_s
  end
  
  def to_html
    @elements.join("\n")
  end
end

def html(&block)
  builder = HTMLBuilder.new
  builder.instance_eval(&block)
  builder.to_html
end

# Using the HTML DSL
webpage = html do
  html do
    head do
      title content: "My Amazing Page"
      meta charset: "UTF-8"
    end
    
    body do
      h1 content: "Welcome to My Site!", class: "header"
      
      div class: "container" do
        p content: "This is a paragraph created with Ruby DSL!"
        
        ul do
          li content: "First item"
          li content: "Second item"
          li content: "Third item"
        end
        
        a href: "https://www.ruby-lang.org", content: "Learn Ruby"
      end
      
      footer do
        text "Copyright 2024"
      end
    end
  end
end

puts webpage
```

## 🎪 Advanced DSL: Task Runner

Create a DSL for defining and running tasks:

```ruby
class TaskRunner
  def initialize
    @tasks = {}
    @dependencies = {}
  end
  
  def task(name, dependencies: [], &block)
    @tasks[name] = block
    @dependencies[name] = dependencies
    puts "📝 Defined task: #{name}"
  end
  
  def run(task_name)
    if @tasks[task_name]
      # Run dependencies first
      @dependencies[task_name].each { |dep| run(dep) }
      
      puts "▶️  Running task: #{task_name}"
      @tasks[task_name].call
      puts "✅ Completed task: #{task_name}"
    else
      puts "❌ Task not found: #{task_name}"
    end
  end
  
  def list_tasks
    puts "\n📋 Available tasks:"
    @tasks.each do |name, _|
      deps = @dependencies[name]
      dep_text = deps.empty? ? "" : " (depends on: #{deps.join(', ')})"
      puts "  • #{name}#{dep_text}"
    end
  end
end

def tasks(&block)
  runner = TaskRunner.new
  runner.instance_eval(&block)
  runner
end

# Using the Task Runner DSL
build_system = tasks do
  task :clean do
    puts "🧹 Cleaning build directory..."
    # system("rm -rf build/")
  end
  
  task :compile, dependencies: [:clean] do
    puts "🔨 Compiling source files..."
    # system("gcc -o app main.c")
  end
  
  task :test, dependencies: [:compile] do
    puts "🧪 Running tests..."
    # system("./run_tests.sh")
  end
  
  task :package, dependencies: [:test] do
    puts "📦 Creating package..."
    # system("tar -czf app.tar.gz app")
  end
  
  task :deploy, dependencies: [:package] do
    puts "🚀 Deploying to server..."
    # system("scp app.tar.gz server:/opt/apps/")
  end
end

build_system.list_tasks
puts "\n" + "=" * 40
build_system.run(:deploy)  # This will run all dependencies in order!
```

## 🎯 DSL Best Practices

### 1. Make It Read Like Natural Language
```ruby
# Good DSL - reads naturally
user "john" do
  email "john@example.com"
  role "admin"
  active true
end

# Bad DSL - too technical
create_user(name: "john", email: "john@example.com", role: "admin", active: true)
```

### 2. Use instance_eval for Clean Syntax
```ruby
class ConfigBuilder
  def configure(&block)
    instance_eval(&block)  # Clean syntax inside block
  end
  
  def setting(key, value)
    # Handle setting
  end
end
```

### 3. Provide Good Error Messages
```ruby
def validate_input(value)
  unless value.is_a?(String)
    raise "Expected string, got #{value.class}"
  end
end
```

### 4. Keep It Simple
```ruby
# Simple and focused
email_template do
  to "user@example.com"
  subject "Welcome!"
  body "Hello there!"
end

# Too complex - avoid this
email_template do
  configure_smtp_settings host: "smtp.gmail.com" do
    authentication :login
    username ENV['EMAIL_USER']
    # ... too much complexity
  end
end
```

## 🎉 DSL Mastery!

You now know how to:
- ✅ Create Domain Specific Languages for specific tasks
- ✅ Use `instance_eval` to create clean, natural syntax
- ✅ Build configuration systems with DSLs
- ✅ Handle method_missing for flexible DSLs
- ✅ Design DSLs that read like natural language
- ✅ Create task runners and build systems

DSLs are the ultimate metaprogramming technique - you're literally creating your own language!

---

## 🚀 Congratulations!

You've completed the Ruby metaprogramming journey! You now have all the tools to create amazing, flexible, and powerful Ruby programs.

**[← Previous: Hooks and Callbacks](./27-hooks-callbacks.md)** | **[🏠 Back to Main Menu](./README.md)**

---

### 🎯 Final DSL Challenge

Create your own DSL for something you're interested in:
1. **Blog Post DSL**: Define blog posts with metadata
2. **API Definition DSL**: Define REST APIs declaratively
3. **Game Rules DSL**: Define board game or card game rules
4. **Form Builder DSL**: Create web forms with validation

You're now a Ruby metaprogramming wizard! 🧙‍♂️✨🎉
