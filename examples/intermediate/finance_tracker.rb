#!/usr/bin/env ruby
# Intermediate Example: Personal Finance Tracker
# Demonstrates: Classes, modules, file I/O, data persistence, error handling

require 'json'
require 'date'

module FinanceHelpers
  def format_currency(amount)
    "$#{sprintf('%.2f', amount)}"
  end
  
  def validate_amount(amount)
    amount.is_a?(Numeric) && amount > 0
  end
  
  def validate_category(category)
    !category.nil? && !category.strip.empty?
  end
end

class Transaction
  include FinanceHelpers
  
  attr_reader :id, :amount, :category, :description, :date, :type
  
  def initialize(amount, category, description, type = :expense)
    @id = generate_id
    @amount = amount.to_f
    @category = category.strip
    @description = description.strip
    @type = type.to_sym
    @date = Date.today
    
    validate_transaction
  end
  
  def to_hash
    {
      id: @id,
      amount: @amount,
      category: @category,
      description: @description,
      type: @type.to_s,
      date: @date.to_s
    }
  end
  
  def self.from_hash(hash)
    transaction = allocate
    transaction.instance_variable_set(:@id, hash['id'])
    transaction.instance_variable_set(:@amount, hash['amount'])
    transaction.instance_variable_set(:@category, hash['category'])
    transaction.instance_variable_set(:@description, hash['description'])
    transaction.instance_variable_set(:@type, hash['type'].to_sym)
    transaction.instance_variable_set(:@date, Date.parse(hash['date']))
    transaction
  end
  
  private
  
  def generate_id
    Time.now.to_f.to_s.gsub('.', '')
  end
  
  def validate_transaction
    raise ArgumentError, "Amount must be positive" unless validate_amount(@amount)
    raise ArgumentError, "Category cannot be empty" unless validate_category(@category)
    raise ArgumentError, "Type must be :income or :expense" unless [:income, :expense].include?(@type)
  end
end

class FinanceTracker
  include FinanceHelpers
  
  def initialize(data_file = 'finances.json')
    @data_file = data_file
    @transactions = []
    load_data
  end
  
  def add_income(amount, category, description)
    transaction = Transaction.new(amount, category, description, :income)
    @transactions << transaction
    save_data
    puts "✅ Income added: #{format_currency(amount)} from #{category}"
    transaction
  end
  
  def add_expense(amount, category, description)
    transaction = Transaction.new(amount, category, description, :expense)
    @transactions << transaction
    save_data
    puts "💸 Expense added: #{format_currency(amount)} for #{category}"
    transaction
  end
  
  def view_summary
    total_income = calculate_total(:income)
    total_expenses = calculate_total(:expense)
    balance = total_income - total_expenses
    
    puts "\n" + "="*40
    puts "📊 FINANCIAL SUMMARY"
    puts "="*40
    puts "💰 Total Income:  #{format_currency(total_income)}"
    puts "💸 Total Expenses: #{format_currency(total_expenses)}"
    puts "📈 Balance:       #{format_currency(balance)}"
    puts "="*40
    
    balance
  end
  
  def view_transactions(type = :all, limit = 10)
    filtered_transactions = case type
                          when :income
                            @transactions.select { |t| t.type == :income }
                          when :expense
                            @transactions.select { |t| t.type == :expense }
                          else
                            @transactions
                          end
    
    if filtered_transactions.empty?
      puts "No transactions found."
      return
    end
    
    puts "\n📋 Recent Transactions (#{type.upcase})"
    puts "-" * 50
    
    filtered_transactions.last(limit).reverse.each do |transaction|
      icon = transaction.type == :income ? "💰" : "💸"
      puts "#{icon} #{transaction.date} | #{transaction.category}"
      puts "   #{format_currency(transaction.amount)} - #{transaction.description}"
      puts
    end
  end
  
  def category_breakdown(type = :expense)
    transactions_by_type = @transactions.select { |t| t.type == type }
    
    if transactions_by_type.empty?
      puts "No #{type} transactions found."
      return
    end
    
    category_totals = Hash.new(0)
    transactions_by_type.each do |transaction|
      category_totals[transaction.category] += transaction.amount
    end
    
    puts "\n📊 #{type.upcase} BREAKDOWN BY CATEGORY"
    puts "-" * 40
    
    sorted_categories = category_totals.sort_by { |_, amount| -amount }
    total = sorted_categories.sum { |_, amount| amount }
    
    sorted_categories.each do |category, amount|
      percentage = (amount / total * 100).round(1)
      puts "#{category.ljust(20)} #{format_currency(amount).rjust(10)} (#{percentage}%)"
    end
    
    puts "-" * 40
    puts "TOTAL".ljust(20) + format_currency(total).rjust(10)
  end
  
  def monthly_report(year = Date.today.year, month = Date.today.month)
    start_date = Date.new(year, month, 1)
    end_date = Date.new(year, month, -1)
    
    monthly_transactions = @transactions.select do |t|
      t.date >= start_date && t.date <= end_date
    end
    
    if monthly_transactions.empty?
      puts "No transactions found for #{Date::MONTHNAMES[month]} #{year}."
      return
    end
    
    income = monthly_transactions.select { |t| t.type == :income }.sum(&:amount)
    expenses = monthly_transactions.select { |t| t.type == :expense }.sum(&:amount)
    
    puts "\n📅 MONTHLY REPORT - #{Date::MONTHNAMES[month]} #{year}"
    puts "="*45
    puts "💰 Income:  #{format_currency(income)}"
    puts "💸 Expenses: #{format_currency(expenses)}"
    puts "📈 Net:     #{format_currency(income - expenses)}"
    puts "📊 Transactions: #{monthly_transactions.length}"
    puts "="*45
  end
  
  def search_transactions(query)
    results = @transactions.select do |t|
      t.description.downcase.include?(query.downcase) ||
      t.category.downcase.include?(query.downcase)
    end
    
    if results.empty?
      puts "No transactions found matching '#{query}'"
      return
    end
    
    puts "\n🔍 Search Results for '#{query}'"
    puts "-" * 40
    
    results.each do |transaction|
      icon = transaction.type == :income ? "💰" : "💸"
      puts "#{icon} #{transaction.date} | #{transaction.category}"
      puts "   #{format_currency(transaction.amount)} - #{transaction.description}"
      puts
    end
  end
  
  private
  
  def calculate_total(type)
    @transactions.select { |t| t.type == type }.sum(&:amount)
  end
  
  def load_data
    return unless File.exist?(@data_file)
    
    begin
      data = JSON.parse(File.read(@data_file))
      @transactions = data['transactions'].map { |t| Transaction.from_hash(t) }
      puts "📂 Loaded #{@transactions.length} transactions from #{@data_file}"
    rescue JSON::ParserError => e
      puts "⚠️  Error reading data file: #{e.message}"
      puts "Starting with empty transaction list."
    rescue => e
      puts "⚠️  Unexpected error loading data: #{e.message}"
    end
  end
  
  def save_data
    data = {
      transactions: @transactions.map(&:to_hash),
      saved_at: Time.now.to_s
    }
    
    begin
      File.write(@data_file, JSON.pretty_generate(data))
    rescue => e
      puts "⚠️  Error saving data: #{e.message}"
    end
  end
end

# Interactive CLI
class FinanceCLI
  def initialize
    @tracker = FinanceTracker.new
  end
  
  def start
    puts "💰 Welcome to Personal Finance Tracker! 💰"
    
    loop do
      display_menu
      choice = gets.chomp.to_i
      
      case choice
      when 1 then add_income_interactive
      when 2 then add_expense_interactive
      when 3 then @tracker.view_summary
      when 4 then view_transactions_interactive
      when 5 then category_breakdown_interactive
      when 6 then monthly_report_interactive
      when 7 then search_interactive
      when 8
        puts "💾 Data saved automatically. Goodbye!"
        break
      else
        puts "❌ Invalid option. Please try again."
      end
    end
  end
  
  private
  
  def display_menu
    puts "\n" + "="*30
    puts "📊 FINANCE TRACKER MENU"
    puts "="*30
    puts "1. Add Income"
    puts "2. Add Expense"
    puts "3. View Summary"
    puts "4. View Transactions"
    puts "5. Category Breakdown"
    puts "6. Monthly Report"
    puts "7. Search Transactions"
    puts "8. Exit"
    print "Choose option (1-8): "
  end
  
  def add_income_interactive
    print "💰 Income amount: $"
    amount = gets.chomp.to_f
    print "📂 Category: "
    category = gets.chomp
    print "📝 Description: "
    description = gets.chomp
    
    @tracker.add_income(amount, category, description)
  rescue ArgumentError => e
    puts "❌ Error: #{e.message}"
  end
  
  def add_expense_interactive
    print "💸 Expense amount: $"
    amount = gets.chomp.to_f
    print "📂 Category: "
    category = gets.chomp
    print "📝 Description: "
    description = gets.chomp
    
    @tracker.add_expense(amount, category, description)
  rescue ArgumentError => e
    puts "❌ Error: #{e.message}"
  end
  
  def view_transactions_interactive
    puts "View: (1) All (2) Income (3) Expenses"
    print "Choose: "
    choice = gets.chomp.to_i
    
    type = case choice
           when 2 then :income
           when 3 then :expense
           else :all
           end
    
    @tracker.view_transactions(type)
  end
  
  def category_breakdown_interactive
    puts "Breakdown for: (1) Expenses (2) Income"
    print "Choose: "
    choice = gets.chomp.to_i
    
    type = choice == 2 ? :income : :expense
    @tracker.category_breakdown(type)
  end
  
  def monthly_report_interactive
    print "Year (#{Date.today.year}): "
    year_input = gets.chomp
    year = year_input.empty? ? Date.today.year : year_input.to_i
    
    print "Month (#{Date.today.month}): "
    month_input = gets.chomp
    month = month_input.empty? ? Date.today.month : month_input.to_i
    
    @tracker.monthly_report(year, month)
  end
  
  def search_interactive
    print "🔍 Search for: "
    query = gets.chomp
    @tracker.search_transactions(query)
  end
end

# Run the application
if __FILE__ == $0
  cli = FinanceCLI.new
  cli.start
end
