# Personal Library Management System - Intermediate Example
# Demonstrates: classes, objects, inheritance, modules, file I/O

require 'json'

module Searchable
  def search_by_title(title)
    @books.select { |book| book.title.downcase.include?(title.downcase) }
  end
  
  def search_by_author(author)
    @books.select { |book| book.author.downcase.include?(author.downcase) }
  end
  
  def search_by_genre(genre)
    @books.select { |book| book.genre.downcase == genre.downcase }
  end
end

class Book
  attr_accessor :title, :author, :genre, :year, :available
  
  def initialize(title, author, genre, year)
    @title = title
    @author = author
    @genre = genre
    @year = year
    @available = true
  end
  
  def borrow
    if @available
      @available = false
      "📖 You borrowed '#{@title}'"
    else
      "❌ '#{@title}' is not available"
    end
  end
  
  def return_book
    @available = true
    "📚 You returned '#{@title}'"
  end
  
  def to_s
    status = @available ? "Available" : "Borrowed"
    "#{@title} by #{@author} (#{@year}) - #{@genre} [#{status}]"
  end
  
  def to_hash
    {
      title: @title,
      author: @author,
      genre: @genre,
      year: @year,
      available: @available
    }
  end
end

class Library
  include Searchable
  
  def initialize(name)
    @name = name
    @books = []
  end
  
  def add_book(book)
    @books << book
    puts "✅ Added '#{book.title}' to #{@name}"
  end
  
  def remove_book(title)
    book = @books.find { |b| b.title.downcase == title.downcase }
    if book
      @books.delete(book)
      puts "🗑️ Removed '#{book.title}' from #{@name}"
    else
      puts "❌ Book '#{title}' not found"
    end
  end
  
  def list_books
    if @books.empty?
      puts "📚 #{@name} has no books yet"
      return
    end
    
    puts "\n📚 Books in #{@name}:"
    puts "=" * 50
    @books.each_with_index do |book, index|
      puts "#{index + 1}. #{book}"
    end
  end
  
  def available_books
    available = @books.select(&:available)
    puts "\n📖 Available books (#{available.length}):"
    available.each { |book| puts "  #{book}" }
    available
  end
  
  def borrowed_books
    borrowed = @books.reject(&:available)
    puts "\n📋 Borrowed books (#{borrowed.length}):"
    borrowed.each { |book| puts "  #{book}" }
    borrowed
  end
  
  def stats
    total = @books.length
    available = @books.count(&:available)
    borrowed = total - available
    
    puts "\n📊 #{@name} Statistics:"
    puts "Total books: #{total}"
    puts "Available: #{available}"
    puts "Borrowed: #{borrowed}"
    
    if total > 0
      genres = @books.group_by(&:genre)
      puts "\nGenres:"
      genres.each { |genre, books| puts "  #{genre}: #{books.length} books" }
    end
  end
  
  def save_to_file(filename = "library.json")
    data = {
      name: @name,
      books: @books.map(&:to_hash)
    }
    
    File.write(filename, JSON.pretty_generate(data))
    puts "💾 Library saved to #{filename}"
  end
  
  def load_from_file(filename = "library.json")
    return unless File.exist?(filename)
    
    data = JSON.parse(File.read(filename))
    @name = data['name']
    @books = data['books'].map do |book_data|
      book = Book.new(
        book_data['title'],
        book_data['author'], 
        book_data['genre'],
        book_data['year']
      )
      book.available = book_data['available']
      book
    end
    
    puts "📖 Library loaded from #{filename}"
  end
end

# Example usage and demo
if __FILE__ == $0
  # Create library
  library = Library.new("Ruby Community Library")
  
  # Add some books
  books_to_add = [
    Book.new("The Ruby Programming Language", "Matz", "Programming", 2008),
    Book.new("Eloquent Ruby", "Russ Olsen", "Programming", 2011),
    Book.new("Ruby on Rails Tutorial", "Michael Hartl", "Web Development", 2016),
    Book.new("The Well-Grounded Rubyist", "David Black", "Programming", 2014),
    Book.new("Practical Object-Oriented Design", "Sandi Metz", "Programming", 2012)
  ]
  
  books_to_add.each { |book| library.add_book(book) }
  
  # Demonstrate functionality
  library.list_books
  library.stats
  
  # Borrow some books
  puts "\n" + "="*50
  puts "📖 Borrowing books..."
  puts library.books.first.borrow
  puts library.books[2].borrow
  
  library.available_books
  library.borrowed_books
  
  # Search functionality
  puts "\n" + "="*50
  puts "🔍 Searching for Ruby books..."
  ruby_books = library.search_by_title("ruby")
  ruby_books.each { |book| puts "  #{book}" }
  
  # Save library
  library.save_to_file
  
  puts "\n🎉 Library demo completed!"
end
