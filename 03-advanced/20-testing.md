# Chapter 20: Testing Your Code - Making Sure Spells Work 🧪

[← Previous: Gems and Libraries](./19-gems.md) | [Next: Introduction to Metaprogramming →](../04-master/21-metaprogramming-intro.md)

## What is Testing? 🤔

Imagine you're a chef who just created a new recipe. Before serving it to customers, you'd want to taste it yourself, right? You'd check if it's too salty, if it's cooked properly, and if it tastes good. That's exactly what testing does for your code! 👨‍🍳

Testing is like having a robot assistant that checks your code to make sure it works correctly. It's like asking: "Hey robot, when I call this method with these inputs, do I get the expected outputs?" If the robot says "Yes!" then your code is working. If it says "No!" then you know something needs fixing.

## Why Should You Test Your Code? 💡

1. **Catch bugs early** - Find problems before users do! 🐛
2. **Confidence in changes** - Modify code without fear of breaking things 💪
3. **Documentation** - Tests show how your code should work 📝
4. **Better design** - Writing tests often leads to cleaner code 🎨
5. **Sleep better** - Know your code works! 😴

## Test-Driven Development (TDD) 🚦

TDD is like following a recipe:
1. **Red** 🔴 - Write a test that fails (because the code doesn't exist yet)
2. **Green** 🟢 - Write just enough code to make the test pass
3. **Refactor** 🔵 - Improve the code while keeping tests passing

Let's see this in action!

## Your First Test with MiniTest 🧪

Ruby comes with a built-in testing framework called MiniTest. Let's start simple:

```ruby
# calculator.rb
class Calculator
  def add(a, b)
    a + b
  end
  
  def subtract(a, b)
    a - b
  end
  
  def multiply(a, b)
    a * b
  end
  
  def divide(a, b)
    raise ArgumentError, "Cannot divide by zero!" if b == 0
    a.to_f / b
  end
end
```

Now let's test it:

```ruby
# test_calculator.rb
require 'minitest/autorun'
require_relative 'calculator'

class TestCalculator < Minitest::Test
  def setup
    @calculator = Calculator.new
  end
  
  def test_addition
    result = @calculator.add(2, 3)
    assert_equal 5, result
  end
  
  def test_subtraction
    result = @calculator.subtract(10, 4)
    assert_equal 6, result
  end
  
  def test_multiplication
    result = @calculator.multiply(3, 4)
    assert_equal 12, result
  end
  
  def test_division
    result = @calculator.divide(15, 3)
    assert_equal 5.0, result
  end
  
  def test_division_by_zero
    assert_raises ArgumentError do
      @calculator.divide(10, 0)
    end
  end
  
  def test_division_returns_float
    result = @calculator.divide(7, 2)
    assert_equal 3.5, result
  end
end
```

Run the test:
```bash
ruby test_calculator.rb
```

You'll see output like:
```
Run options: --seed 12345

# Running:

......

Finished in 0.001234s, 4863.23 runs/s, 4863.23 assertions/s.

6 runs, 6 assertions, 0 failures, 0 errors, 0 skips
```

## MiniTest Assertions - Your Testing Toolkit 🛠️

MiniTest provides many assertion methods to check different things:

```ruby
require 'minitest/autorun'

class TestAssertions < Minitest::Test
  def test_equality_assertions
    # Basic equality
    assert_equal "hello", "hello"
    refute_equal "hello", "world"  # refute is the opposite of assert
    
    # Floating point equality (with tolerance)
    assert_in_delta 3.14159, Math::PI, 0.001
    
    # Object identity
    array = [1, 2, 3]
    assert_same array, array  # Same object
    refute_same [1, 2, 3], [1, 2, 3]  # Different objects
  end
  
  def test_truthiness_assertions
    assert true
    refute false
    assert_nil nil
    refute_nil "not nil"
    
    # Empty collections
    assert_empty []
    assert_empty ""
    refute_empty [1, 2, 3]
    refute_empty "hello"
  end
  
  def test_inclusion_assertions
    # Check if collection includes item
    assert_includes [1, 2, 3], 2
    refute_includes [1, 2, 3], 5
    
    # String includes substring
    assert_includes "hello world", "world"
    refute_includes "hello world", "goodbye"
  end
  
  def test_type_assertions
    # Check object type
    assert_instance_of String, "hello"
    assert_kind_of Numeric, 42
    assert_kind_of Numeric, 3.14  # Integer and Float are both Numeric
    
    # Check if object responds to method
    assert_respond_to "hello", :upcase
    refute_respond_to 42, :upcase
  end
  
  def test_pattern_assertions
    # Regular expression matching
    assert_match /hello/, "hello world"
    refute_match /goodbye/, "hello world"
  end
  
  def test_exception_assertions
    # Check if exception is raised
    assert_raises ZeroDivisionError do
      1 / 0
    end
    
    # Check exception message
    error = assert_raises ArgumentError do
      raise ArgumentError, "Invalid input"
    end
    assert_equal "Invalid input", error.message
  end
end
```

## Real-World Example: Testing a Bank Account 🏦

Let's build and test a more complex class:

```ruby
# bank_account.rb
class BankAccount
  attr_reader :balance, :account_number
  
  def initialize(account_number, initial_balance = 0)
    raise ArgumentError, "Account number cannot be empty" if account_number.to_s.empty?
    raise ArgumentError, "Initial balance cannot be negative" if initial_balance < 0
    
    @account_number = account_number
    @balance = initial_balance
    @transaction_history = []
  end
  
  def deposit(amount)
    raise ArgumentError, "Deposit amount must be positive" if amount <= 0
    
    @balance += amount
    record_transaction("deposit", amount)
    @balance
  end
  
  def withdraw(amount)
    raise ArgumentError, "Withdrawal amount must be positive" if amount <= 0
    raise InsufficientFundsError, "Insufficient funds" if amount > @balance
    
    @balance -= amount
    record_transaction("withdrawal", amount)
    @balance
  end
  
  def transfer(amount, target_account)
    raise ArgumentError, "Target account cannot be nil" if target_account.nil?
    
    withdraw(amount)  # This will raise errors if needed
    target_account.deposit(amount)
    
    record_transaction("transfer_out", amount, target_account.account_number)
    target_account.record_transaction("transfer_in", amount, @account_number)
  end
  
  def transaction_history
    @transaction_history.dup  # Return a copy to prevent external modification
  end
  
  def statement
    "Account: #{@account_number}, Balance: $#{@balance}"
  end
  
  protected
  
  def record_transaction(type, amount, other_account = nil)
    transaction = {
      type: type,
      amount: amount,
      timestamp: Time.now,
      balance_after: @balance
    }
    transaction[:other_account] = other_account if other_account
    @transaction_history << transaction
  end
end

class InsufficientFundsError < StandardError; end
```

Now let's write comprehensive tests:

```ruby
# test_bank_account.rb
require 'minitest/autorun'
require_relative 'bank_account'

class TestBankAccount < Minitest::Test
  def setup
    @account = BankAccount.new("ACC123", 100)
    @target_account = BankAccount.new("ACC456", 50)
  end
  
  def test_initialization
    account = BankAccount.new("TEST001", 500)
    assert_equal "TEST001", account.account_number
    assert_equal 500, account.balance
    assert_empty account.transaction_history
  end
  
  def test_initialization_with_default_balance
    account = BankAccount.new("TEST002")
    assert_equal 0, account.balance
  end
  
  def test_initialization_errors
    # Empty account number
    assert_raises ArgumentError do
      BankAccount.new("")
    end
    
    # Negative initial balance
    assert_raises ArgumentError do
      BankAccount.new("TEST003", -100)
    end
  end
  
  def test_deposit
    initial_balance = @account.balance
    result = @account.deposit(50)
    
    assert_equal initial_balance + 50, @account.balance
    assert_equal @account.balance, result
    
    # Check transaction history
    history = @account.transaction_history
    assert_equal 1, history.length
    assert_equal "deposit", history.last[:type]
    assert_equal 50, history.last[:amount]
  end
  
  def test_deposit_errors
    # Zero amount
    assert_raises ArgumentError do
      @account.deposit(0)
    end
    
    # Negative amount
    assert_raises ArgumentError do
      @account.deposit(-50)
    end
  end
  
  def test_withdraw
    initial_balance = @account.balance
    result = @account.withdraw(30)
    
    assert_equal initial_balance - 30, @account.balance
    assert_equal @account.balance, result
    
    # Check transaction history
    history = @account.transaction_history
    assert_equal 1, history.length
    assert_equal "withdrawal", history.last[:type]
    assert_equal 30, history.last[:amount]
  end
  
  def test_withdraw_errors
    # Insufficient funds
    assert_raises InsufficientFundsError do
      @account.withdraw(200)  # Account only has 100
    end
    
    # Negative amount
    assert_raises ArgumentError do
      @account.withdraw(-50)
    end
    
    # Zero amount
    assert_raises ArgumentError do
      @account.withdraw(0)
    end
  end
  
  def test_transfer
    initial_source_balance = @account.balance
    initial_target_balance = @target_account.balance
    
    @account.transfer(25, @target_account)
    
    assert_equal initial_source_balance - 25, @account.balance
    assert_equal initial_target_balance + 25, @target_account.balance
    
    # Check source account history
    source_history = @account.transaction_history
    assert_equal 1, source_history.length
    assert_equal "transfer_out", source_history.last[:type]
    assert_equal 25, source_history.last[:amount]
    assert_equal @target_account.account_number, source_history.last[:other_account]
    
    # Check target account history
    target_history = @target_account.transaction_history
    assert_equal 1, target_history.length
    assert_equal "transfer_in", target_history.last[:type]
    assert_equal 25, target_history.last[:amount]
    assert_equal @account.account_number, target_history.last[:other_account]
  end
  
  def test_transfer_errors
    # Nil target account
    assert_raises ArgumentError do
      @account.transfer(25, nil)
    end
    
    # Insufficient funds
    assert_raises InsufficientFundsError do
      @account.transfer(200, @target_account)
    end
  end
  
  def test_transaction_history_immutability
    @account.deposit(50)
    history = @account.transaction_history
    
    # Modifying returned history shouldn't affect internal history
    history.clear
    
    # Internal history should still have the transaction
    assert_equal 1, @account.transaction_history.length
  end
  
  def test_statement
    statement = @account.statement
    assert_includes statement, @account.account_number
    assert_includes statement, @account.balance.to_s
  end
  
  def test_multiple_operations
    @account.deposit(50)    # 100 + 50 = 150
    @account.withdraw(25)   # 150 - 25 = 125
    @account.deposit(75)    # 125 + 75 = 200
    
    assert_equal 200, @account.balance
    assert_equal 3, @account.transaction_history.length
    
    # Check transaction types
    types = @account.transaction_history.map { |t| t[:type] }
    assert_equal ["deposit", "withdrawal", "deposit"], types
  end
end
```

## Testing Edge Cases and Error Conditions 🚨

Good tests cover the happy path AND the edge cases:

```ruby
class TestEdgeCases < Minitest::Test
  def test_empty_string_handling
    # Test how your code handles empty strings
    assert_equal "", String.new.upcase
    assert_equal 0, "".length
  end
  
  def test_nil_handling
    # Test nil inputs
    array = [1, nil, 3]
    assert_includes array, nil
    assert_nil array.find { |x| x.nil? }
  end
  
  def test_large_numbers
    # Test with large numbers
    big_number = 999_999_999_999
    assert_kind_of Integer, big_number
    assert big_number > 0
  end
  
  def test_boundary_conditions
    # Test boundaries (like array indices)
    array = [1, 2, 3]
    assert_equal 1, array[0]    # First element
    assert_equal 3, array[-1]   # Last element
    assert_nil array[10]        # Out of bounds
  end
end
```

## Test Organization and Structure 📁

### Grouping Related Tests

```ruby
class TestUserValidation < Minitest::Test
  def setup
    @user = User.new
  end
  
  # Email validation tests
  def test_valid_email_formats
    valid_emails = [
      "user@example.com",
      "test.email@domain.co.uk",
      "user+tag@example.org"
    ]
    
    valid_emails.each do |email|
      @user.email = email
      assert @user.valid?, "#{email} should be valid"
    end
  end
  
  def test_invalid_email_formats
    invalid_emails = [
      "not-an-email",
      "@example.com",
      "user@",
      ""
    ]
    
    invalid_emails.each do |email|
      @user.email = email
      refute @user.valid?, "#{email} should be invalid"
    end
  end
  
  # Password validation tests
  def test_password_length_requirements
    @user.email = "user@example.com"
    
    # Too short
    @user.password = "123"
    refute @user.valid?
    
    # Just right
    @user.password = "password123"
    assert @user.valid?
  end
end
```

### Using Helpers and Shared Setup

```ruby
class TestShoppingCart < Minitest::Test
  def setup
    @cart = ShoppingCart.new
    @product1 = create_product("Widget", 10.00)
    @product2 = create_product("Gadget", 25.00)
  end
  
  def test_adding_items
    @cart.add(@product1, 2)
    assert_equal 1, @cart.item_count
    assert_equal 20.00, @cart.total
  end
  
  def test_removing_items
    @cart.add(@product1, 2)
    @cart.remove(@product1, 1)
    assert_equal 1, @cart.quantity(@product1)
    assert_equal 10.00, @cart.total
  end
  
  private
  
  def create_product(name, price)
    Product.new(name: name, price: price)
  end
end
```

## Testing with Fixtures and Mock Data 🎭

Sometimes you need consistent test data:

```ruby
# Create test data files
# test/fixtures/users.csv
# name,email,age
# Alice,alice@example.com,25
# Bob,bob@example.com,30

class TestDataProcessor < Minitest::Test
  def setup
    @processor = DataProcessor.new
    @test_file = File.join(__dir__, 'fixtures', 'users.csv')
  end
  
  def test_process_csv_file
    result = @processor.process_csv(@test_file)
    
    assert_equal 2, result[:total_users]
    assert_equal 27.5, result[:average_age]
    assert_includes result[:emails], "alice@example.com"
  end
  
  def test_handles_missing_file
    assert_raises FileNotFoundError do
      @processor.process_csv("nonexistent.csv")
    end
  end
end
```

## Performance Testing ⚡

Sometimes you want to ensure your code runs fast enough:

```ruby
require 'benchmark'

class TestPerformance < Minitest::Test
  def test_sort_algorithm_performance
    large_array = (1..10000).to_a.shuffle
    
    time = Benchmark.realtime do
      QuickSort.sort(large_array.dup)
    end
    
    # Should sort 10,000 items in less than 0.1 seconds
    assert time < 0.1, "Sorting took too long: #{time} seconds"
  end
  
  def test_memory_usage
    initial_objects = ObjectSpace.count_objects[:T_STRING]
    
    # Do something that might create many strings
    StringProcessor.process_large_text("word " * 1000)
    
    final_objects = ObjectSpace.count_objects[:T_STRING]
    created_objects = final_objects - initial_objects
    
    # Shouldn't create more than 100 new string objects
    assert created_objects < 100, "Created too many strings: #{created_objects}"
  end
end
```

## Testing Best Practices 💡

### 1. Test Names Should Tell a Story

```ruby
# Good
def test_user_cannot_withdraw_more_than_balance
def test_email_validation_rejects_invalid_formats
def test_shopping_cart_calculates_tax_correctly

# Avoid
def test_user_method
def test_validation
def test_calculation
```

### 2. Arrange, Act, Assert (AAA) Pattern

```ruby
def test_user_can_update_profile
  # Arrange - Set up test data
  user = User.create(name: "Alice", email: "alice@example.com")
  new_name = "Alice Smith"
  
  # Act - Perform the action being tested
  result = user.update_profile(name: new_name)
  
  # Assert - Check the results
  assert result
  assert_equal new_name, user.name
end
```

### 3. One Assertion Per Test (Generally)

```ruby
# Good - focused test
def test_user_email_validation
  user = User.new(email: "invalid-email")
  refute user.valid?
end

def test_user_name_validation
  user = User.new(name: "")
  refute user.valid?
end

# Avoid - testing multiple things
def test_user_validation
  user = User.new(email: "invalid", name: "")
  refute user.valid?  # Which validation failed?
end
```

### 4. Test Independence

```ruby
# Each test should be independent
class TestCounter < Minitest::Test
  def setup
    @counter = Counter.new  # Fresh counter for each test
  end
  
  def test_increment
    @counter.increment
    assert_equal 1, @counter.value
  end
  
  def test_decrement
    @counter.decrement
    assert_equal -1, @counter.value  # Doesn't depend on increment test
  end
end
```

## Running Tests Efficiently 🏃‍♂️

```bash
# Run all tests
ruby test_calculator.rb

# Run specific test method
ruby test_calculator.rb -n test_addition

# Run tests with verbose output
ruby test_calculator.rb -v

# Run all test files in a directory
ruby -Ilib:test test/test_*.rb

# Show test coverage (with SimpleCov gem)
gem install simplecov
```

## Advanced Testing Concepts 🎓

### Test Doubles (Mocks and Stubs)

Sometimes you need to fake external dependencies:

```ruby
require 'minitest/autorun'
require 'minitest/mock'

class TestEmailService < Minitest::Test
  def test_sends_welcome_email
    # Create a mock email client
    email_client = Minitest::Mock.new
    
    # Set expectation: send_email should be called with specific arguments
    email_client.expect :send_email, true, [
      "welcome@company.com", 
      "alice@example.com", 
      "Welcome to our service!"
    ]
    
    # Use the mock in our service
    service = EmailService.new(email_client)
    result = service.send_welcome_email("alice@example.com")
    
    # Verify the mock was called as expected
    email_client.verify
    assert result
  end
end
```

### Custom Assertions

Create your own assertion methods for domain-specific testing:

```ruby
module CustomAssertions
  def assert_valid_email(email)
    assert email.match?(/\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i),
           "Expected #{email} to be a valid email address"
  end
  
  def assert_money_equal(expected, actual)
    assert_in_delta expected, actual, 0.01,
           "Expected $#{expected}, got $#{actual}"
  end
end

class TestUser < Minitest::Test
  include CustomAssertions
  
  def test_user_email_format
    user = User.new(email: "alice@example.com")
    assert_valid_email(user.email)
  end
  
  def test_purchase_total
    purchase = Purchase.new(amount: 19.99)
    assert_money_equal 19.99, purchase.total
  end
end
```

## Fun Challenges 🎮

### Challenge 1: Test a Game Class
Create a simple guessing game class and write comprehensive tests for it, including edge cases like invalid inputs.

### Challenge 2: Test a File Parser
Build a CSV or JSON parser and test it with various file formats, including malformed data.

### Challenge 3: Test a Web Scraper
Create a class that parses HTML and test it with different HTML structures and edge cases.

## What's Next? 🚀

Congratulations! You've learned how to write tests that ensure your code works correctly and continues to work as you make changes. Testing is a superpower that separates professional programmers from beginners! 🦸‍♂️

Now we're ready to dive into the **Master Level** content, starting with **Metaprogramming** - Ruby's most advanced and magical features that let you write code that writes code! 🎩✨

## Quick Reference 📋

```ruby
# Basic test structure
require 'minitest/autorun'

class TestMyClass < Minitest::Test
  def setup
    @object = MyClass.new
  end
  
  def test_something
    result = @object.do_something
    assert_equal expected_value, result
  end
end

# Common assertions
assert_equal expected, actual
refute_equal unexpected, actual
assert_nil value
assert_includes collection, item
assert_raises ExceptionClass { code }
assert_match /pattern/, string

# Run tests
ruby test_file.rb
ruby test_file.rb -n test_method_name
ruby test_file.rb -v  # verbose
```

Remember: Tests are like safety nets for tightrope walkers - they let you make bold moves with confidence! 🎪🛡️

[← Previous: Gems and Libraries](./19-gems.md) | [Next: Introduction to Metaprogramming →](../04-master/21-metaprogramming-intro.md)
