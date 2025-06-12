# Simple Calculator - Beginner Example
# Demonstrates: variables, methods, user input, basic math

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
  if b == 0
    puts "Error: Cannot divide by zero!"
    return nil
  end
  a.to_f / b
end

# Main program
puts "🔢 Simple Calculator"
puts "==================="

print "Enter first number: "
num1 = gets.chomp.to_f

print "Enter operation (+, -, *, /): "
operation = gets.chomp

print "Enter second number: "
num2 = gets.chomp.to_f

case operation
when "+"
  result = add(num1, num2)
  puts "#{num1} + #{num2} = #{result}"
when "-"
  result = subtract(num1, num2)
  puts "#{num1} - #{num2} = #{result}"
when "*"
  result = multiply(num1, num2)
  puts "#{num1} * #{num2} = #{result}"
when "/"
  result = divide(num1, num2)
  puts "#{num1} / #{num2} = #{result}" if result
else
  puts "Unknown operation: #{operation}"
end

puts "Thanks for using the calculator! 👋"
