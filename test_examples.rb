#!/usr/bin/env ruby
# Test script to validate all Ruby examples in the tutorial
# This ensures all code examples are syntactically correct and run without errors

require 'fileutils'
require 'timeout'

class ExampleTester
  def initialize
    @results = {
      passed: [],
      failed: [],
      skipped: []
    }
    @test_timeout = 10 # seconds
  end
  
  def run_all_tests
    puts "🧪 Ruby Tutorial Example Tester"
    puts "=" * 40
    
    test_directories = [
      'examples/beginner',
      'examples/intermediate', 
      'examples/advanced',
      'examples/master'
    ]
    
    test_directories.each do |dir|
      test_directory(dir)
    end
    
    generate_report
  end
  
  private
  
  def test_directory(directory)
    return unless Dir.exist?(directory)
    
    puts "\n📁 Testing #{directory}..."
    
    ruby_files = Dir.glob(File.join(directory, '*.rb'))
    
    if ruby_files.empty?
      puts "  ⚠️  No Ruby files found"
      return
    end
    
    ruby_files.each do |file|
      test_file(file)
    end
  end
  
  def test_file(file_path)
    filename = File.basename(file_path)
    print "  🔍 Testing #{filename}... "
    
    begin
      # Test 1: Syntax check
      syntax_result = system("ruby -c '#{file_path}' > /dev/null 2>&1")
      
      unless syntax_result
        puts "❌ Syntax Error"
        @results[:failed] << {
          file: file_path,
          error: "Syntax error detected",
          type: :syntax
        }
        return
      end
      
      # Test 2: Basic execution check (with timeout)
      execution_result = test_execution(file_path)
      
      if execution_result[:success]
        puts "✅ Passed"
        @results[:passed] << file_path
      else
        puts "❌ Failed"
        @results[:failed] << {
          file: file_path,
          error: execution_result[:error],
          type: :execution
        }
      end
      
    rescue => e
      puts "❌ Error"
      @results[:failed] << {
        file: file_path,
        error: e.message,
        type: :exception
      }
    end
  end
  
  def test_execution(file_path)
    # Some files require user input, so we'll test them differently
    filename = File.basename(file_path)
    
    # Files that require user interaction - test syntax only
    interactive_files = [
      'todo_list.rb',
      'guessing_game.rb', 
      'finance_tracker.rb',
      'log_analyzer.rb'
    ]
    
    if interactive_files.include?(filename)
      return test_interactive_file(file_path)
    end
    
    # For non-interactive files, try to run them with timeout
    begin
      Timeout::timeout(@test_timeout) do
        result = system("ruby '#{file_path}' > /dev/null 2>&1")
        return { success: result, error: nil }
      end
    rescue Timeout::Error
      return { success: false, error: "Execution timeout (#{@test_timeout}s)" }
    rescue => e
      return { success: false, error: e.message }
    end
  end
  
  def test_interactive_file(file_path)
    # For interactive files, we'll test if they can load without immediate execution
    begin
      # Test if the file can be loaded without running the main execution
      test_code = <<~RUBY
        # Load the file in a way that doesn't execute the main block
        original_file = $0
        $0 = ""  # Prevent if __FILE__ == $0 blocks from executing
        load '#{file_path}'
        $0 = original_file
      RUBY
      
      # Write test code to temporary file
      temp_file = '/tmp/test_interactive.rb'
      File.write(temp_file, test_code)
      
      result = system("ruby '#{temp_file}' > /dev/null 2>&1")
      
      # Clean up
      File.delete(temp_file) if File.exist?(temp_file)
      
      return { success: result, error: result ? nil : "Failed to load interactive file" }
      
    rescue => e
      return { success: false, error: "Interactive test failed: #{e.message}" }
    end
  end
  
  def generate_report
    puts "\n" + "=" * 50
    puts "📊 TEST RESULTS SUMMARY"
    puts "=" * 50
    
    total_tests = @results[:passed].length + @results[:failed].length + @results[:skipped].length
    
    puts "✅ Passed: #{@results[:passed].length}"
    puts "❌ Failed: #{@results[:failed].length}"
    puts "⏭️  Skipped: #{@results[:skipped].length}"
    puts "📈 Total: #{total_tests}"
    
    if @results[:passed].length == total_tests
      puts "\n🎉 All tests passed! Examples are working correctly."
    else
      puts "\n⚠️  Some tests failed. See details below:"
      
      @results[:failed].each do |failure|
        puts "\n❌ #{File.basename(failure[:file])}"
        puts "   Type: #{failure[:type]}"
        puts "   Error: #{failure[:error]}"
      end
    end
    
    # Generate detailed report file
    generate_detailed_report
    
    exit(@results[:failed].empty? ? 0 : 1)
  end
  
  def generate_detailed_report
    report_file = "test_results_#{Time.now.strftime('%Y%m%d_%H%M%S')}.md"
    
    report_content = <<~MARKDOWN
      # Ruby Tutorial Examples Test Report
      
      **Generated:** #{Time.now.strftime('%Y-%m-%d %H:%M:%S')}
      
      ## Summary
      
      - ✅ **Passed:** #{@results[:passed].length}
      - ❌ **Failed:** #{@results[:failed].length}
      - ⏭️ **Skipped:** #{@results[:skipped].length}
      - 📈 **Total:** #{@results[:passed].length + @results[:failed].length + @results[:skipped].length}
      
      ## Passed Tests
      
      #{@results[:passed].map { |file| "- ✅ #{File.basename(file)}" }.join("\n")}
      
      ## Failed Tests
      
      #{@results[:failed].map do |failure|
        "- ❌ **#{File.basename(failure[:file])}**\n  - Type: #{failure[:type]}\n  - Error: #{failure[:error]}"
      end.join("\n\n")}
      
      ## Recommendations
      
      #{generate_recommendations}
    MARKDOWN
    
    File.write(report_file, report_content)
    puts "\n📄 Detailed report saved to: #{report_file}"
  end
  
  def generate_recommendations
    return "All examples are working correctly! 🎉" if @results[:failed].empty?
    
    recommendations = []
    
    syntax_errors = @results[:failed].count { |f| f[:type] == :syntax }
    execution_errors = @results[:failed].count { |f| f[:type] == :execution }
    
    if syntax_errors > 0
      recommendations << "- Fix syntax errors in #{syntax_errors} file(s)"
    end
    
    if execution_errors > 0
      recommendations << "- Review execution errors in #{execution_errors} file(s)"
      recommendations << "- Check for missing dependencies or invalid logic"
    end
    
    recommendations << "- Run `ruby -c filename.rb` to check syntax"
    recommendations << "- Test files individually for debugging"
    
    recommendations.join("\n")
  end
end

# Usage instructions
def show_usage
  puts <<~USAGE
    🧪 Ruby Tutorial Example Tester
    
    Usage:
      ruby test_examples.rb [options]
    
    Options:
      --help, -h     Show this help message
      --verbose, -v  Show verbose output
      --timeout N    Set execution timeout (default: 10s)
    
    Examples:
      ruby test_examples.rb                    # Test all examples
      ruby test_examples.rb --verbose          # Verbose output
      ruby test_examples.rb --timeout 5        # 5 second timeout
    
    This script will:
    1. Find all .rb files in examples/ directories
    2. Check syntax with 'ruby -c'
    3. Test execution (with special handling for interactive files)
    4. Generate a summary report
    5. Create a detailed markdown report
  USAGE
end

# Main execution
if __FILE__ == $0
  if ARGV.include?('--help') || ARGV.include?('-h')
    show_usage
    exit 0
  end
  
  # Change to the tutorial root directory
  tutorial_root = File.expand_path('..', __dir__)
  Dir.chdir(tutorial_root) if Dir.exist?(tutorial_root)
  
  tester = ExampleTester.new
  tester.run_all_tests
end
