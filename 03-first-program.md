# Chapter 3: Your First Ruby Program 🎉

## 🚀 Let's Write Some Code!

Ready to write your first real Ruby program? This is going to be exciting! Think of this like writing your first letter in a new language - Ruby is going to understand exactly what you want to say.

## 🌟 The Classic "Hello, World!"

Every programmer's first program says "Hello, World!" to the computer. It's like a tradition! Let's create yours.

### Step 1: Create Your File
In your terminal, go to your Ruby workspace:
```bash
cd ~/ruby-playground
```

Create a new file:
```bash
touch my_first_program.rb
```

**Important:** Ruby files always end with `.rb` - this tells the computer "This is Ruby code!"

### Step 2: Write the Code
Open the file in your text editor and type:

```ruby
puts "Hello, World!"
puts "I just wrote my first Ruby program!"
puts "Ruby is awesome! 🎉"
```

### Step 3: Run Your Program
Save the file and run it:
```bash
ruby my_first_program.rb
```

You should see:
```
Hello, World!
I just wrote my first Ruby program!
Ruby is awesome! 🎉
```

**Congratulations! You're officially a Ruby programmer!** 🎊

## 🧙‍♂️ Understanding Your Spell

Let's break down what you just wrote:

### `puts` - The Magic Word
- `puts` means "put string" or "print this out"
- It's Ruby's way of showing something on the screen
- Think of it like Ruby's voice - it's how Ruby talks to you!

### Quotes - Wrapping Your Words
- `"Hello, World!"` - the quotes tell Ruby "this is text, not code"
- You can use single quotes `'hello'` or double quotes `"hello"`
- Both work the same for simple text

### Try This:
```ruby
puts "Double quotes work!"
puts 'Single quotes work too!'
```

## 🎮 Making It Interactive

Let's make your program talk to you! Ruby can ask questions and listen to your answers:

```ruby
puts "What's your name?"
name = gets.chomp

puts "Hello, #{name}! Nice to meet you!"
puts "Welcome to the Ruby world!"
```

**What's happening here?**
- `gets.chomp` - Ruby stops and waits for you to type something
- `name =` - Ruby remembers what you typed in a "variable" called `name`
- `"Hello, #{name}!"` - Ruby puts your name inside the message

### Try it:
1. Save this code in a new file called `greeting.rb`
2. Run it: `ruby greeting.rb`
3. Type your name when it asks
4. See the magic happen!

## 🎯 More Fun Examples

### 1. The Math Wizard
```ruby
puts "I'm a math wizard! Give me two numbers and I'll add them!"

puts "Enter first number:"
first_number = gets.chomp.to_i

puts "Enter second number:"
second_number = gets.chomp.to_i

result = first_number + second_number

puts "#{first_number} + #{second_number} = #{result}"
puts "Math is fun with Ruby! 🧮"
```

**New magic spells:**
- `.to_i` - converts text to a number (integer)
- `+` - adds numbers together
- Variables store information for later use

### 2. The Compliment Generator
```ruby
puts "The Ruby Compliment Generator! 🌟"
puts "What's your name?"
name = gets.chomp

compliments = [
  "amazing",
  "fantastic", 
  "brilliant",
  "wonderful",
  "awesome"
]

puts "#{name}, you are absolutely #{compliments.sample}!"
puts "Keep being great! ✨"
```

**New magic:**
- `[]` - creates a list (array) of things
- `.sample` - picks a random item from the list

## 📝 Ruby Program Structure

Every Ruby program follows a simple pattern:

```ruby
# 1. Comments (notes to yourself)
# This program does something cool

# 2. Get input (if needed)
puts "Enter something:"
input = gets.chomp

# 3. Do something with the input
result = input.upcase

# 4. Show the result
puts result
```

### Comments - Notes to Yourself
- Lines starting with `#` are comments
- Ruby ignores them - they're just for you!
- Use them to remember what your code does

```ruby
# This is a comment - Ruby ignores this line
puts "But Ruby reads this line!"
```

## 🎨 Making Pretty Output

Ruby has lots of ways to make your output look nice:

```ruby
puts "=" * 20  # Prints 20 equal signs
puts "🌟 WELCOME TO RUBY! 🌟"
puts "=" * 20

puts "\nHere are some cool facts:"
puts "• Ruby was created in 1995"
puts "• Ruby is super friendly"
puts "• You're learning Ruby right now!"

puts "\n" + "🎉" * 5 + " AWESOME! " + "🎉" * 5
```

**New tricks:**
- `"=" * 20` - repeats a character 20 times
- `\n` - creates a new line
- `+` - joins strings together

## 🚨 Common Beginner Mistakes

### 1. Forgetting Quotes
```ruby
# Wrong:
puts Hello World

# Right:
puts "Hello World"
```

### 2. Mixing Up Variables
```ruby
# Wrong:
name = gets.chomp
puts "Hello, #{Name}!"  # Capital N won't work!

# Right:
name = gets.chomp
puts "Hello, #{name}!"  # Lowercase n matches
```

### 3. Forgetting .chomp
```ruby
# Without .chomp, you get extra spaces:
name = gets
puts "Hello, #{name}!"  # Looks weird

# With .chomp, it's clean:
name = gets.chomp
puts "Hello, #{name}!"  # Perfect!
```

## 🎯 Your First Project Challenge

Create a program called `about_me.rb` that:

1. Asks for your name
2. Asks for your age
3. Asks for your favorite color
4. Asks for your favorite food
5. Creates a nice summary about you

Here's a template to get you started:
```ruby
puts "🌟 Let's learn about you! 🌟"

# Your code here!

puts "\n📋 Here's your profile:"
# Show the summary here!
```

## 🎉 You Did It!

You've written your first Ruby programs! You can now:
- ✅ Use `puts` to show messages
- ✅ Use `gets.chomp` to get input from users
- ✅ Store information in variables
- ✅ Mix variables into messages with `#{}`
- ✅ Write comments to explain your code

This is just the beginning! Ruby has so many more cool tricks to show you.

---

## 🚀 What's Next?

Now that you can write basic programs, let's learn about variables - Ruby's way of remembering things!

**[← Previous: Installing Ruby](./02-installing-ruby.md)** | **[Next: Variables - Your Data Containers →](./04-variables.md)**

---

### 🎯 Practice Challenges

Before moving on, try creating these programs:
1. **Age Calculator**: Ask for birth year, calculate age
2. **Story Generator**: Ask for 3 words, create a funny story
3. **Echo Chamber**: Repeat whatever the user types, but in ALL CAPS

Have fun experimenting! The more you practice, the more Ruby becomes your friend! 🤝
