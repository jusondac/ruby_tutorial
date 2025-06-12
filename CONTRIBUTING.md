# Contributing to Ruby Tutorial

Thank you for your interest in contributing to this Ruby tutorial! This guide will help you get started with making meaningful contributions.

## 📋 Table of Contents

- [Getting Started](#getting-started)
- [Types of Contributions](#types-of-contributions)
- [Development Setup](#development-setup)
- [Contribution Guidelines](#contribution-guidelines)
- [Code Style Guide](#code-style-guide)
- [Submit a Contribution](#submit-a-contribution)
- [Review Process](#review-process)

## 🚀 Getting Started

### Prerequisites

- Git installed on your system
- Ruby 3.0+ installed
- A text editor or IDE
- Basic understanding of Markdown
- Familiarity with Git workflows

### Quick Start

1. **Fork the repository**
   ```bash
   # Click the "Fork" button on GitHub
   ```

2. **Clone your fork**
   ```bash
   git clone https://github.com/yourusername/ruby-tutorial.git
   cd ruby-tutorial
   ```

3. **Create a branch**
   ```bash
   git checkout -b feature/your-contribution-name
   ```

4. **Make your changes**
   ```bash
   # Edit files, add content, fix issues
   ```

5. **Test your changes**
   ```bash
   # Run example code to ensure it works
   ruby examples/beginner/calculator.rb
   ```

6. **Submit a pull request**

## 🎯 Types of Contributions

We welcome various types of contributions:

### 📚 Content Contributions
- **Tutorial Improvements**: Enhance existing chapters with clearer explanations
- **New Examples**: Add practical code examples for each level
- **Exercise Solutions**: Provide solutions to chapter exercises
- **Code Comments**: Improve code documentation and comments

### 🐛 Bug Fixes
- **Code Errors**: Fix syntax or logic errors in examples
- **Link Fixes**: Repair broken internal/external links
- **Typos**: Correct spelling and grammar mistakes
- **Formatting**: Fix Markdown formatting issues

### ✨ Enhancements
- **New Chapters**: Propose additional topics or advanced concepts
- **Interactive Elements**: Add quizzes, challenges, or interactive content
- **Visual Assets**: Create diagrams, charts, or illustrations
- **Translations**: Translate content to other languages

### 🔧 Technical Improvements
- **Code Optimization**: Improve example code efficiency
- **Testing**: Add automated tests for code examples
- **Documentation**: Enhance README files and documentation
- **Accessibility**: Improve content accessibility

## 🛠 Development Setup

### Local Environment

1. **Install Ruby** (if not already installed)
   ```bash
   # Using rbenv (recommended)
   rbenv install 3.1.0
   rbenv global 3.1.0
   
   # Or using RVM
   rvm install 3.1.0
   rvm use 3.1.0 --default
   ```

2. **Install dependencies** (if any)
   ```bash
   bundle install  # If Gemfile exists
   ```

3. **Verify setup**
   ```bash
   ruby --version  # Should show Ruby 3.0+
   ```

### Testing Changes

Before submitting, test your changes:

1. **Run example code**
   ```bash
   # Test specific examples
   ruby examples/beginner/calculator.rb
   ruby examples/intermediate/finance_tracker.rb
   ```

2. **Check Ruby syntax**
   ```bash
   ruby -c your_file.rb  # Check syntax
   ```

3. **Validate Markdown**
   ```bash
   # Use a Markdown linter or preview tool
   ```

## 📝 Contribution Guidelines

### Content Standards

#### Tutorial Chapters
- **Clear Learning Objectives**: Each chapter should have clear goals
- **Progressive Difficulty**: Content should build upon previous chapters
- **Practical Examples**: Include real-world, runnable code examples
- **Exercises**: Provide hands-on exercises for practice
- **Summary**: End with key takeaways and next steps

#### Code Examples
- **Working Code**: All code must be tested and functional
- **Comments**: Include helpful comments explaining complex concepts
- **Best Practices**: Follow Ruby conventions and best practices
- **Error Handling**: Include appropriate error handling where relevant

#### Writing Style
- **Clear and Concise**: Use simple, direct language
- **Beginner-Friendly**: Explain technical terms and concepts
- **Consistent Tone**: Maintain a helpful, encouraging tone
- **Inclusive Language**: Use inclusive and welcoming language

### File Organization

```
ruby-tutorial/
├── 01-beginner/          # Beginner chapters (1-8)
├── 02-intermediate/      # Intermediate chapters (9-15)
├── 03-advanced/         # Advanced chapters (16-20)
├── 04-master/           # Master chapters (21-28)
├── examples/            # Code examples by level
│   ├── beginner/
│   ├── intermediate/
│   ├── advanced/
│   └── master/
└── assets/              # Images, diagrams, references
```

### Naming Conventions

- **Files**: Use lowercase with hyphens (`my-new-chapter.md`)
- **Directories**: Use lowercase with hyphens (`01-beginner/`)
- **Code files**: Use snake_case (`finance_tracker.rb`)
- **Images**: Descriptive names (`ruby-class-diagram.png`)

## 🎨 Code Style Guide

### Ruby Code Style

Follow the [Ruby Style Guide](https://rubystyle.guide/):

```ruby
# Good: Use snake_case for variables and methods
user_name = "John Doe"
def calculate_total(items)
  items.sum(&:price)
end

# Good: Use proper indentation (2 spaces)
class User
  def initialize(name)
    @name = name
  end
  
  def greet
    "Hello, #{@name}!"
  end
end

# Good: Use descriptive names
def process_payment(amount, payment_method)
  # Implementation
end

# Good: Add comments for complex logic
# Calculate compound interest using the formula: A = P(1 + r/n)^(nt)
def compound_interest(principal, rate, compounds_per_year, years)
  principal * (1 + rate / compounds_per_year) ** (compounds_per_year * years)
end
```

### Markdown Style

```markdown
# Use consistent heading levels
## Second level
### Third level

# Use code blocks with language specification
```ruby
puts "Hello, World!"
```

# Use consistent list formatting
- Item one
- Item two
  - Sub-item
  - Sub-item

# Use emphasis appropriately
**Bold for important terms**
*Italic for emphasis*
`Code snippets` in backticks
```

## 📤 Submit a Contribution

### Pull Request Process

1. **Ensure your branch is up to date**
   ```bash
   git checkout main
   git pull upstream main
   git checkout your-branch
   git rebase main
   ```

2. **Create a descriptive commit**
   ```bash
   git add .
   git commit -m "Add finance tracker example for intermediate level
   
   - Demonstrates classes, modules, and file I/O
   - Includes CLI interface and data persistence
   - Covers error handling and input validation"
   ```

3. **Push to your fork**
   ```bash
   git push origin your-branch
   ```

4. **Create Pull Request**
   - Go to GitHub and create a pull request
   - Use the provided template
   - Link to any related issues

### Pull Request Template

```markdown
## Description
Brief description of changes made.

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Documentation update
- [ ] Code improvement

## Testing
- [ ] Code examples run without errors
- [ ] Links work correctly
- [ ] Markdown renders properly

## Checklist
- [ ] Code follows style guidelines
- [ ] Self-review completed
- [ ] Comments added for complex code
- [ ] Documentation updated if needed
```

## 🔍 Review Process

### What to Expect

1. **Automated Checks**: Basic syntax and formatting checks
2. **Maintainer Review**: Content and code quality review
3. **Community Feedback**: Input from other contributors
4. **Revision Requests**: Suggestions for improvements

### Review Criteria

- **Accuracy**: Code works and concepts are correct
- **Clarity**: Content is easy to understand
- **Completeness**: All necessary information is included
- **Consistency**: Follows established patterns and style
- **Value**: Adds meaningful content to the tutorial

### Response Time

- Initial review: Within 1-2 weeks
- Follow-up reviews: Within 3-5 days
- Final approval: Within 1 week of final revision

## 🏆 Recognition

Contributors will be recognized in:
- **Contributors section** in README
- **Release notes** for significant contributions
- **Special badges** for major contributors

## 📞 Getting Help

### Communication Channels

- **GitHub Issues**: For bugs and feature requests
- **GitHub Discussions**: For questions and general discussion
- **Discord**: [Link to Discord server] (if available)

### Mentorship

New contributors can request mentorship:
- **Content Writing**: Help with tutorial writing
- **Code Review**: Guidance on code examples
- **Ruby Concepts**: Help understanding Ruby features

## 📜 Code of Conduct

This project adheres to the [Contributor Covenant Code of Conduct](CODE_OF_CONDUCT.md). By participating, you are expected to uphold this code.

### Our Standards

- **Be Respectful**: Treat all community members with respect
- **Be Inclusive**: Welcome people of all backgrounds and experience levels
- **Be Constructive**: Provide helpful, actionable feedback
- **Be Patient**: Help others learn and grow

## 📚 Resources

### Learning Resources
- [Ruby Documentation](https://ruby-doc.org/)
- [Ruby Style Guide](https://rubystyle.guide/)
- [Markdown Guide](https://www.markdownguide.org/)
- [Git Handbook](https://guides.github.com/introduction/git-handbook/)

### Tools
- **Code Editors**: VS Code, Sublime Text, Vim
- **Ruby Tools**: IRB, Pry, RuboCop
- **Markdown**: Typora, Mark Text, or online editors

---

Thank you for contributing to the Ruby Tutorial! Your efforts help make Ruby accessible to learners worldwide. 🚀
