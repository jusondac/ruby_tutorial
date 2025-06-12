# Chapter 26: Monkey Patching 🐒

## 🤔 What is Monkey Patching?

Monkey patching is like being able to add new features to your friend's toys! In Ruby, you can add new methods to existing classes - even built-in classes like String, Array, and Integer - while your program is running.

Think of it like this:
- 🏠 **Normal situation**: You can only use the rooms that came with your house
- 🔨 **Monkey patching**: You can add new rooms to any house, even ones you didn't build!

```ruby
# Add a new method to the String class
class String
  def palindrome?
    self == self.reverse
  end
end

# Now ALL strings have this method!
puts "racecar".palindrome?  # true
puts "hello".palindrome?    # false
puts "madam".palindrome?    # true
```

## 🎯 Simple Monkey Patching Examples

### Adding Methods to Numbers
```ruby
class Integer
  def even?
    self % 2 == 0
  end
  
  def odd?
    self % 2 != 0
  end
  
  def factorial
    return 1 if self <= 1
    (1..self).reduce(:*)
  end
  
  def squared
    self * self
  end
  
  def cubed
    self * self * self
  end
end

# Now all integers have these methods!
puts 5.even?      # false
puts 6.even?      # true
puts 5.odd?       # true
puts 5.factorial  # 120
puts 4.squared    # 16
puts 3.cubed      # 27
```

### Adding Methods to Strings
```ruby
class String
  def word_count
    self.split.length
  end
  
  def vowel_count
    self.downcase.count("aeiou")
  end
  
  def consonant_count
    self.downcase.count("bcdfghjklmnpqrstvwxyz")
  end
  
  def title_case
    self.split.map(&:capitalize).join(' ')
  end
  
  def pig_latin
    if self.start_with?(/[aeiou]/i)
      self + "way"
    else
      self[1..-1] + self[0] + "ay"
    end
  end
  
  def reverse_words
    self.split.reverse.join(' ')
  end
end

text = "hello world ruby programming"

puts text.word_count      # 4
puts text.vowel_count     # 8
puts text.title_case      # "Hello World Ruby Programming"
puts "hello".pig_latin    # "ello-hay"
puts text.reverse_words   # "programming ruby world hello"
```

### Adding Methods to Arrays
```ruby
class Array
  def average
    return 0 if self.empty?
    self.sum / self.length.to_f
  end
  
  def median
    return 0 if self.empty?
    sorted = self.sort
    middle = sorted.length / 2
    
    if sorted.length.odd?
      sorted[middle]
    else
      (sorted[middle - 1] + sorted[middle]) / 2.0
    end
  end
  
  def mode
    frequency = self.each_with_object(Hash.new(0)) { |item, hash| hash[item] += 1 }
    frequency.max_by { |item, count| count }&.first
  end
  
  def shuffle!
    self.length.times do |i|
      j = rand(i..self.length - 1)
      self[i], self[j] = self[j], self[i]
    end
    self
  end
  
  def random_sample(n = 1)
    self.sample(n)
  end
end

numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

puts numbers.average     # 5.5
puts numbers.median      # 5.5
puts [1, 2, 2, 3, 3, 3].mode  # 3
puts numbers.random_sample(3).inspect
```

## 🎮 Practical Monkey Patching: Game Extensions

```ruby
# Extend Hash for game character stats
class Hash
  def modify_stat(stat, amount)
    self[stat] = (self[stat] || 0) + amount
    self[stat] = 0 if self[stat] < 0  # Don't go below 0
    self
  end
  
  def reset_stat(stat, value = 0)
    self[stat] = value
    self
  end
  
  def total_stats
    self.values.sum
  end
  
  def highest_stat
    self.max_by { |stat, value| value }
  end
  
  def lowest_stat
    self.min_by { |stat, value| value }
  end
end

# Game character using enhanced hashes
character = {
  health: 100,
  mana: 50,
  strength: 15,
  agility: 12,
  intelligence: 18
}

puts "Original stats: #{character}"

character.modify_stat(:health, -20)   # Take damage
character.modify_stat(:mana, -10)     # Use mana
character.modify_stat(:strength, 2)   # Level up strength

puts "After battle: #{character}"
puts "Total stats: #{character.total_stats}"
puts "Highest stat: #{character.highest_stat}"
puts "Lowest stat: #{character.lowest_stat}"
```

## 🛠️ Utility Extensions for Development

```ruby
# Extend Object for debugging
class Object
  def debug_info
    puts "Object: #{self.inspect}"
    puts "Class: #{self.class}"
    puts "Methods: #{self.methods(false).sort}" if self.respond_to?(:methods)
    self  # Return self for chaining
  end
  
  def try_method(method_name, *args)
    if self.respond_to?(method_name)
      self.send(method_name, *args)
    else
      puts "Method #{method_name} not available for #{self.class}"
      nil
    end
  end
end

# Extend Numeric for formatting
class Numeric
  def currency(symbol = "$")
    "#{symbol}#{sprintf('%.2f', self)}"
  end
  
  def percentage
    "#{(self * 100).round(2)}%"
  end
  
  def ordinal
    case self % 100
    when 11, 12, 13
      "#{self}th"
    else
      case self % 10
      when 1 then "#{self}st"
      when 2 then "#{self}nd"
      when 3 then "#{self}rd"
      else "#{self}th"
      end
    end
  end
  
  def human_readable
    case self
    when 0...1_000
      self.to_s
    when 1_000...1_000_000
      "#{(self / 1_000.0).round(1)}K"
    when 1_000_000...1_000_000_000
      "#{(self / 1_000_000.0).round(1)}M"
    else
      "#{(self / 1_000_000_000.0).round(1)}B"
    end
  end
end

# Using the extensions
price = 19.99
puts price.currency         # $19.99
puts price.currency("€")    # €19.99

rate = 0.125
puts rate.percentage        # 12.5%

position = 23
puts position.ordinal       # 23rd

views = 1_250_000
puts views.human_readable   # 1.3M

"Hello".debug_info
```

## 🎪 Creative Monkey Patching: DSL Creation

```ruby
# Extend String for configuration DSL
class String
  def minutes
    self.to_i * 60
  end
  
  def hours
    self.to_i * 60 * 60
  end
  
  def days
    self.to_i * 60 * 60 * 24
  end
  
  def kilobytes
    self.to_i * 1024
  end
  
  def megabytes
    self.to_i * 1024 * 1024
  end
  
  def gigabytes
    self.to_i * 1024 * 1024 * 1024
  end
end

# Extend Fixnum/Integer for the same
class Integer
  def minutes
    self * 60
  end
  
  def hours
    self * 60 * 60
  end
  
  def days
    self * 60 * 60 * 24
  end
  
  def kilobytes
    self * 1024
  end
  
  def megabytes
    self * 1024 * 1024
  end
  
  def gigabytes
    self * 1024 * 1024 * 1024
  end
end

# Now you can write expressive configuration
cache_timeout = 30.minutes
session_duration = 2.hours
backup_interval = 1.days

max_file_size = 10.megabytes
storage_limit = 1.gigabytes

puts "Cache timeout: #{cache_timeout} seconds"
puts "Session duration: #{session_duration} seconds"
puts "Max file size: #{max_file_size} bytes"
```

## 🎯 Building a Custom Collection Class

```ruby
# Extend Array for specialized collections
class Array
  def to_sentence
    case self.length
    when 0
      ""
    when 1
      self.first.to_s
    when 2
      "#{self.first} and #{self.last}"
    else
      "#{self[0..-2].join(', ')}, and #{self.last}"
    end
  end
  
  def frequencies
    self.each_with_object(Hash.new(0)) { |item, hash| hash[item] += 1 }
  end
  
  def split_by(&block)
    matches = []
    non_matches = []
    
    self.each do |item|
      if block.call(item)
        matches << item
      else
        non_matches << item
      end
    end
    
    [matches, non_matches]
  end
  
  def deep_flatten
    result = []
    self.each do |item|
      if item.is_a?(Array)
        result.concat(item.deep_flatten)
      else
        result << item
      end
    end
    result
  end
end

# Using enhanced arrays
fruits = ["apple", "banana", "cherry"]
puts fruits.to_sentence  # "apple, banana, and cherry"

numbers = [1, 2, 2, 3, 3, 3, 4, 4, 4, 4]
puts numbers.frequencies.inspect  # {1=>1, 2=>2, 3=>3, 4=>4}

mixed = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
evens, odds = mixed.split_by(&:even?)
puts "Evens: #{evens.inspect}"  # [2, 4, 6, 8, 10]
puts "Odds: #{odds.inspect}"    # [1, 3, 5, 7, 9]

nested = [1, [2, [3, 4]], 5, [6]]
puts nested.deep_flatten.inspect  # [1, 2, 3, 4, 5, 6]
```

## ⚠️ Monkey Patching Dangers

### 1. Breaking Existing Code
```ruby
# DANGEROUS - This could break other code!
class String
  def length  # Overriding existing method
    "I don't know!"
  end
end

puts "hello".length  # "I don't know!" instead of 5
```

### 2. Conflicts with Libraries
```ruby
# Your method might conflict with a gem's method
class Array
  def enhanced_map  # Better to use unique names
    # Your implementation
  end
end
```

### 3. Debugging Difficulties
```ruby
# When code breaks, it's hard to trace back to monkey patches
class Object
  def mysterious_method
    # Where did this come from?
  end
end
```

## 🛡️ Safe Monkey Patching Practices

### 1. Check if Method Already Exists
```ruby
class String
  unless method_defined?(:palindrome?)
    def palindrome?
      self == self.reverse
    end
  end
end
```

### 2. Use Modules and Include
```ruby
module StringExtensions
  def palindrome?
    self == self.reverse
  end
  
  def word_count
    self.split.length
  end
end

# Safer - you can control what gets included
String.include(StringExtensions)
```

### 3. Create Refinements (Ruby 2.0+)
```ruby
module StringRefinements
  refine String do
    def palindrome?
      self == self.reverse
    end
  end
end

class MyClass
  using StringRefinements  # Only active in this class
  
  def test_palindrome
    "racecar".palindrome?  # Works here
  end
end

# "racecar".palindrome?  # Error! Not available outside
```

### 4. Namespace Your Extensions
```ruby
module MyApp
  module Extensions
    module String
      def my_custom_method
        # Your implementation
      end
    end
  end
end

String.include(MyApp::Extensions::String)
```

## 🎉 Monkey Patching Mastery!

You now understand:
- ✅ How to add methods to existing classes
- ✅ Extending built-in classes (String, Array, Integer, etc.)
- ✅ Creating utility extensions for development
- ✅ Building DSLs with monkey patching
- ✅ The dangers and risks of monkey patching
- ✅ Safe practices for extending classes
- ✅ Using modules and refinements as alternatives

Monkey patching is powerful but should be used responsibly!

---

## 🚀 What's Next?

Let's explore hooks and callbacks - code that runs automatically at specific times!

**[← Previous: Class Methods and Variables](./25-class-methods.md)** | **[Next: Hooks and Callbacks →](./27-hooks-callbacks.md)**

---

### 🎯 Monkey Patching Challenges

Try these (safely!):
1. **Time Extensions**: Add methods like `5.minutes.ago`, `3.days.from_now`
2. **Collection Utilities**: Add useful methods to Array and Hash
3. **String Validators**: Add validation methods like `valid_email?`, `valid_phone?`
4. **Number Formatters**: Add formatting methods for currency, percentages, etc.

Remember: With great power comes great responsibility! 🐒✨
