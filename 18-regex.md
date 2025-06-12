# Chapter 18: Regular Expressions - Pattern Hunting 🔍

[← Previous: Error Handling](./17-error-handling.md) | [Next: Gems and Libraries →](./19-gems.md)

## What Are Regular Expressions? 🧩

Imagine you're a detective looking for clues in a huge book! You need to find all the phone numbers, email addresses, or dates. Instead of reading every single word, you could use a magical pattern-finder that says "Find me anything that looks like a phone number!" That's exactly what Regular Expressions (regex) do! 🕵️‍♂️

Regular expressions are like super-smart search patterns that can find complex text patterns in strings. They're incredibly powerful but can look scary at first - don't worry, we'll start simple!

## Your First Regular Expression 🎯

In Ruby, regular expressions are created with forward slashes `/pattern/`:

```ruby
# Simple pattern matching
text = "Hello, my phone number is 555-1234"

# Look for the pattern "555"
if text =~ /555/  # The =~ operator checks if pattern matches
  puts "Found 555 in the text! 🎉"
end

# Extract the match
match = text.match(/\d{3}-\d{4}/)  # \d means digit, {3} means exactly 3 times
if match
  puts "Found phone number: #{match[0]}"  # "555-1234"
end
```

## Basic Pattern Elements 🔤

### Literal Characters
These match exactly what you write:

```ruby
text = "I love Ruby programming!"

puts text.match(/Ruby/)     # Matches "Ruby"
puts text.match(/love/)     # Matches "love"
puts text.match(/Python/)  # nil (no match)
```

### Special Characters - The Magic Symbols ✨

```ruby
# . (dot) - matches any single character
"cat".match(/c.t/)     # matches "cat"
"cut".match(/c.t/)     # matches "cut"
"coat".match(/c.t/)    # no match (too many characters)

# ^ - matches start of string
"hello world".match(/^hello/)  # matches
"say hello".match(/^hello/)    # no match

# $ - matches end of string
"hello world".match(/world$/)  # matches
"world peace".match(/world$/)  # no match

# * - matches 0 or more of the previous character
"gooooal!".match(/go*al/)      # matches (any number of 'o's)
"gal".match(/go*al/)           # matches (zero 'o's)

# + - matches 1 or more of the previous character
"gooooal!".match(/go+al/)      # matches (one or more 'o's)
"gal".match(/go+al/)           # no match (needs at least one 'o')

# ? - matches 0 or 1 of the previous character
"color".match(/colou?r/)       # matches "color"
"colour".match(/colou?r/)      # matches "colour"
"colouur".match(/colou?r/)     # no match (too many 'u's)
```

## Character Classes - Finding Specific Types 📝

```ruby
# \d - matches any digit (0-9)
"I have 5 cats".match(/\d/)         # matches "5"
"No pets here".match(/\d/)          # no match

# \w - matches word characters (letters, digits, underscore)
"hello_world123".match(/\w+/)       # matches entire string

# \s - matches whitespace (space, tab, newline)
"hello world".match(/\s/)           # matches the space

# [abc] - matches any one of the characters inside brackets
"cat".match(/[abc]at/)              # matches "cat"
"bat".match(/[abc]at/)              # matches "bat"
"rat".match(/[abc]at/)              # no match

# [a-z] - matches any lowercase letter
"Hello".match(/[a-z]/)              # matches "e", "l", "l", "o"

# [A-Z] - matches any uppercase letter
"Hello".match(/[A-Z]/)              # matches "H"

# [0-9] - matches any digit (same as \d)
"I'm 25 years old".match(/[0-9]+/)  # matches "25"

# [^abc] - matches anything EXCEPT what's in brackets
"dog".match(/[^abc]/)               # matches "d" (not a, b, or c)
```

## Quantifiers - How Many Times? 🔢

```ruby
# {n} - exactly n times
"hello".match(/l{2}/)               # matches "ll"
"helo".match(/l{2}/)                # no match

# {n,m} - between n and m times
"goooooal".match(/o{2,4}/)          # matches "oooo"

# {n,} - n or more times
"goooooal".match(/o{3,}/)           # matches "ooooo"

# \d{3}-\d{3}-\d{4} - phone number pattern
"Call me at 555-123-4567".match(/\d{3}-\d{3}-\d{4}/)  # matches phone number
```

## Groups and Capturing 📦

Parentheses create groups that you can extract:

```ruby
# Capture groups with parentheses
text = "My email is john@example.com"
match = text.match(/(\w+)@(\w+\.\w+)/)

if match
  puts "Full match: #{match[0]}"    # "john@example.com"
  puts "Username: #{match[1]}"      # "john"
  puts "Domain: #{match[2]}"        # "example.com"
end

# Named groups (more readable)
text = "Born on 1990-12-25"
match = text.match(/(?<year>\d{4})-(?<month>\d{2})-(?<day>\d{2})/)

if match
  puts "Year: #{match[:year]}"      # "1990"
  puts "Month: #{match[:month]}"    # "12"
  puts "Day: #{match[:day]}"        # "25"
end
```

## Common Regex Methods in Ruby 🛠️

### `match` - Find First Match
```ruby
text = "I have 3 cats and 2 dogs"
match = text.match(/\d+/)
puts match[0] if match  # "3"
```

### `scan` - Find All Matches
```ruby
text = "I have 3 cats and 2 dogs"
numbers = text.scan(/\d+/)
puts numbers  # ["3", "2"]

# With groups
text = "Emails: john@gmail.com, mary@yahoo.com"
emails = text.scan(/(\w+)@(\w+\.\w+)/)
puts emails   # [["john", "gmail.com"], ["mary", "yahoo.com"]]
```

### `gsub` - Replace Matches
```ruby
text = "I have 3 cats and 2 dogs"

# Replace all numbers with "many"
new_text = text.gsub(/\d+/, "many")
puts new_text  # "I have many cats and many dogs"

# Replace with captured groups
text = "Call 555-1234 or 555-5678"
formatted = text.gsub(/(\d{3})-(\d{4})/, '(\1) \2')
puts formatted  # "Call (555) 1234 or (555) 5678"
```

### `split` - Split by Pattern
```ruby
text = "apple,banana;orange:grape"
fruits = text.split(/[,:;]/)  # Split by comma, colon, or semicolon
puts fruits  # ["apple", "banana", "orange", "grape"]
```

## Real-World Examples 🌍

### Email Validator

```ruby
class EmailValidator
  EMAIL_PATTERN = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  
  def self.valid?(email)
    email.match?(EMAIL_PATTERN)
  end
  
  def self.extract_parts(email)
    match = email.match(/\A(?<username>[\w+\-.]+)@(?<domain>[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+)\z/i)
    return nil unless match
    
    {
      username: match[:username],
      domain: match[:domain],
      valid: true
    }
  end
end

# Test emails
emails = [
  "john@example.com",
  "mary.jane+work@company.co.uk", 
  "invalid.email",
  "test@domain",
  "user@sub.domain.com"
]

emails.each do |email|
  if EmailValidator.valid?(email)
    parts = EmailValidator.extract_parts(email)
    puts "✅ #{email} - Username: #{parts[:username]}, Domain: #{parts[:domain]}"
  else
    puts "❌ #{email} - Invalid email format"
  end
end
```

### Phone Number Formatter

```ruby
class PhoneFormatter
  # US phone number patterns
  PATTERNS = [
    /\A(\d{3})-(\d{3})-(\d{4})\z/,           # 555-123-4567
    /\A\((\d{3})\)\s*(\d{3})-(\d{4})\z/,     # (555) 123-4567
    /\A(\d{3})\.(\d{3})\.(\d{4})\z/,         # 555.123.4567
    /\A(\d{10})\z/,                          # 5551234567
    /\A1-(\d{3})-(\d{3})-(\d{4})\z/          # 1-555-123-4567
  ]
  
  def self.format(phone)
    # Remove all non-digits first
    digits = phone.gsub(/\D/, '')
    
    # Handle different digit counts
    case digits.length
    when 10
      format_ten_digits(digits)
    when 11
      if digits.start_with?('1')
        format_ten_digits(digits[1..-1])
      else
        "Invalid: 11 digits but doesn't start with 1"
      end
    else
      "Invalid: #{digits.length} digits (need 10 or 11)"
    end
  end
  
  def self.format_ten_digits(digits)
    "(#{digits[0..2]}) #{digits[3..5]}-#{digits[6..9]}"
  end
  
  def self.extract_area_code(phone)
    # Try each pattern
    PATTERNS.each do |pattern|
      match = phone.match(pattern)
      return match[1] if match
    end
    
    # Try extracting from formatted phone
    digits = phone.gsub(/\D/, '')
    return digits[0..2] if digits.length >= 10
    
    nil
  end
end

# Test phone numbers
phones = [
  "555-123-4567",
  "(555) 123-4567",
  "555.123.4567", 
  "5551234567",
  "1-555-123-4567",
  "555 123 4567",
  "invalid"
]

phones.each do |phone|
  formatted = PhoneFormatter.format(phone)
  area_code = PhoneFormatter.extract_area_code(phone)
  puts "#{phone.ljust(15)} -> #{formatted.ljust(15)} (Area: #{area_code})"
end
```

### Log File Analyzer

```ruby
class LogAnalyzer
  # Log pattern: [2023-12-25 14:30:15] ERROR: Database connection failed
  LOG_PATTERN = /\[(?<timestamp>\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2})\] (?<level>\w+): (?<message>.*)/
  
  # IP address pattern
  IP_PATTERN = /\b(?<ip>\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3})\b/
  
  def initialize(log_content)
    @log_content = log_content
    @entries = parse_logs
  end
  
  def parse_logs
    entries = []
    @log_content.each_line do |line|
      match = line.match(LOG_PATTERN)
      if match
        entries << {
          timestamp: match[:timestamp],
          level: match[:level],
          message: match[:message],
          raw: line.chomp
        }
      end
    end
    entries
  end
  
  def errors_only
    @entries.select { |entry| entry[:level] == 'ERROR' }
  end
  
  def find_ip_addresses
    ip_addresses = Set.new
    @entries.each do |entry|
      ips = entry[:message].scan(IP_PATTERN).flatten
      ip_addresses.merge(ips)
    end
    ip_addresses.to_a
  end
  
  def count_by_level
    @entries.group_by { |entry| entry[:level] }
            .transform_values(&:count)
  end
  
  def find_errors_with_keyword(keyword)
    errors_only.select do |entry|
      entry[:message].match?(/#{Regexp.escape(keyword)}/i)
    end
  end
  
  def summary
    puts "📊 Log Analysis Summary"
    puts "=" * 30
    puts "Total entries: #{@entries.length}"
    
    count_by_level.each do |level, count|
      puts "#{level}: #{count}"
    end
    
    puts "\n🌐 Unique IP addresses: #{find_ip_addresses.length}"
    puts "IPs: #{find_ip_addresses.join(', ')}"
    
    puts "\n❌ Recent errors:"
    errors_only.last(3).each do |error|
      puts "  [#{error[:timestamp]}] #{error[:message]}"
    end
  end
end

# Sample log content
log_content = <<~LOGS
  [2023-12-25 14:30:15] INFO: Server started successfully
  [2023-12-25 14:30:20] ERROR: Database connection failed from 192.168.1.100
  [2023-12-25 14:31:05] WARN: High memory usage detected
  [2023-12-25 14:31:30] ERROR: Failed login attempt from 10.0.0.50
  [2023-12-25 14:32:10] INFO: User 'john' logged in from 192.168.1.105
  [2023-12-25 14:33:45] ERROR: Database timeout from 192.168.1.100
LOGS

analyzer = LogAnalyzer.new(log_content)
analyzer.summary

puts "\n🔍 Database-related errors:"
database_errors = analyzer.find_errors_with_keyword("database")
database_errors.each { |error| puts "  #{error[:raw]}" }
```

### Text Cleaner and Formatter

```ruby
class TextFormatter
  def self.clean_text(text)
    text = remove_extra_whitespace(text)
    text = fix_punctuation(text)
    text = normalize_quotes(text)
    text = fix_capitalization(text)
    text
  end
  
  def self.remove_extra_whitespace(text)
    # Remove multiple spaces, tabs, and normalize line breaks
    text.gsub(/[ \t]+/, ' ')           # Multiple spaces/tabs to single space
        .gsub(/\n\s*\n/, "\n\n")       # Multiple newlines to double newline
        .strip                         # Remove leading/trailing whitespace
  end
  
  def self.fix_punctuation(text)
    text.gsub(/\s+([,.!?;:])/, '\1')   # Remove space before punctuation
        .gsub(/([,.!?;:])([a-zA-Z])/, '\1 \2')  # Add space after punctuation
  end
  
  def self.normalize_quotes(text)
    text.gsub(/[""]/, '"')             # Smart quotes to regular quotes
        .gsub(/['']/, "'")             # Smart apostrophes to regular
  end
  
  def self.fix_capitalization(text)
    # Capitalize first letter of sentences
    text.gsub(/([.!?]\s+)([a-z])/) { |match| $1 + $2.upcase }
        .gsub(/\A([a-z])/) { |match| match.upcase }  # Capitalize first letter
  end
  
  def self.extract_emails(text)
    text.scan(/\b[\w._%+-]+@[\w.-]+\.[A-Z]{2,}\b/i)
  end
  
  def self.extract_urls(text)
    text.scan(/https?:\/\/[\w.-]+(?:\/[\w.\-_~!$&'()*+,;=:@%\/]*)?/i)
  end
  
  def self.extract_hashtags(text)
    text.scan(/#\w+/i)
  end
  
  def self.extract_mentions(text)
    text.scan(/@\w+/i)
  end
  
  def self.word_frequency(text)
    # Extract words and count frequency
    words = text.downcase.scan(/\b\w+\b/)
    frequency = Hash.new(0)
    words.each { |word| frequency[word] += 1 }
    frequency.sort_by { |word, count| -count }.to_h
  end
end

# Test text formatting
messy_text = <<~TEXT
  hello   world !how are you today?i'm doing great.
  check out my email: john@example.com   and visit https://example.com
  
  
  follow me @username   and use #hashtag    !
TEXT

puts "🧹 Original text:"
puts messy_text
puts "\n" + "="*50

clean_text = TextFormatter.clean_text(messy_text)
puts "\n✨ Cleaned text:"
puts clean_text

puts "\n📧 Emails found: #{TextFormatter.extract_emails(messy_text)}"
puts "🔗 URLs found: #{TextFormatter.extract_urls(messy_text)}"
puts "#️⃣ Hashtags found: #{TextFormatter.extract_hashtags(messy_text)}"
puts "👤 Mentions found: #{TextFormatter.extract_mentions(messy_text)}"

puts "\n📊 Word frequency:"
frequency = TextFormatter.word_frequency(clean_text)
frequency.first(5).each { |word, count| puts "  #{word}: #{count}" }
```

## Advanced Regex Features 🎯

### Lookahead and Lookbehind

```ruby
# Positive lookahead (?=...)
text = "I have $100 and €50"
# Find numbers followed by currency symbols
matches = text.scan(/\d+(?=\$|€)/)
puts matches  # ["100", "50"]

# Negative lookahead (?!...)
text = "file1.txt file2.doc file3.txt"
# Find "file" not followed by ".txt"
matches = text.scan(/file\d+(?!\.txt)/)
puts matches  # ["file2"]

# Positive lookbehind (?<=...)
text = "price: $100, cost: €50"
# Find numbers preceded by currency symbols
matches = text.scan(/(?<=\$|€)\d+/)
puts matches  # ["100", "50"]
```

### Non-Greedy Matching

```ruby
text = "<div>Hello</div><div>World</div>"

# Greedy (default) - matches as much as possible
greedy = text.match(/<div>.*<\/div>/)
puts greedy[0]  # "<div>Hello</div><div>World</div>"

# Non-greedy - matches as little as possible
non_greedy = text.match(/<div>.*?<\/div>/)
puts non_greedy[0]  # "<div>Hello</div>"
```

## Regex Flags and Modifiers 🏁

```ruby
# Case insensitive matching
text = "Hello WORLD"
puts text.match(/hello/i)      # matches (i = ignore case)

# Multiline mode
text = "Line 1\nLine 2\nLine 3"
puts text.match(/^Line 2$/m)   # matches (m = multiline)

# Extended mode (allows comments and whitespace)
pattern = /
  \A                    # Start of string
  [\w+\-.]+             # Username part
  @                     # @ symbol
  [a-z\d\-]+            # Domain name
  (?:\.[a-z\d\-]+)*     # Subdomains
  \.[a-z]+              # Top level domain
  \z                    # End of string
/xi  # x = extended, i = ignore case

email = "john@example.com"
puts email.match?(pattern)     # true
```

## Regex Performance Tips 💡

1. **Be specific** - use exact patterns when possible
2. **Anchor your patterns** - use `^` and `$` when appropriate
3. **Avoid excessive backtracking** - be careful with nested quantifiers
4. **Use non-capturing groups** `(?:...)` when you don't need to capture
5. **Compile regex once** if using repeatedly

```ruby
# Good - compile once
EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i

def validate_email(email)
  email.match?(EMAIL_REGEX)
end

# Avoid - compiling regex every time
def validate_email_bad(email)
  email.match?(/\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i)
end
```

## Fun Challenges 🎮

### Challenge 1: Password Validator
Create a regex that validates passwords with these rules:
- At least 8 characters
- At least one uppercase letter
- At least one lowercase letter  
- At least one number
- At least one special character

### Challenge 2: Markdown Parser
Create patterns to find and extract:
- Headers (`# Title`, `## Subtitle`)
- Links (`[text](url)`)
- Bold text (`**bold**`)
- Code blocks (`` `code` ``)

### Challenge 3: CSV Parser
Build a regex-based CSV parser that handles:
- Quoted fields with commas inside
- Escaped quotes
- Different delimiters

## What's Next? 🚀

Amazing! You've learned the superpower of pattern matching with regular expressions. You can now find, extract, and manipulate text patterns like a pro! 🎯

Next up, we'll explore **Gems and Libraries** - how to use code that other Ruby wizards have created to make your programs even more powerful! 💎

## Quick Reference 📋

```ruby
# Basic patterns
/abc/           # Literal text
/./             # Any character
/^abc/          # Start of string
/abc$/          # End of string
/a*/            # Zero or more 'a'
/a+/            # One or more 'a'
/a?/            # Zero or one 'a'
/a{3}/          # Exactly 3 'a's
/a{2,5}/        # 2 to 5 'a's

# Character classes
/\d/            # Any digit
/\w/            # Word character
/\s/            # Whitespace
/[abc]/         # Any of a, b, c
/[a-z]/         # Any lowercase letter
/[^abc]/        # Anything except a, b, c

# Groups
/(abc)/         # Capture group
/(?:abc)/       # Non-capture group
/(?<name>abc)/  # Named group

# Common methods
string =~ /pattern/          # Test match
string.match(/pattern/)      # Get match object
string.scan(/pattern/)       # Find all matches
string.gsub(/pattern/, 'replacement')  # Replace
string.split(/pattern/)      # Split by pattern
```

Remember: Regular expressions are like having X-ray vision for text - you can see patterns that are invisible to the naked eye! 👁️✨

[← Previous: Error Handling](./17-error-handling.md) | [Next: Gems and Libraries →](./19-gems.md)
