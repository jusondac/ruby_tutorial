# Chapter 2: Installing Ruby 🛠️

## 🎯 Getting Ruby Ready to Use

Before we can start our Ruby adventure, we need to install Ruby on your computer! Think of this like setting up your wizard workshop - you need all the right tools before you can start casting spells.

## 🖥️ Installing on Different Systems

### 🐧 Linux (Your System!)

Good news! You're using Linux, which makes Ruby installation super easy!

#### Method 1: Using Your Package Manager (Easiest)
```bash
# For Ubuntu/Debian:
sudo apt update
sudo apt install ruby-full

# For CentOS/RHEL/Fedora:
sudo dnf install ruby ruby-devel

# For Arch Linux:
sudo pacman -S ruby
```

#### Method 2: Using rbenv (Best for Development)
This is like having multiple Ruby versions you can switch between!

```bash
# Install rbenv
curl -fsSL https://github.com/rbenv/rbenv-installer/raw/HEAD/bin/rbenv-installer | bash

# Add to your shell profile
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.zshrc
echo 'eval "$(rbenv init -)"' >> ~/.zshrc

# Restart your terminal or run:
source ~/.zshrc

# Install Ruby
rbenv install 3.1.0
rbenv global 3.1.0
```

### 🍎 macOS

```bash
# Using Homebrew (install Homebrew first if you don't have it):
brew install ruby

# Or using rbenv:
brew install rbenv
rbenv install 3.1.0
rbenv global 3.1.0
```

### 🪟 Windows

1. Go to [RubyInstaller.org](https://rubyinstaller.org/)
2. Download the latest Ruby+Devkit version
3. Run the installer
4. Follow the setup wizard

## ✅ Checking if Ruby is Installed

Open your terminal and type:

```bash
ruby --version
```

You should see something like:
```
ruby 3.1.0p0 (2021-12-25 revision fb4df44d16) [x86_64-linux]
```

If you see this, congratulations! Ruby is ready! 🎉

## 🧙‍♂️ Your First Ruby Command

Let's try Ruby right now! In your terminal, type:

```bash
ruby -e "puts 'Hello, Ruby world!'"
```

This should print:
```
Hello, Ruby world!
```

**What just happened?**
- `ruby -e` tells your computer "run this Ruby code"
- `"puts 'Hello, Ruby world!'"` is Ruby code that says "show this message"
- Ruby did exactly what you asked!

## 🎮 Interactive Ruby (IRB)

Ruby comes with a cool playground called IRB (Interactive Ruby). It's like a sandbox where you can try Ruby code immediately!

Type this in your terminal:
```bash
irb
```

You'll see something like:
```
irb(main):001:0>
```

This is Ruby waiting for your commands! Try typing:
```ruby
puts "I'm using Ruby!"
2 + 2
"Hello".upcase
```

To exit IRB, type `exit` or press `Ctrl+D`.

## 📁 Setting Up Your Workspace

Let's create a special folder for all your Ruby adventures:

```bash
mkdir ~/ruby-playground
cd ~/ruby-playground
```

Now create your first Ruby file:
```bash
touch hello.rb
```

Open it in your favorite text editor and add:
```ruby
puts "Welcome to my Ruby journey!"
puts "Today is a great day to learn programming!"
```

Save the file and run it:
```bash
ruby hello.rb
```

## 🛠️ Useful Tools to Install

### 1. A Good Text Editor
- **VS Code** (free, lots of Ruby extensions)
- **Sublime Text** (fast and simple)
- **Atom** (customizable)
- **Vim/Neovim** (if you're feeling adventurous!)

### 2. Essential Gems (Ruby Libraries)
```bash
gem install bundler  # Manages other gems
gem install pry     # Better IRB
gem install rubocop # Code style checker
```

## 🎯 Text Editor Setup for Ruby

If you're using VS Code, install these extensions:
- Ruby
- Ruby Solargraph
- endwise (auto-completes `end` statements)

## 🚨 Common Installation Problems

### Problem: "Command not found"
**Solution:** Ruby isn't in your PATH. Try:
```bash
which ruby
echo $PATH
```

### Problem: Permission errors
**Solution:** Don't use `sudo` with gems if using rbenv:
```bash
gem install gem_name  # Good
sudo gem install gem_name  # Bad with rbenv
```

### Problem: Old Ruby version
**Solution:** Update using your package manager or rbenv:
```bash
rbenv install 3.1.0
rbenv global 3.1.0
```

## 🎉 You're Ready!

Awesome! Now you have:
- ✅ Ruby installed and working
- ✅ A way to run Ruby code
- ✅ A workspace for your projects
- ✅ Tools to help you code

You're all set to start learning Ruby! In the next chapter, we'll write your very first Ruby program and learn how Ruby thinks.

## 🔧 Quick Setup Checklist

- [ ] Ruby is installed (`ruby --version` works)
- [ ] IRB works (`irb` command works)
- [ ] You can run Ruby files (`ruby filename.rb`)
- [ ] You have a text editor ready
- [ ] You created a workspace folder

---

## 🚀 What's Next?

Your Ruby workshop is ready! Now let's create your first real Ruby program.

**[← Previous: What is Ruby?](./01-what-is-ruby.md)** | **[Next: Your First Ruby Program →](./03-first-program.md)**

---

### 🎯 Quick Challenge
Try these in IRB before moving to the next chapter:
1. `puts "My name is [your name]"`
2. `5 + 3`
3. `"ruby".length`

Have fun exploring!
