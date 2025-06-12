# Chapter 19: Gems and Libraries - Using Other Wizards' Spells 💎

[← Previous: Regular Expressions](./18-regex.md) | [Next: Testing Your Code →](./20-testing.md)

## What Are Gems? 💎

Imagine you're building a treehouse and instead of making every single nail, screw, and piece of wood yourself, you could go to a magical hardware store where other builders have already made perfect tools and materials! That's exactly what gems are in Ruby - they're pre-built pieces of code that other programmers have created and shared with the world! 🏗️

Gems are like superpowers that you can add to your Ruby programs. Want to build a website? There's a gem for that! Need to work with dates? There's a gem for that too! Want to create beautiful graphics? Yep, there's a gem for that as well!

## What is RubyGems? 📦

RubyGems is Ruby's package manager - think of it as the magical hardware store where all the gems live. It comes built-in with Ruby, so you already have it! It helps you:

- Find gems you need
- Install gems easily
- Update gems to newer versions
- Manage gem dependencies (when gems need other gems)

## Installing Your First Gem 🎉

Let's install a fun gem called `colorize` that lets you add colors to your text output:

```bash
# In your terminal/command prompt
gem install colorize
```

Once installed, you can use it in your Ruby programs:

```ruby
require 'colorize'

puts "Hello World!".red
puts "This is green text!".green
puts "Blue text is cool!".blue
puts "Warning!".yellow.bold
puts "Error message".red.underline
puts "Success!".green.bold.blink
```

## The `require` Statement 📥

To use a gem in your program, you need to `require` it first:

```ruby
# This loads the gem into your program
require 'colorize'
require 'json'
require 'date'

# Now you can use their features!
puts "Hello!".blue
data = JSON.parse('{"name": "Ruby"}')
today = Date.today
```

## Popular Gems Everyone Should Know 🌟

### 1. JSON - Working with Data 📄

JSON is perfect for storing and exchanging data:

```ruby
require 'json'

# Convert Ruby objects to JSON
person = {
  name: "Alice",
  age: 25,
  hobbies: ["reading", "coding", "gaming"]
}

json_string = JSON.generate(person)
puts json_string
# Output: {"name":"Alice","age":25,"hobbies":["reading","coding","gaming"]}

# Convert JSON back to Ruby objects
parsed_data = JSON.parse(json_string)
puts parsed_data["name"]  # "Alice"
puts parsed_data["hobbies"]  # ["reading", "coding", "gaming"]
```

### 2. HTTParty - Making Web Requests 🌐

HTTParty makes it super easy to get data from websites:

```bash
gem install httparty
```

```ruby
require 'httparty'

# Get data from a web API
response = HTTParty.get('https://api.github.com/users/octocat')

if response.success?
  user_data = response.parsed_response
  puts "GitHub User: #{user_data['name']}"
  puts "Public repos: #{user_data['public_repos']}"
  puts "Followers: #{user_data['followers']}"
else
  puts "Failed to get data: #{response.code}"
end
```

### 3. FileUtils - Advanced File Operations 📁

FileUtils gives you more powerful file and directory operations:

```ruby
require 'fileutils'

# Create directories
FileUtils.mkdir_p("projects/ruby/awesome_app")

# Copy files and directories
FileUtils.cp("source.txt", "backup.txt")
FileUtils.cp_r("source_folder", "backup_folder")

# Move files
FileUtils.mv("old_name.txt", "new_name.txt")

# Remove files and directories safely
FileUtils.rm_f("unwanted_file.txt")  # Won't error if file doesn't exist
FileUtils.rm_rf("temp_folder")       # Remove folder and all contents
```

### 4. CSV - Working with Spreadsheet Data 📊

```ruby
require 'csv'

# Writing CSV data
CSV.open("people.csv", "w") do |csv|
  csv << ["Name", "Age", "City"]  # Header row
  csv << ["Alice", 25, "New York"]
  csv << ["Bob", 30, "Los Angeles"]
  csv << ["Charlie", 35, "Chicago"]
end

# Reading CSV data
CSV.foreach("people.csv", headers: true) do |row|
  puts "#{row['Name']} is #{row['Age']} years old and lives in #{row['City']}"
end

# Converting CSV to array of hashes
people = CSV.read("people.csv", headers: true).map(&:to_h)
puts people
# [{"Name"=>"Alice", "Age"=>"25", "City"=>"New York"}, ...]
```

## Real-World Example: Weather App 🌤️

Let's build a simple weather app using multiple gems:

```bash
gem install httparty colorize
```

```ruby
require 'httparty'
require 'json'
require 'colorize'

class WeatherApp
  BASE_URL = "http://api.openweathermap.org/data/2.5/weather"
  
  def initialize(api_key)
    @api_key = api_key
  end
  
  def get_weather(city)
    puts "🌍 Getting weather for #{city}...".blue
    
    response = HTTParty.get(BASE_URL, {
      query: {
        q: city,
        appid: @api_key,
        units: 'metric'  # Celsius
      }
    })
    
    if response.success?
      display_weather(response.parsed_response)
    else
      puts "❌ Error: #{response['message']}".red
    end
  rescue => e
    puts "❌ Failed to get weather data: #{e.message}".red
  end
  
  private
  
  def display_weather(data)
    city = data['name']
    country = data['sys']['country']
    temp = data['main']['temp'].round
    feels_like = data['main']['feels_like'].round
    humidity = data['main']['humidity']
    description = data['weather'][0]['description']
    
    puts "\n🏙️  Weather for #{city}, #{country}".yellow.bold
    puts "=" * 40
    
    # Color code temperature
    temp_color = temp_color(temp)
    puts "🌡️  Temperature: #{temp}°C".colorize(temp_color)
    puts "🤔 Feels like: #{feels_like}°C"
    puts "💧 Humidity: #{humidity}%"
    puts "☁️  Description: #{description.capitalize}".green
    
    # Weather emoji based on description
    emoji = weather_emoji(description)
    puts "\n#{emoji} #{description.capitalize}!"
  end
  
  def temp_color(temp)
    case temp
    when -Float::INFINITY..0
      :blue
    when 0..15
      :cyan
    when 15..25
      :green
    when 25..35
      :yellow
    else
      :red
    end
  end
  
  def weather_emoji(description)
    case description.downcase
    when /clear/
      "☀️"
    when /cloud/
      "☁️"
    when /rain/
      "🌧️"
    when /snow/
      "❄️"
    when /storm/
      "⛈️"
    else
      "🌤️"
    end
  end
end

# Note: You'd need to get a free API key from OpenWeatherMap
# This is just to show how the gems work together
puts "🌤️  Simple Weather App".rainbow.bold
puts "=" * 30

# For demo purposes (you'd use a real API key)
if false  # Change to true if you have an API key
  weather = WeatherApp.new("your_api_key_here")
  
  print "Enter city name: "
  city = gets.chomp
  weather.get_weather(city)
else
  puts "Demo mode - showing how the gems would work together!".yellow
end
```

## Building a Personal Finance Tracker 💰

Let's create a more complex example using multiple gems:

```bash
gem install colorize terminal-table
```

```ruby
require 'csv'
require 'date'
require 'colorize'
require 'terminal-table'

class FinanceTracker
  def initialize
    @transactions_file = "transactions.csv"
    @transactions = load_transactions
  end
  
  def add_transaction(amount, category, description)
    transaction = {
      date: Date.today.to_s,
      amount: amount.to_f,
      category: category,
      description: description,
      type: amount > 0 ? "income" : "expense"
    }
    
    @transactions << transaction
    save_transactions
    
    color = amount > 0 ? :green : :red
    puts "✅ Added: #{description} - $#{amount}".colorize(color)
  end
  
  def show_summary
    puts "\n💰 Financial Summary".yellow.bold
    puts "=" * 40
    
    total_income = @transactions.select { |t| t[:type] == "income" }
                                .sum { |t| t[:amount] }
    
    total_expenses = @transactions.select { |t| t[:type] == "expense" }
                                  .sum { |t| t[:amount].abs }
    
    balance = total_income - total_expenses
    
    table = Terminal::Table.new do |t|
      t.headings = ['Category', 'Amount']
      t.rows << ['Total Income', "$#{total_income}".green]
      t.rows << ['Total Expenses', "$#{total_expenses}".red]
      t.rows << ['Balance', balance >= 0 ? "$#{balance}".green : "$#{balance}".red]
    end
    
    puts table
  end
  
  def show_by_category
    puts "\n📊 Spending by Category".blue.bold
    puts "=" * 40
    
    expenses = @transactions.select { |t| t[:type] == "expense" }
    by_category = expenses.group_by { |t| t[:category] }
                         .transform_values { |transactions| 
                           transactions.sum { |t| t[:amount].abs }
                         }
    
    table = Terminal::Table.new do |t|
      t.headings = ['Category', 'Amount', 'Percentage']
      total_expenses = by_category.values.sum
      
      by_category.sort_by { |_, amount| -amount }.each do |category, amount|
        percentage = total_expenses > 0 ? (amount / total_expenses * 100).round(1) : 0
        t.rows << [category.capitalize, "$#{amount}", "#{percentage}%"]
      end
    end
    
    puts table
  end
  
  def show_recent(days = 7)
    puts "\n📅 Recent Transactions (Last #{days} days)".cyan.bold
    puts "=" * 50
    
    cutoff_date = Date.today - days
    recent = @transactions.select do |t|
      Date.parse(t[:date]) >= cutoff_date
    end.sort_by { |t| t[:date] }.reverse
    
    if recent.empty?
      puts "No transactions in the last #{days} days."
      return
    end
    
    table = Terminal::Table.new do |t|
      t.headings = ['Date', 'Description', 'Category', 'Amount']
      
      recent.each do |transaction|
        amount_str = transaction[:type] == "income" ? 
                    "+$#{transaction[:amount]}".green : 
                    "-$#{transaction[:amount].abs}".red
        
        t.rows << [
          transaction[:date],
          transaction[:description],
          transaction[:category],
          amount_str
        ]
      end
    end
    
    puts table
  end
  
  def export_to_json(filename = "transactions.json")
    require 'json'
    
    File.write(filename, JSON.pretty_generate(@transactions))
    puts "✅ Exported #{@transactions.length} transactions to #{filename}".green
  end
  
  private
  
  def load_transactions
    return [] unless File.exist?(@transactions_file)
    
    transactions = []
    CSV.foreach(@transactions_file, headers: true) do |row|
      transactions << {
        date: row['date'],
        amount: row['amount'].to_f,
        category: row['category'],
        description: row['description'],
        type: row['type']
      }
    end
    transactions
  end
  
  def save_transactions
    CSV.open(@transactions_file, "w") do |csv|
      csv << ['date', 'amount', 'category', 'description', 'type']
      @transactions.each do |t|
        csv << [t[:date], t[:amount], t[:category], t[:description], t[:type]]
      end
    end
  end
end

# Finance tracker interface
def run_finance_app
  tracker = FinanceTracker.new
  
  puts "💰 Personal Finance Tracker".rainbow.bold
  puts "=" * 30
  
  loop do
    puts "\nWhat would you like to do?".yellow
    puts "1. Add transaction"
    puts "2. Show summary"
    puts "3. Show by category"
    puts "4. Show recent transactions"
    puts "5. Export to JSON"
    puts "6. Exit"
    
    print "Choose an option: "
    choice = gets.chomp
    
    case choice
    when "1"
      print "Amount (positive for income, negative for expense): $"
      amount = gets.chomp.to_f
      
      print "Category: "
      category = gets.chomp
      
      print "Description: "
      description = gets.chomp
      
      tracker.add_transaction(amount, category, description)
      
    when "2"
      tracker.show_summary
      
    when "3"
      tracker.show_by_category
      
    when "4"
      print "How many days back? (default 7): "
      days = gets.chomp
      days = days.empty? ? 7 : days.to_i
      tracker.show_recent(days)
      
    when "5"
      tracker.export_to_json
      
    when "6"
      puts "Goodbye! 👋".green
      break
      
    else
      puts "Invalid option! Please try again.".red
    end
  end
end

# Uncomment to run the app
# run_finance_app
```

## Finding and Evaluating Gems 🔍

### Where to Find Gems

1. **RubyGems.org** - The official gem repository
2. **GitHub** - Most gems have their source code here
3. **Ruby Toolbox** - Categorized gem directory
4. **Awesome Ruby** - Curated list of great gems

### Evaluating Gems

Before using a gem, check:

```ruby
# In terminal, get gem information
gem list colorize
gem info colorize

# Check gem details
require 'colorize'
puts Gem.loaded_specs['colorize'].version
puts Gem.loaded_specs['colorize'].summary
```

Look for:
- **Recent updates** - actively maintained gems
- **Good documentation** - clear README and examples
- **Many downloads** - popular gems are usually reliable
- **Test coverage** - well-tested gems are more stable
- **GitHub stars** - community approval

## Managing Gems with Bundler 📦

For bigger projects, use Bundler to manage gem dependencies:

```bash
gem install bundler
```

Create a `Gemfile`:

```ruby
# Gemfile
source 'https://rubygems.org'

gem 'colorize'
gem 'httparty'
gem 'terminal-table'
gem 'json'

# Development only gems
group :development do
  gem 'pry'  # Better debugging
end

# Specify versions if needed
gem 'rails', '~> 7.0'
```

Then run:

```bash
bundle install    # Install all gems
bundle update     # Update gems
bundle exec ruby my_app.rb  # Run with specific gem versions
```

## Creating Your Own Gem 💎

You can create your own gems to share with the world!

```bash
# Create a new gem structure
bundle gem my_awesome_gem
```

This creates:
- `lib/` - Your gem's code
- `spec/` - Tests
- `README.md` - Documentation
- `my_awesome_gem.gemspec` - Gem specification

Basic gem structure:

```ruby
# lib/my_awesome_gem.rb
require_relative "my_awesome_gem/version"

module MyAwesomeGem
  class Error < StandardError; end
  
  def self.greet(name)
    "Hello, #{name}! Welcome to my awesome gem! 🎉"
  end
  
  def self.calculate_awesome_score(number)
    number * 42  # Everything is more awesome multiplied by 42!
  end
end
```

```ruby
# lib/my_awesome_gem/version.rb
module MyAwesomeGem
  VERSION = "0.1.0"
end
```

## Gem Best Practices 💡

### 1. Use Semantic Versioning
- `1.0.0` - Major.Minor.Patch
- Major: Breaking changes
- Minor: New features (backward compatible)
- Patch: Bug fixes

### 2. Lock Versions in Production
```ruby
# Gemfile.lock ensures everyone uses same versions
gem 'rails', '7.0.4'  # Exact version
gem 'colorize', '~> 0.8.1'  # Compatible version
```

### 3. Keep Dependencies Minimal
Only add gems you really need - each gem adds complexity.

### 4. Read the Documentation
Always read the gem's README and documentation before using it.

### 5. Update Regularly but Carefully
```bash
bundle outdated  # Check for updates
bundle update    # Update all gems
bundle update colorize  # Update specific gem
```

## Fun Challenges 🎮

### Challenge 1: Quote of the Day App
Create an app that fetches daily quotes from an API and displays them beautifully using gems like `httparty` and `colorize`.

### Challenge 2: File Organizer
Build a tool that organizes files in a directory by type, using gems like `fileutils` and showing progress with a gem like `ruby-progressbar`.

### Challenge 3: CSV Analyzer
Create a program that analyzes CSV files and generates reports using gems like `csv`, `terminal-table`, and `colorize`.

## What's Next? 🚀

Fantastic! You've learned how to leverage the power of the Ruby community by using gems. You now have access to thousands of pre-built solutions that can make your programs incredibly powerful! 💪

Next up, we'll learn about **Testing Your Code** - how to make sure your programs work correctly and keep working as you make changes! 🧪

## Quick Reference 📋

```bash
# Gem commands
gem install gem_name          # Install a gem
gem list                      # List installed gems
gem uninstall gem_name        # Remove a gem
gem update                    # Update all gems
gem search pattern            # Search for gems

# Bundler commands
bundle init                   # Create Gemfile
bundle install               # Install gems from Gemfile
bundle update                # Update gems
bundle exec command          # Run with bundled gems
```

```ruby
# In Ruby code
require 'gem_name'           # Load a gem
require_relative 'file'      # Load local file

# Check gem info
Gem.loaded_specs['gem_name'].version
```

Remember: Gems are like having a team of expert developers helping you build your project! 👥💎

[← Previous: Regular Expressions](./18-regex.md) | [Next: Testing Your Code →](./20-testing.md)
