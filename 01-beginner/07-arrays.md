# Chapter 7: Arrays - Lists of Everything 📝

## 🤔 What Are Arrays?

An array is like a shopping list, a playlist, or a box of crayons - it's a way to store multiple things in order! Think of arrays as containers that can hold many items, and each item has a number (index) that tells you where it is in the list.

```ruby
# Like a shopping list
shopping_list = ["apples", "milk", "bread", "eggs"]

# Like a playlist
favorite_songs = ["Bohemian Rhapsody", "Imagine", "Hotel California"]

# Like a box of numbers
lucky_numbers = [7, 13, 21, 42]

# Arrays can hold different types of things!
mixed_bag = ["hello", 42, true, 3.14, "world"]
```

## 📋 Creating Arrays

There are many ways to create arrays:

```ruby
# Empty array
empty_list = []
also_empty = Array.new

# Array with items
fruits = ["apple", "banana", "orange"]
numbers = [1, 2, 3, 4, 5]

# Array with repeated items
zeros = Array.new(5, 0)  # [0, 0, 0, 0, 0]
letters = Array.new(3, "x")  # ["x", "x", "x"]

# Range to array
one_to_ten = (1..10).to_a  # [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
alphabet = ("a".."z").to_a  # ["a", "b", "c", ..., "z"]

puts fruits.inspect  # ["apple", "banana", "orange"]
puts numbers.length  # 5
```

## 🎯 Accessing Array Items

Arrays use numbers (indexes) to find items. **Important:** Ruby starts counting from 0, not 1!

```ruby
animals = ["cat", "dog", "bird", "fish", "rabbit"]

# Getting items by index (position)
puts animals[0]   # "cat" (first item)
puts animals[1]   # "dog" (second item)
puts animals[4]   # "rabbit" (fifth item)

# Negative indexes count from the end
puts animals[-1]  # "rabbit" (last item)
puts animals[-2]  # "fish" (second to last)

# Getting multiple items (slicing)
puts animals[1, 3].inspect    # ["dog", "bird", "fish"] (3 items starting at index 1)
puts animals[1..3].inspect    # ["dog", "bird", "fish"] (from index 1 to 3)
puts animals[0...3].inspect   # ["cat", "dog", "bird"] (from 0 up to but not including 3)

# Useful methods
puts animals.first    # "cat"
puts animals.last     # "rabbit"
puts animals.length   # 5
puts animals.size     # 5 (same as length)
```

## ➕ Adding Items to Arrays

```ruby
colors = ["red", "blue"]

# Add to the end
colors << "green"              # ["red", "blue", "green"]
colors.push("yellow")          # ["red", "blue", "green", "yellow"]
colors.append("purple")        # ["red", "blue", "green", "yellow", "purple"]

# Add to the beginning
colors.unshift("orange")       # ["orange", "red", "blue", "green", "yellow", "purple"]

# Add at specific position
colors.insert(2, "pink")       # ["orange", "red", "pink", "blue", "green", "yellow", "purple"]

# Add multiple items
colors.push("black", "white")  # Adds both colors
colors += ["gray", "brown"]    # Combines arrays

puts colors.inspect
```

## ➖ Removing Items from Arrays

```ruby
snacks = ["chips", "cookies", "candy", "nuts", "fruit"]

# Remove from end
last_snack = snacks.pop        # Returns "fruit", array becomes ["chips", "cookies", "candy", "nuts"]

# Remove from beginning
first_snack = snacks.shift     # Returns "chips", array becomes ["cookies", "candy", "nuts"]

# Remove by value
snacks.delete("candy")         # Removes "candy", array becomes ["cookies", "nuts"]

# Remove by index
removed = snacks.delete_at(0)  # Removes item at index 0 ("cookies")

# Remove multiple items
snacks.clear                   # Removes everything, array becomes []

puts snacks.inspect
```

## 🔍 Finding Things in Arrays

```ruby
subjects = ["math", "science", "english", "history", "art"]

# Check if item exists
puts subjects.include?("math")     # true
puts subjects.include?("music")    # false

# Find index of item
puts subjects.index("science")     # 1
puts subjects.index("music")       # nil (not found)

# Find item that matches condition
favorite = subjects.find { |subject| subject.length > 6 }
puts favorite  # "science" (first one longer than 6 characters)

# Check if any/all items match condition
has_long_names = subjects.any? { |subject| subject.length > 7 }
puts has_long_names  # true

all_short_names = subjects.all? { |subject| subject.length < 10 }
puts all_short_names  # true
```

## 🎪 Array Magic Methods

### Transforming Arrays with `map`
```ruby
numbers = [1, 2, 3, 4, 5]

# Transform each item
doubled = numbers.map { |num| num * 2 }
puts doubled.inspect  # [2, 4, 6, 8, 10]

squares = numbers.map { |num| num ** 2 }
puts squares.inspect  # [1, 4, 9, 16, 25]

# Transform strings
names = ["alice", "bob", "charlie"]
uppercase_names = names.map { |name| name.upcase }
puts uppercase_names.inspect  # ["ALICE", "BOB", "CHARLIE"]

# Original array is unchanged!
puts numbers.inspect  # [1, 2, 3, 4, 5]

# Use map! to change the original
numbers.map! { |num| num * 10 }
puts numbers.inspect  # [10, 20, 30, 40, 50]
```

### Filtering Arrays with `select` and `reject`
```ruby
ages = [15, 22, 8, 35, 17, 41, 12]

# Select items that match condition
adults = ages.select { |age| age >= 18 }
puts adults.inspect  # [22, 35, 41]

# Reject items that match condition (opposite of select)
minors = ages.reject { |age| age >= 18 }
puts minors.inspect  # [15, 8, 17, 12]

# Filter strings
words = ["hello", "world", "ruby", "programming", "fun"]
long_words = words.select { |word| word.length > 4 }
puts long_words.inspect  # ["hello", "world", "programming"]

short_words = words.reject { |word| word.length > 4 }
puts short_words.inspect  # ["ruby", "fun"]
```

### Reducing Arrays with `reduce`
```ruby
numbers = [1, 2, 3, 4, 5]

# Sum all numbers
total = numbers.reduce(0) { |sum, num| sum + num }
puts total  # 15

# Find the largest number
largest = numbers.reduce { |max, num| num > max ? num : max }
puts largest  # 5

# Multiply all numbers
product = numbers.reduce(1) { |prod, num| prod * num }
puts product  # 120

# Build a sentence
words = ["Ruby", "is", "really", "awesome"]
sentence = words.reduce("") { |text, word| text + word + " " }
puts sentence.strip  # "Ruby is really awesome"

# Shortcuts for common operations
puts numbers.sum     # 15 (same as reduce for addition)
puts numbers.max     # 5
puts numbers.min     # 1
```

## 🎮 Practical Array Examples

### Example 1: Grade Calculator
```ruby
puts "📊 Grade Calculator"
grades = []

# Collect grades
5.times do |i|
  puts "Enter grade #{i + 1}:"
  grade = gets.chomp.to_f
  grades << grade
end

# Calculate statistics
total = grades.sum
average = total / grades.length
highest = grades.max
lowest = grades.min
passing_grades = grades.select { |grade| grade >= 60 }

puts "\n📈 Results:"
puts "Grades: #{grades.map { |g| g.round(1) }}"
puts "Average: #{average.round(2)}"
puts "Highest: #{highest}"
puts "Lowest: #{lowest}"
puts "Passing grades: #{passing_grades.length}/#{grades.length}"

# Letter grades
letter_grades = grades.map do |grade|
  case grade
  when 90..100 then "A"
  when 80...90 then "B"
  when 70...80 then "C"
  when 60...70 then "D"
  else "F"
  end
end

puts "Letter grades: #{letter_grades}"
```

### Example 2: Todo List Manager
```ruby
class SimpleTodoList
  def initialize
    @tasks = []
  end
  
  def add_task(description)
    @tasks << { description: description, done: false, id: @tasks.length + 1 }
    puts "✅ Added: #{description}"
  end
  
  def complete_task(id)
    task = @tasks.find { |t| t[:id] == id }
    if task
      task[:done] = true
      puts "🎉 Completed: #{task[:description]}"
    else
      puts "❌ Task #{id} not found"
    end
  end
  
  def remove_task(id)
    task = @tasks.find { |t| t[:id] == id }
    if task
      @tasks.delete(task)
      puts "🗑️ Removed: #{task[:description]}"
    else
      puts "❌ Task #{id} not found"
    end
  end
  
  def list_tasks
    if @tasks.empty?
      puts "📝 No tasks yet!"
      return
    end
    
    puts "\n📝 Todo List:"
    @tasks.each do |task|
      status = task[:done] ? "✅" : "⏳"
      puts "#{status} #{task[:id]}. #{task[:description]}"
    end
    
    completed = @tasks.select { |t| t[:done] }
    puts "\nProgress: #{completed.length}/#{@tasks.length} completed"
  end
  
  def pending_tasks
    @tasks.reject { |t| t[:done] }
  end
  
  def completed_tasks
    @tasks.select { |t| t[:done] }
  end
end

# Using the todo list
todo = SimpleTodoList.new

todo.add_task("Learn Ruby arrays")
todo.add_task("Practice with examples")
todo.add_task("Build a project")

todo.list_tasks
todo.complete_task(1)
todo.list_tasks
```

### Example 3: Word Game
```ruby
class WordGame
  def initialize
    @words = ["ruby", "programming", "computer", "keyboard", "monitor", 
              "software", "developer", "algorithm", "database", "internet"]
  end
  
  def play_guessing_game
    word = @words.sample.upcase
    guessed_letters = []
    wrong_guesses = 0
    max_wrong = 6
    
    puts "🎮 Word Guessing Game!"
    puts "Guess the #{word.length}-letter word!"
    
    loop do
      # Show current progress
      display = word.chars.map { |letter| guessed_letters.include?(letter) ? letter : "_" }
      puts "\nWord: #{display.join(" ")}"
      puts "Wrong guesses: #{wrong_guesses}/#{max_wrong}"
      puts "Guessed letters: #{guessed_letters.sort.join(", ")}" unless guessed_letters.empty?
      
      # Check win/lose conditions
      if display.join == word
        puts "🎉 You won! The word was #{word}!"
        break
      elsif wrong_guesses >= max_wrong
        puts "😞 You lost! The word was #{word}."
        break
      end
      
      # Get guess
      puts "\nGuess a letter:"
      guess = gets.chomp.upcase
      
      if guess.length != 1 || !guess.match?(/[A-Z]/)
        puts "Please enter a single letter!"
        next
      end
      
      if guessed_letters.include?(guess)
        puts "You already guessed that letter!"
        next
      end
      
      guessed_letters << guess
      
      if word.include?(guess)
        puts "✅ Good guess!"
      else
        wrong_guesses += 1
        puts "❌ Wrong letter!"
      end
    end
  end
  
  def play_word_scramble
    word = @words.sample
    scrambled = word.chars.shuffle.join
    
    puts "🔀 Word Scramble!"
    puts "Unscramble this word: #{scrambled.upcase}"
    puts "Hint: It has #{word.length} letters"
    
    3.times do |attempt|
      puts "\nAttempt #{attempt + 1}/3:"
      guess = gets.chomp.downcase
      
      if guess == word
        puts "🎉 Correct! The word was #{word}!"
        return
      else
        puts "❌ Not quite right!"
      end
    end
    
    puts "😞 The correct word was: #{word}"
  end
end

# Uncomment to play!
# game = WordGame.new
# game.play_guessing_game
```

## 🎨 Advanced Array Tricks

### Sorting Arrays
```ruby
numbers = [5, 2, 8, 1, 9, 3]
words = ["zebra", "apple", "banana", "cat"]

# Sort numbers
puts numbers.sort.inspect     # [1, 2, 3, 5, 8, 9]
puts numbers.sort.reverse.inspect  # [9, 8, 5, 3, 2, 1]

# Sort words
puts words.sort.inspect       # ["apple", "banana", "cat", "zebra"]

# Sort by custom criteria
people = ["Alice", "Bob", "Charlie", "Diana"]
by_length = people.sort_by { |name| name.length }
puts by_length.inspect        # ["Bob", "Alice", "Diana", "Charlie"]

# Sort numbers in descending order
desc_numbers = numbers.sort { |a, b| b <=> a }
puts desc_numbers.inspect     # [9, 8, 5, 3, 2, 1]
```

### Unique Items and Counting
```ruby
letters = ["a", "b", "a", "c", "b", "a", "d"]

# Remove duplicates
unique_letters = letters.uniq
puts unique_letters.inspect   # ["a", "b", "c", "d"]

# Count occurrences
letter_counts = {}
letters.each { |letter| letter_counts[letter] = letters.count(letter) }
puts letter_counts.inspect    # {"a"=>3, "b"=>2, "c"=>1, "d"=>1}

# Using tally (Ruby 2.7+)
puts letters.tally.inspect    # {"a"=>3, "b"=>2, "c"=>1, "d"=>1}
```

### Combining Arrays
```ruby
fruits = ["apple", "banana"]
vegetables = ["carrot", "broccoli"]
grains = ["rice", "wheat"]

# Combine arrays
all_food = fruits + vegetables + grains
puts all_food.inspect

# Flatten nested arrays
nested = [[1, 2], [3, 4], [5, 6]]
flat = nested.flatten
puts flat.inspect             # [1, 2, 3, 4, 5, 6]

# Zip arrays together
names = ["Alice", "Bob", "Charlie"]
ages = [25, 30, 35]
people = names.zip(ages)
puts people.inspect           # [["Alice", 25], ["Bob", 30], ["Charlie", 35]]
```

## 🎉 Array Mastery!

You now know how to:
- ✅ Create arrays and access items by index
- ✅ Add and remove items from arrays
- ✅ Find and filter items with conditions
- ✅ Transform arrays with `map`, `select`, and `reduce`
- ✅ Sort and organize array data
- ✅ Build practical applications with arrays
- ✅ Handle common array operations and tricks

Arrays are fundamental to programming - they help you organize and work with collections of data!

---

## 🚀 What's Next?

Now let's learn about hashes - Ruby's smart dictionaries that store key-value pairs!

**[← Previous: Strings - Playing with Text](./06-strings.md)** | **[Next: Hashes - Smart Dictionaries →](./08-hashes.md)**

---

### 🎯 Array Challenges

Try building these before moving on:
1. **Number Analyzer**: Find statistics (mean, median, mode) for a list of numbers
2. **Word Counter**: Count word frequency in a sentence
3. **Array Sorter**: Sort arrays by different criteria (length, alphabetical, custom)
4. **Inventory Manager**: Track items with quantities using arrays

Arrays are everywhere in programming - master them and you'll be unstoppable! 📝✨
