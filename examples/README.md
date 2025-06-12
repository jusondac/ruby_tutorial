# Ruby Tutorial Examples

This directory contains practical code examples organized by skill level to complement the Ruby tutorial chapters. Each example demonstrates key concepts and provides hands-on learning opportunities.

## 📁 Directory Structure

```
examples/
├── beginner/          # Simple, foundational examples
├── intermediate/      # Object-oriented and structured programs  
├── advanced/          # Complex applications with advanced features
└── master/           # Professional-level code with frameworks
```

## 🎯 Examples by Level

### 🟢 Beginner Level (Chapters 1-8)

**Focus:** Basic syntax, data types, simple programs

| File | Description | Demonstrates |
|------|-------------|--------------|
| `calculator.rb` | Basic calculator with arithmetic operations | Variables, methods, user input, conditionals |
| `todo_list.rb` | Simple to-do list manager | Arrays, hashes, loops, basic OOP |
| `guessing_game.rb` | Number guessing game with hints | Loops, conditionals, random numbers, user interaction |

**What you'll learn:**
- Ruby syntax and basic programming concepts
- Working with different data types
- Creating interactive command-line programs
- Basic problem-solving with code

### 🟡 Intermediate Level (Chapters 9-15)

**Focus:** Object-oriented programming, code organization

| File | Description | Demonstrates |
|------|-------------|--------------|
| `library_system.rb` | Book management system | Classes, inheritance, modules, file I/O |
| `finance_tracker.rb` | Personal finance management tool | Advanced OOP, modules, JSON handling, CLI interfaces |

**What you'll learn:**
- Object-oriented design principles
- Creating classes and modules
- Data persistence and file operations
- Building interactive applications

### 🟠 Advanced Level (Chapters 16-20)

**Focus:** Advanced features, external libraries, robust applications

| File | Description | Demonstrates |
|------|-------------|--------------|
| `web_scraper.rb` | Web content scraper with error handling | HTTP requests, HTML parsing, error handling, gems |
| `log_analyzer.rb` | Log file analyzer and security monitor | File processing, regex, threading, real-time monitoring |

**What you'll learn:**
- Working with external libraries and gems
- Error handling and robust code design
- File processing and regular expressions
- Building tools and utilities

### 🔴 Master Level (Chapters 21-28)

**Focus:** Professional development, frameworks, deployment

| File | Description | Demonstrates |
|------|-------------|--------------|
| `microservice_api.rb` | REST API microservice | Sinatra framework, database integration, caching, API design |
| `Dockerfile` | Container configuration | Docker, deployment, production setup |
| `Gemfile` | Dependencies and gems | Dependency management, production vs development |

**What you'll learn:**
- Building web APIs and microservices
- Database integration and caching
- Containerization and deployment
- Professional Ruby development practices

## 🚀 Running the Examples

### Prerequisites

```bash
# Ensure Ruby 3.0+ is installed
ruby --version

# Install bundler if needed
gem install bundler
```

### Running Individual Examples

```bash
# Beginner examples
ruby examples/beginner/calculator.rb
ruby examples/beginner/todo_list.rb
ruby examples/beginner/guessing_game.rb

# Intermediate examples  
ruby examples/intermediate/library_system.rb
ruby examples/intermediate/finance_tracker.rb

# Advanced examples
ruby examples/advanced/web_scraper.rb
ruby examples/advanced/log_analyzer.rb

# Master level (may require additional setup)
cd examples/master
bundle install  # Install dependencies
ruby microservice_api.rb
```

### Testing All Examples

Use the provided test script to validate all examples:

```bash
# From the tutorial root directory
ruby test_examples.rb

# With verbose output
ruby test_examples.rb --verbose

# With custom timeout
ruby test_examples.rb --timeout 15
```

## 📚 Learning Path

### Recommended Progression

1. **Start with Beginner** - Build confidence with basic concepts
2. **Move to Intermediate** - Learn object-oriented programming
3. **Advance to Advanced** - Master complex features and libraries
4. **Achieve Master Level** - Build professional applications

### Study Approach

For each example:

1. **Read the code** - Understand the structure and logic
2. **Run the program** - See it in action
3. **Modify and experiment** - Change values, add features
4. **Build your own** - Create similar programs from scratch

## 🛠 Customization Ideas

### Beginner Enhancements
- **Calculator**: Add more operations (power, square root, percentage)
- **Todo List**: Add due dates, priorities, categories
- **Guessing Game**: Add difficulty levels, high scores, multiplayer

### Intermediate Projects
- **Library System**: Add member management, late fees, reservations
- **Finance Tracker**: Add budgeting, goal tracking, reports, charts

### Advanced Extensions
- **Web Scraper**: Add concurrent scraping, data analysis, caching
- **Log Analyzer**: Add machine learning anomaly detection, alerting

### Master Level Features
- **Microservice**: Add authentication, rate limiting, monitoring
- **Add testing**: Comprehensive test suites with RSpec
- **Add CI/CD**: Automated testing and deployment

## 🔧 Troubleshooting

### Common Issues

**Missing Gems**
```bash
# Install missing gems
gem install gem_name

# Or use bundler
bundle install
```

**Permission Errors**
```bash
# Make files executable
chmod +x examples/path/to/file.rb
```

**Ruby Version Issues**
```bash
# Check Ruby version
ruby --version

# Install recommended version (3.0+)
rbenv install 3.1.0
rbenv global 3.1.0
```

### Getting Help

1. **Check the tutorial chapters** - Review relevant concepts
2. **Read error messages** - They often contain helpful information
3. **Use Ruby documentation** - `ri` command or online docs
4. **Experiment in IRB** - Test small code snippets
5. **Ask for help** - Community forums, Discord, or GitHub issues

## 📊 Learning Resources

### Documentation
- [Ruby Official Documentation](https://ruby-doc.org/)
- [Ruby Style Guide](https://rubystyle.guide/)
- [Gem Documentation](https://rubygems.org/)

### Practice Platforms
- [Exercism](https://exercism.org/tracks/ruby) - Ruby exercises
- [Codewars](https://www.codewars.com/) - Coding challenges
- [HackerRank](https://www.hackerrank.com/domains/ruby) - Ruby problems

### Advanced Learning
- [Ruby on Rails](https://rubyonrails.org/) - Web framework
- [Sinatra](http://sinatrarb.com/) - Lightweight web framework
- [RSpec](https://rspec.info/) - Testing framework

## 🏆 Completion Goals

By working through these examples, you should be able to:

✅ **Beginner**: Write basic Ruby programs and understand core concepts  
✅ **Intermediate**: Create object-oriented applications with good structure  
✅ **Advanced**: Build robust applications using external libraries  
✅ **Master**: Develop professional-grade Ruby applications  

## 🤝 Contributing

Found a bug or want to add an example? See [CONTRIBUTING.md](../CONTRIBUTING.md) for guidelines on:

- Reporting issues
- Suggesting improvements  
- Adding new examples
- Code style standards

## 📝 Notes

- **Interactive Examples**: Some examples require user input and are best run in a terminal
- **Dependencies**: Master level examples may require additional gems or services
- **Error Handling**: Examples include appropriate error handling for learning purposes
- **Comments**: Code is well-commented to explain concepts and techniques

---

Happy coding! 🚀 These examples will help you master Ruby through practical, hands-on experience.
