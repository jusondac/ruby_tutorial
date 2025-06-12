# Chapter 16: File Operations - Reading and Writing Files 📁

[← Previous: Modules](../02-intermediate/15-modules.md) | [Next: Error Handling →](./17-error-handling.md)

## What Are Files? 📄

Imagine you have a magical filing cabinet in your computer that can store any kind of information - text, numbers, lists, or even pictures! Files are like containers that hold data even when your program stops running. Learning to work with files is like learning to use this magical filing cabinet! 🗃️

In Ruby, working with files is super easy and fun. You can read existing files, create new ones, and even modify them!

## Opening and Closing Files 🚪

Just like opening a real file cabinet, you need to open files before you can use them, and it's polite to close them when you're done:

```ruby
# Opening a file the basic way
file = File.open("hello.txt", "w")  # "w" means write mode
file.write("Hello, World!")
file.close  # Always remember to close!

# Reading a file the basic way
file = File.open("hello.txt", "r")  # "r" means read mode
content = file.read
puts content  # "Hello, World!"
file.close
```

But there's a better way! Ruby can automatically close files for you:

```ruby
# This automatically closes the file when done!
File.open("hello.txt", "w") do |file|
  file.write("Hello, World!")
end  # File closes automatically here!

# Reading with automatic closing
File.open("hello.txt", "r") do |file|
  content = file.read
  puts content
end
```

## File Modes - Different Ways to Open Files 🔑

Think of file modes like different keys for different purposes:

```ruby
# "r" - Read only (default)
File.open("file.txt", "r") { |f| content = f.read }

# "w" - Write only (creates new file or overwrites existing)
File.open("file.txt", "w") { |f| f.write("New content") }

# "a" - Append (adds to the end of existing file)
File.open("file.txt", "a") { |f| f.write("More content") }

# "r+" - Read and write (file must exist)
File.open("file.txt", "r+") { |f| f.write("Update"); content = f.read }

# "w+" - Read and write (creates new or overwrites)
File.open("file.txt", "w+") { |f| f.write("New"); f.rewind; content = f.read }

# "a+" - Read and append
File.open("file.txt", "a+") { |f| f.write("More"); f.rewind; content = f.read }
```

## Reading Files - Different Methods 📖

### Reading the Entire File

```ruby
# Read everything at once
content = File.read("story.txt")
puts content

# Or with a block
File.open("story.txt") do |file|
  content = file.read
  puts "File contains #{content.length} characters"
end
```

### Reading Line by Line

```ruby
# Read all lines into an array
lines = File.readlines("shopping_list.txt")
lines.each_with_index do |line, index|
  puts "#{index + 1}: #{line.chomp}"
end

# Read line by line (memory efficient for large files)
File.open("big_file.txt") do |file|
  file.each_line do |line|
    puts "Processing: #{line.chomp}"
  end
end
```

### Reading Character by Character

```ruby
File.open("text.txt") do |file|
  while char = file.getc
    puts "Character: #{char}"
  end
end
```

## Writing Files - Creating Content ✍️

### Writing Text

```ruby
# Simple writing
File.write("message.txt", "Hello from Ruby! 👋")

# Writing multiple lines
shopping_list = ["Apples 🍎", "Bananas 🍌", "Milk 🥛", "Bread 🍞"]

File.open("shopping.txt", "w") do |file|
  shopping_list.each do |item|
    file.puts item  # puts adds a newline automatically
  end
end

# Appending to a file
File.open("diary.txt", "a") do |file|
  file.puts "#{Date.today}: Today was a great day!"
end
```

### Writing with puts vs write vs print

```ruby
File.open("example.txt", "w") do |file|
  file.write("Hello")     # No newline
  file.write(" World")    # Still same line
  file.print("!")        # No newline  
  file.puts("")          # Adds newline
  file.puts("New line")   # Automatically adds newline
end

# Result: "Hello World!\nNew line\n"
```

## File Manipulation - Moving and Managing Files 🛠️

### Copying Files

```ruby
# Simple copy
File.write("copy.txt", File.read("original.txt"))

# Better copy method
def copy_file(source, destination)
  File.open(source, "r") do |src|
    File.open(destination, "w") do |dest|
      src.each_line { |line| dest.write(line) }
    end
  end
  puts "Copied #{source} to #{destination} ✅"
end

copy_file("important.txt", "backup.txt")
```

### Moving and Renaming Files

```ruby
# Rename a file
File.rename("old_name.txt", "new_name.txt")

# Move a file (works across directories too)
File.rename("file.txt", "documents/file.txt")
```

### Deleting Files

```ruby
# Delete a file (be careful!)
if File.exist?("temporary.txt")
  File.delete("temporary.txt")
  puts "File deleted! 🗑️"
else
  puts "File doesn't exist!"
end
```

## File Information - Detective Work 🔍

Ruby can tell you lots of interesting things about files:

```ruby
filename = "data.txt"

if File.exist?(filename)
  puts "📁 File Information for #{filename}"
  puts "================================="
  
  # Basic info
  puts "Size: #{File.size(filename)} bytes"
  puts "Last modified: #{File.mtime(filename)}"
  puts "Created: #{File.ctime(filename)}"
  puts "Last accessed: #{File.atime(filename)}"
  
  # Permissions
  puts "Readable? #{File.readable?(filename)}"
  puts "Writable? #{File.writable?(filename)}"
  puts "Executable? #{File.executable?(filename)}"
  
  # Type checks
  puts "Is a file? #{File.file?(filename)}"
  puts "Is a directory? #{File.directory?(filename)}"
  puts "Is empty? #{File.zero?(filename)}"
else
  puts "File #{filename} doesn't exist! 😞"
end
```

## Working with Directories 📂

### Creating and Managing Directories

```ruby
# Create a directory
Dir.mkdir("my_folder") unless Dir.exist?("my_folder")

# Create nested directories
require 'fileutils'
FileUtils.mkdir_p("projects/ruby/tutorial")

# List files in a directory
puts "Files in current directory:"
Dir.foreach(".") do |filename|
  puts "- #{filename}" unless filename.start_with?(".")
end

# Get all files matching a pattern
ruby_files = Dir.glob("*.rb")
puts "Ruby files: #{ruby_files}"

# Change directory
original_dir = Dir.pwd
puts "Currently in: #{original_dir}"

Dir.chdir("my_folder") do
  puts "Now in: #{Dir.pwd}"
  # Do work in the folder
end

puts "Back in: #{Dir.pwd}"
```

## Real-World Examples 🌍

### Personal Diary Application

```ruby
class Diary
  def initialize
    @diary_file = "my_diary.txt"
    create_diary_if_needed
  end
  
  def add_entry(content)
    File.open(@diary_file, "a") do |file|
      file.puts "\n" + "=" * 40
      file.puts "📅 #{Time.now.strftime('%Y-%m-%d %H:%M:%S')}"
      file.puts "=" * 40
      file.puts content
    end
    puts "Diary entry added! ✅"
  end
  
  def read_diary
    if File.exist?(@diary_file)
      puts File.read(@diary_file)
    else
      puts "No diary entries yet! Start writing! 📝"
    end
  end
  
  def count_entries
    return 0 unless File.exist?(@diary_file)
    
    content = File.read(@diary_file)
    entries = content.scan(/📅/).length
    puts "You have #{entries} diary entries! 📚"
    entries
  end
  
  def search_entries(keyword)
    return unless File.exist?(@diary_file)
    
    puts "🔍 Searching for '#{keyword}'..."
    found_entries = []
    
    File.readlines(@diary_file).each_with_index do |line, index|
      if line.downcase.include?(keyword.downcase)
        found_entries << "Line #{index + 1}: #{line.chomp}"
      end
    end
    
    if found_entries.empty?
      puts "No entries found containing '#{keyword}' 😞"
    else
      puts "Found #{found_entries.length} matches:"
      found_entries.each { |entry| puts entry }
    end
  end
  
  private
  
  def create_diary_if_needed
    unless File.exist?(@diary_file)
      File.write(@diary_file, "📖 My Personal Diary 📖\n")
      puts "New diary created! 🎉"
    end
  end
end

# Use the diary
diary = Diary.new

puts "📖 Personal Diary Application"
puts "1. Add entry"
puts "2. Read diary" 
puts "3. Count entries"
puts "4. Search entries"

case gets.chomp
when "1"
  print "Write your diary entry: "
  entry = gets.chomp
  diary.add_entry(entry)
when "2"
  diary.read_diary
when "3"
  diary.count_entries
when "4"
  print "Search for: "
  keyword = gets.chomp
  diary.search_entries(keyword)
end
```

### Todo List Manager

```ruby
class TodoList
  def initialize
    @todo_file = "todos.txt"
    load_todos
  end
  
  def add_todo(task)
    @todos << { task: task, completed: false, created: Time.now }
    save_todos
    puts "✅ Added: #{task}"
  end
  
  def complete_todo(index)
    if valid_index?(index)
      @todos[index][:completed] = true
      @todos[index][:completed_at] = Time.now
      save_todos
      puts "🎉 Completed: #{@todos[index][:task]}"
    else
      puts "❌ Invalid todo number!"
    end
  end
  
  def remove_todo(index)
    if valid_index?(index)
      removed = @todos.delete_at(index)
      save_todos
      puts "🗑️ Removed: #{removed[:task]}"
    else
      puts "❌ Invalid todo number!"
    end
  end
  
  def list_todos
    if @todos.empty?
      puts "No todos yet! Add some tasks! 📝"
      return
    end
    
    puts "\n📋 Your Todo List"
    puts "=================="
    
    @todos.each_with_index do |todo, index|
      status = todo[:completed] ? "✅" : "⏳"
      puts "#{index + 1}. #{status} #{todo[:task]}"
      
      if todo[:completed]
        puts "   Completed: #{todo[:completed_at].strftime('%Y-%m-%d %H:%M')}"
      end
    end
  end
  
  def stats
    total = @todos.length
    completed = @todos.count { |todo| todo[:completed] }
    pending = total - completed
    
    puts "\n📊 Todo Statistics"
    puts "=================="
    puts "Total tasks: #{total}"
    puts "Completed: #{completed}"
    puts "Pending: #{pending}"
    puts "Completion rate: #{total > 0 ? (completed * 100.0 / total).round(1) : 0}%"
  end
  
  private
  
  def load_todos
    @todos = []
    
    if File.exist?(@todo_file)
      File.readlines(@todo_file).each do |line|
        # Simple CSV format: task,completed,created_time
        parts = line.chomp.split(",", 3)
        if parts.length >= 3
          @todos << {
            task: parts[0],
            completed: parts[1] == "true",
            created: Time.parse(parts[2])
          }
        end
      end
    end
  end
  
  def save_todos
    File.open(@todo_file, "w") do |file|
      @todos.each do |todo|
        file.puts "#{todo[:task]},#{todo[:completed]},#{todo[:created]}"
      end
    end
  end
  
  def valid_index?(index)
    index >= 0 && index < @todos.length
  end
end

# Simple todo app interface
todo_list = TodoList.new

loop do
  puts "\n🎯 Todo List Manager"
  puts "1. Add todo"
  puts "2. List todos"
  puts "3. Complete todo"
  puts "4. Remove todo"
  puts "5. Show statistics"
  puts "6. Exit"
  
  print "Choose an option: "
  choice = gets.chomp
  
  case choice
  when "1"
    print "Enter new todo: "
    task = gets.chomp
    todo_list.add_todo(task)
  when "2"
    todo_list.list_todos
  when "3"
    todo_list.list_todos
    print "Enter todo number to complete: "
    index = gets.chomp.to_i - 1
    todo_list.complete_todo(index)
  when "4"
    todo_list.list_todos
    print "Enter todo number to remove: "
    index = gets.chomp.to_i - 1
    todo_list.remove_todo(index)
  when "5"
    todo_list.stats
  when "6"
    puts "Goodbye! 👋"
    break
  else
    puts "Invalid option! Try again."
  end
end
```

### Configuration File Manager

```ruby
class Config
  def initialize(config_file = "app_config.txt")
    @config_file = config_file
    @settings = {}
    load_config
  end
  
  def set(key, value)
    @settings[key.to_s] = value
    save_config
    puts "✅ Set #{key} = #{value}"
  end
  
  def get(key, default = nil)
    @settings[key.to_s] || default
  end
  
  def remove(key)
    if @settings.delete(key.to_s)
      save_config
      puts "🗑️ Removed #{key}"
    else
      puts "❌ #{key} not found"
    end
  end
  
  def list_all
    if @settings.empty?
      puts "No configuration settings yet!"
      return
    end
    
    puts "\n⚙️ Configuration Settings"
    puts "=========================="
    @settings.each { |key, value| puts "#{key}: #{value}" }
  end
  
  def backup(backup_file = nil)
    backup_file ||= "#{@config_file}.backup.#{Time.now.strftime('%Y%m%d_%H%M%S')}"
    File.write(backup_file, File.read(@config_file))
    puts "💾 Backup created: #{backup_file}"
  end
  
  private
  
  def load_config
    return unless File.exist?(@config_file)
    
    File.readlines(@config_file).each do |line|
      line = line.chomp
      next if line.empty? || line.start_with?("#")  # Skip comments
      
      key, value = line.split("=", 2)
      @settings[key.strip] = value&.strip
    end
  end
  
  def save_config
    File.open(@config_file, "w") do |file|
      file.puts "# Application Configuration"
      file.puts "# Generated on #{Time.now}"
      file.puts ""
      
      @settings.each do |key, value|
        file.puts "#{key}=#{value}"
      end
    end
  end
end

# Example usage
config = Config.new

config.set("app_name", "My Awesome App")
config.set("version", "1.0.0")
config.set("debug_mode", "true")

puts "App name: #{config.get('app_name', 'Unknown')}"
config.list_all
```

## File Safety and Best Practices 🛡️

### 1. Always Handle Missing Files

```ruby
def safe_read_file(filename)
  if File.exist?(filename)
    File.read(filename)
  else
    puts "⚠️ File #{filename} not found!"
    nil
  end
end
```

### 2. Use Blocks for Automatic Cleanup

```ruby
# Good - automatically closes file
File.open("data.txt", "w") do |file|
  file.write("Some data")
end

# Avoid - you might forget to close
file = File.open("data.txt", "w")
file.write("Some data")
file.close  # Easy to forget!
```

### 3. Backup Important Files

```ruby
def safe_modify_file(filename)
  # Create backup first
  if File.exist?(filename)
    backup_name = "#{filename}.backup"
    File.write(backup_name, File.read(filename))
    puts "📦 Backup created: #{backup_name}"
  end
  
  # Now safely modify the file
  yield filename if block_given?
end

safe_modify_file("important.txt") do |file|
  File.write(file, "New content")
end
```

## Fun Challenges 🎮

### Challenge 1: File Statistics
Create a program that analyzes a text file and tells you:
- Number of lines, words, and characters
- Most common words
- Longest and shortest lines

### Challenge 2: Simple File Organizer
Create a program that organizes files in a directory by:
- Moving images to an "images" folder
- Moving text files to a "documents" folder
- Creating a report of what was moved

### Challenge 3: Log File Analyzer
Create a program that reads log files and finds:
- Error messages
- Most active hours
- Unique IP addresses

## What's Next? 🚀

Excellent work! You've learned how to read, write, and manage files - essential skills for any real application. Now your programs can remember things even after they stop running! 💾

Next up, we'll learn about **Error Handling** - how to deal with things that go wrong gracefully, like when files don't exist or something unexpected happens! 🛡️

## Quick Reference 📋

```ruby
# Reading files
File.read("file.txt")               # Read entire file
File.readlines("file.txt")          # Read as array of lines
File.open("file.txt") { |f| ... }   # Read with block

# Writing files
File.write("file.txt", "content")   # Write entire file
File.open("file.txt", "w") { |f| f.puts "line" }

# File operations
File.exist?("file.txt")             # Check if exists
File.size("file.txt")               # Get file size
File.delete("file.txt")             # Delete file
File.rename("old.txt", "new.txt")   # Rename/move

# Directory operations
Dir.mkdir("folder")                 # Create directory
Dir.exist?("folder")                # Check if exists
Dir.glob("*.txt")                   # Find matching files
Dir.foreach(".") { |f| puts f }     # List directory contents
```

Remember: Files are like magical containers that keep your data safe even when your program sleeps! 📁✨

[← Previous: Modules](../02-intermediate/15-modules.md) | [Next: Error Handling →](./17-error-handling.md)
