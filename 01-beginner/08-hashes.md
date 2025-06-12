# Chapter 8: Hashes - Smart Dictionaries 📚

## 🤔 What Are Hashes?

A hash is like a smart dictionary or phonebook! Instead of looking things up by position (like arrays), you look things up by name (called a "key"). Each key points to a value, just like how a word in a dictionary points to its definition.

Think of hashes like:
- 📞 **Phonebook**: Name → Phone number
- 🏠 **Address book**: Person → Address  
- 🎮 **Game character**: Attribute → Value
- 🛒 **Shopping cart**: Item → Quantity

```ruby
# Like a phonebook
contacts = {
  "Alice" => "555-1234",
  "Bob" => "555-5678", 
  "Charlie" => "555-9999"
}

# Like a character sheet
hero = {
  "name" => "Aragorn",
  "level" => 25,
  "health" => 100,
  "strength" => 18
}

puts contacts["Alice"]    # "555-1234"
puts hero["level"]        # 25
```

## 🔑 Creating Hashes

There are several ways to create hashes:

```ruby
# Empty hash
empty_hash = {}
also_empty = Hash.new

# Hash with string keys
person = {
  "name" => "Ruby",
  "age" => 28,
  "city" => "Tokyo"
}

# Hash with symbol keys (more common and faster)
student = {
  :name => "Alice",
  :grade => "A",
  :subject => "Math"
}

# Modern syntax for symbol keys (Ruby 1.9+)
teacher = {
  name: "Mr. Smith",
  subject: "Science", 
  experience: 10
}

# Mixed keys (possible but not recommended)
mixed = {
  "string_key" => "value1",
  :symbol_key => "value2",
  123 => "number key"
}

puts person.inspect
puts student.inspect
puts teacher.inspect
```

## 🎯 Accessing Hash Values

```ruby
inventory = {
  apples: 50,
  bananas: 30,
  oranges: 25,
  grapes: 15
}

# Getting values
puts inventory[:apples]     # 50
puts inventory[:bananas]    # 30

# Getting values with fetch (safer)
puts inventory.fetch(:apples)        # 50
puts inventory.fetch(:mangoes, 0)    # 0 (default if key doesn't exist)

# Check if key exists
puts inventory.key?(:apples)     # true
puts inventory.key?(:mangoes)    # false
puts inventory.has_key?(:oranges) # true (same as key?)

# Get all keys and values
puts inventory.keys.inspect      # [:apples, :bananas, :oranges, :grapes]
puts inventory.values.inspect    # [50, 30, 25, 15]

# Safe access (returns nil if key doesn't exist)
puts inventory[:mangoes]         # nil (no error)
```

## ➕ Adding and Changing Values

```ruby
scores = {
  alice: 95,
  bob: 87,
  charlie: 92
}

# Add new key-value pair
scores[:diana] = 98
scores["eve"] = 89   # String key

# Change existing value
scores[:bob] = 90    # Bob improved!

# Add multiple at once
scores.merge!({
  frank: 85,
  grace: 94
})

puts scores.inspect
```

## ➖ Removing Values

```ruby
menu = {
  burger: 12.99,
  pizza: 15.50,
  salad: 8.75,
  soup: 6.25,
  pasta: 13.25
}

# Remove by key
removed_price = menu.delete(:soup)
puts "Removed soup: $#{removed_price}"

# Remove if condition is met
menu.delete_if { |item, price| price > 15 }

# Remove all items
menu.clear  # Now empty

puts menu.inspect  # {}
```

## 🔄 Iterating Through Hashes

```ruby
grades = {
  math: 95,
  science: 88,
  english: 92,
  history: 85,
  art: 97
}

# Iterate through key-value pairs
grades.each do |subject, grade|
  puts "#{subject.capitalize}: #{grade}%"
end

# Iterate through keys only
grades.each_key do |subject|
  puts "Subject: #{subject}"
end

# Iterate through values only  
grades.each_value do |grade|
  puts "Grade: #{grade}%"
end

# Transform values with map
letter_grades = grades.map do |subject, grade|
  letter = case grade
           when 90..100 then "A"
           when 80..89 then "B" 
           when 70..79 then "C"
           when 60..69 then "D"
           else "F"
           end
  [subject, letter]
end.to_h

puts letter_grades.inspect
```

## 🎪 Hash Magic Methods

### Selecting and Rejecting
```ruby
products = {
  laptop: 999.99,
  mouse: 25.50,
  keyboard: 75.00,
  monitor: 299.99,
  webcam: 89.99
}

# Select items that match condition
expensive = products.select { |item, price| price > 100 }
puts expensive.inspect  # {:laptop=>999.99, :monitor=>299.99}

# Reject items that match condition
affordable = products.reject { |item, price| price > 100 }
puts affordable.inspect  # {:mouse=>25.5, :keyboard=>75.0, :webcam=>89.99}

# Filter by keys
tech_items = products.select { |item, price| item.to_s.include?('e') }
puts tech_items.inspect
```

### Transforming Hashes
```ruby
temperatures_f = {
  monday: 68,
  tuesday: 72,
  wednesday: 75,
  thursday: 70,
  friday: 73
}

# Transform values (Fahrenheit to Celsius)
temperatures_c = temperatures_f.transform_values do |temp_f|
  ((temp_f - 32) * 5.0 / 9.0).round(1)
end

puts temperatures_c.inspect

# Transform keys
temps_short = temperatures_f.transform_keys do |day|
  day.to_s[0..2].upcase  # MON, TUE, WED, etc.
end

puts temps_short.inspect
```

## 🎮 Practical Hash Examples

### Example 1: Student Grade Tracker
```ruby
class GradeTracker
  def initialize
    @students = {}
  end
  
  def add_student(name)
    @students[name] = {}
    puts "✅ Added student: #{name}"
  end
  
  def add_grade(student, subject, grade)
    if @students.key?(student)
      @students[student][subject] = grade
      puts "📝 #{student}: #{subject} = #{grade}%"
    else
      puts "❌ Student #{student} not found!"
    end
  end
  
  def student_average(student)
    if @students.key?(student) && !@students[student].empty?
      grades = @students[student].values
      average = grades.sum / grades.length.to_f
      puts "📊 #{student}'s average: #{average.round(2)}%"
      average
    else
      puts "❌ No grades found for #{student}"
      0
    end
  end
  
  def subject_average(subject)
    all_grades = @students.values
                          .select { |grades| grades.key?(subject) }
                          .map { |grades| grades[subject] }
    
    if all_grades.any?
      average = all_grades.sum / all_grades.length.to_f
      puts "📊 #{subject} class average: #{average.round(2)}%"
      average
    else
      puts "❌ No grades found for #{subject}"
      0
    end
  end
  
  def top_student
    averages = {}
    @students.each do |student, grades|
      next if grades.empty?
      averages[student] = grades.values.sum / grades.values.length.to_f
    end
    
    if averages.any?
      top = averages.max_by { |student, avg| avg }
      puts "🏆 Top student: #{top[0]} with #{top[1].round(2)}%"
      top
    else
      puts "❌ No students with grades"
      nil
    end
  end
  
  def report
    puts "\n📋 Grade Report"
    puts "=" * 40
    
    @students.each do |student, grades|
      puts "\n👤 #{student}:"
      if grades.empty?
        puts "  No grades yet"
      else
        grades.each { |subject, grade| puts "  #{subject}: #{grade}%" }
        avg = grades.values.sum / grades.values.length.to_f
        puts "  Average: #{avg.round(2)}%"
      end
    end
  end
end

# Using the grade tracker
tracker = GradeTracker.new

tracker.add_student("Alice")
tracker.add_student("Bob")
tracker.add_student("Charlie")

tracker.add_grade("Alice", "Math", 95)
tracker.add_grade("Alice", "Science", 88)
tracker.add_grade("Alice", "English", 92)

tracker.add_grade("Bob", "Math", 87)
tracker.add_grade("Bob", "Science", 91)

tracker.add_grade("Charlie", "Math", 93)
tracker.add_grade("Charlie", "English", 89)

tracker.report
tracker.top_student
tracker.subject_average("Math")
```

### Example 2: Inventory Management System
```ruby
class Inventory
  def initialize
    @items = {}
  end
  
  def add_item(name, quantity, price)
    @items[name] = {
      quantity: quantity,
      price: price,
      total_value: quantity * price
    }
    puts "📦 Added: #{quantity}x #{name} at $#{price} each"
  end
  
  def restock(name, quantity)
    if @items.key?(name)
      @items[name][:quantity] += quantity
      @items[name][:total_value] = @items[name][:quantity] * @items[name][:price]
      puts "📈 Restocked #{name}: +#{quantity} (Total: #{@items[name][:quantity]})"
    else
      puts "❌ Item #{name} not found!"
    end
  end
  
  def sell(name, quantity)
    if @items.key?(name)
      if @items[name][:quantity] >= quantity
        @items[name][:quantity] -= quantity
        @items[name][:total_value] = @items[name][:quantity] * @items[name][:price]
        revenue = quantity * @items[name][:price]
        puts "💰 Sold #{quantity}x #{name} for $#{revenue}"
        revenue
      else
        puts "❌ Not enough #{name} in stock! (Have: #{@items[name][:quantity]})"
        0
      end
    else
      puts "❌ Item #{name} not found!"
      0
    end
  end
  
  def low_stock(threshold = 10)
    low_items = @items.select { |name, info| info[:quantity] <= threshold }
    
    if low_items.any?
      puts "⚠️  Low stock items:"
      low_items.each { |name, info| puts "  #{name}: #{info[:quantity]} left" }
    else
      puts "✅ All items well stocked!"
    end
    
    low_items
  end
  
  def total_value
    value = @items.values.sum { |info| info[:total_value] }
    puts "💎 Total inventory value: $#{value}"
    value
  end
  
  def item_report
    puts "\n📊 Inventory Report"
    puts "=" * 50
    
    @items.each do |name, info|
      puts "📦 #{name}:"
      puts "  Quantity: #{info[:quantity]}"
      puts "  Price: $#{info[:price]}"
      puts "  Total Value: $#{info[:total_value]}"
      puts ""
    end
    
    total_value
  end
end

# Using the inventory system
store = Inventory.new

store.add_item("Laptop", 25, 999.99)
store.add_item("Mouse", 100, 25.50)
store.add_item("Keyboard", 50, 75.00)
store.add_item("Monitor", 15, 299.99)

store.sell("Laptop", 3)
store.sell("Mouse", 25)
store.restock("Monitor", 10)

store.low_stock(20)
store.item_report
```

### Example 3: Word Frequency Counter
```ruby
class WordCounter
  def initialize
    @word_counts = {}
  end
  
  def count_words(text)
    # Clean and split the text
    words = text.downcase
                .gsub(/[^\w\s]/, '')  # Remove punctuation
                .split
    
    # Count each word
    words.each do |word|
      @word_counts[word] = @word_counts.fetch(word, 0) + 1
    end
    
    puts "✅ Processed #{words.length} words"
  end
  
  def most_common(n = 10)
    sorted = @word_counts.sort_by { |word, count| -count }
    
    puts "\n🔝 Top #{n} most common words:"
    sorted.first(n).each_with_index do |(word, count), index|
      puts "#{index + 1}. #{word}: #{count} times"
    end
    
    sorted.first(n)
  end
  
  def find_word(word)
    count = @word_counts[word.downcase]
    if count
      puts "🔍 '#{word}' appears #{count} times"
    else
      puts "🔍 '#{word}' not found"
    end
    count
  end
  
  def words_starting_with(letter)
    matching = @word_counts.select { |word, count| word.start_with?(letter.downcase) }
    
    puts "\n📝 Words starting with '#{letter}':"
    matching.each { |word, count| puts "  #{word}: #{count}" }
    
    matching
  end
  
  def statistics
    total_words = @word_counts.values.sum
    unique_words = @word_counts.keys.length
    
    puts "\n📊 Statistics:"
    puts "Total words: #{total_words}"
    puts "Unique words: #{unique_words}"
    puts "Average word frequency: #{(total_words / unique_words.to_f).round(2)}"
  end
end

# Example usage
counter = WordCounter.new

sample_text = "
Ruby is a dynamic programming language. Ruby focuses on simplicity 
and productivity. Ruby has elegant syntax that is natural to read 
and easy to write. Ruby is great for web development, and Ruby 
developers love its flexibility.
"

counter.count_words(sample_text)
counter.most_common(5)
counter.find_word("Ruby")
counter.words_starting_with("r")
counter.statistics
```

## 🎨 Advanced Hash Techniques

### Default Values
```ruby
# Hash with default value
scores = Hash.new(0)  # Default value is 0
scores["Alice"] = 95
puts scores["Alice"]  # 95
puts scores["Bob"]    # 0 (default, not nil)

# Hash with default block
letter_count = Hash.new { |hash, key| hash[key] = 0 }
"hello world".each_char { |char| letter_count[char] += 1 }
puts letter_count.inspect
```

### Nested Hashes
```ruby
school = {
  "Class A" => {
    students: ["Alice", "Bob"],
    teacher: "Ms. Smith",
    subject: "Math"
  },
  "Class B" => {
    students: ["Charlie", "Diana"], 
    teacher: "Mr. Jones",
    subject: "Science"
  }
}

puts school["Class A"][:teacher]    # "Ms. Smith"
puts school["Class B"][:students]   # ["Charlie", "Diana"]
```

### Hash Conversion
```ruby
# Array of arrays to hash
pairs = [["name", "Ruby"], ["age", 28], ["city", "Tokyo"]]
person = pairs.to_h
puts person.inspect  # {"name"=>"Ruby", "age"=>28, "city"=>"Tokyo"}

# Hash to array
person_array = person.to_a
puts person_array.inspect  # [["name", "Ruby"], ["age", 28], ["city", "Tokyo"]]
```

## 🎉 Hash Mastery!

You now know how to:
- ✅ Create hashes with different types of keys
- ✅ Access, add, and remove hash values safely
- ✅ Iterate through hashes in different ways
- ✅ Filter and transform hash data
- ✅ Build practical applications with hashes
- ✅ Use advanced hash features like defaults and nesting
- ✅ Convert between hashes and other data types

Hashes are perfect for storing related data and building lookup tables!

---

## 🚀 What's Next?

Now let's learn about methods - how to create your own reusable commands in Ruby!

**[← Previous: Arrays - Lists of Everything](./07-arrays.md)** | **[Next: Methods - Your Own Commands →](../02-intermediate/09-methods.md)**

---

### 🎯 Hash Challenges

Try building these projects:
1. **Contact Manager**: Store and search contacts with multiple fields
2. **Game Character Stats**: Track health, mana, experience, inventory
3. **Library Catalog**: Books with title, author, genre, availability
4. **Shopping Cart**: Items with quantities, prices, and totals

Hashes help you model real-world data relationships! 📚✨
