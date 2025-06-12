# Web Scraper with Error Handling - Advanced Example
# Demonstrates: error handling, regex, gems, file operations, testing

require 'net/http'
require 'uri'
require 'json'

class WebScraper
  def initialize(base_url)
    @base_url = base_url
    @headers = {
      'User-Agent' => 'Ruby Web Scraper 1.0'
    }
  end
  
  def fetch_page(url)
    uri = URI(url)
    
    begin
      Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == 'https') do |http|
        request = Net::HTTP::Get.new(uri.request_uri, @headers)
        response = http.request(request)
        
        case response.code
        when '200'
          response.body
        when '404'
          raise "Page not found: #{url}"
        when '403'
          raise "Access forbidden: #{url}"
        else
          raise "HTTP Error #{response.code}: #{response.message}"
        end
      end
    rescue SocketError => e
      raise "Network error: #{e.message}"
    rescue Timeout::Error
      raise "Request timed out for: #{url}"
    rescue StandardError => e
      raise "Failed to fetch #{url}: #{e.message}"
    end
  end
  
  def extract_emails(html_content)
    email_pattern = /\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b/
    emails = html_content.scan(email_pattern).uniq
    emails
  end
  
  def extract_phone_numbers(html_content)
    # Match various phone number formats
    phone_patterns = [
      /\b\d{3}-\d{3}-\d{4}\b/,           # 555-123-4567
      /\b\(\d{3}\)\s*\d{3}-\d{4}\b/,     # (555) 123-4567
      /\b\d{3}\.\d{3}\.\d{4}\b/,         # 555.123.4567
      /\b\d{10}\b/                       # 5551234567
    ]
    
    phone_numbers = []
    phone_patterns.each do |pattern|
      phone_numbers.concat(html_content.scan(pattern))
    end
    
    phone_numbers.uniq
  end
  
  def extract_links(html_content, base_url = nil)
    # Extract href attributes from anchor tags
    link_pattern = /<a[^>]+href\s*=\s*["']([^"']+)["'][^>]*>/i
    links = html_content.scan(link_pattern).flatten
    
    # Convert relative URLs to absolute if base_url provided
    if base_url
      base_uri = URI(base_url)
      links.map! do |link|
        begin
          uri = URI(link)
          uri.absolute? ? link : URI.join(base_uri, link).to_s
        rescue URI::InvalidURIError
          link # Return original if parsing fails
        end
      end
    end
    
    links.uniq
  end
  
  def save_results(data, filename)
    begin
      File.open(filename, 'w') do |file|
        file.write(JSON.pretty_generate(data))
      end
      puts "✅ Results saved to #{filename}"
    rescue IOError => e
      puts "❌ Failed to save file: #{e.message}"
    end
  end
  
  def scrape_contact_info(url)
    puts "🌐 Scraping contact information from: #{url}"
    
    begin
      html_content = fetch_page(url)
      
      results = {
        url: url,
        scraped_at: Time.now.to_s,
        emails: extract_emails(html_content),
        phone_numbers: extract_phone_numbers(html_content),
        links: extract_links(html_content, url),
        word_count: html_content.scan(/\w+/).length,
        page_size: html_content.length
      }
      
      puts "📧 Found #{results[:emails].length} email(s)"
      puts "📞 Found #{results[:phone_numbers].length} phone number(s)"
      puts "🔗 Found #{results[:links].length} link(s)"
      puts "📝 Page contains #{results[:word_count]} words"
      
      results
      
    rescue StandardError => e
      error_result = {
        url: url,
        scraped_at: Time.now.to_s,
        error: e.message,
        success: false
      }
      
      puts "❌ Scraping failed: #{e.message}"
      error_result
    end
  end
  
  def batch_scrape(urls, output_file = nil)
    results = []
    
    urls.each_with_index do |url, index|
      puts "\n📄 Processing #{index + 1}/#{urls.length}: #{url}"
      
      result = scrape_contact_info(url)
      results << result
      
      # Be polite - don't overwhelm servers
      sleep(1) if index < urls.length - 1
    end
    
    # Save results if output file specified
    if output_file
      save_results(results, output_file)
    end
    
    # Print summary
    successful = results.count { |r| !r.key?(:error) }
    failed = results.length - successful
    
    puts "\n📊 Batch Scraping Summary:"
    puts "Total URLs: #{results.length}"
    puts "Successful: #{successful}"
    puts "Failed: #{failed}"
    
    results
  end
end

# Content Analyzer for scraped data
class ContentAnalyzer
  def initialize(scraped_data)
    @data = scraped_data.is_a?(Array) ? scraped_data : [scraped_data]
  end
  
  def analyze_domains
    domains = {}
    
    @data.each do |result|
      next if result[:error]
      
      uri = URI(result[:url])
      domain = uri.host
      
      domains[domain] ||= {
        pages_scraped: 0,
        total_emails: 0,
        total_phone_numbers: 0,
        total_links: 0,
        total_words: 0
      }
      
      domains[domain][:pages_scraped] += 1
      domains[domain][:total_emails] += result[:emails]&.length || 0
      domains[domain][:total_phone_numbers] += result[:phone_numbers]&.length || 0
      domains[domain][:total_links] += result[:links]&.length || 0
      domains[domain][:total_words] += result[:word_count] || 0
    end
    
    domains
  end
  
  def find_common_emails
    all_emails = []
    @data.each { |result| all_emails.concat(result[:emails] || []) }
    
    email_counts = Hash.new(0)
    all_emails.each { |email| email_counts[email] += 1 }
    
    email_counts.select { |email, count| count > 1 }
  end
  
  def generate_report
    puts "\n📊 Content Analysis Report"
    puts "=" * 50
    
    total_pages = @data.length
    successful_pages = @data.count { |r| !r.key?(:error) }
    
    puts "Total pages analyzed: #{total_pages}"
    puts "Successfully scraped: #{successful_pages}"
    puts "Failed to scrape: #{total_pages - successful_pages}"
    
    if successful_pages > 0
      # Domain analysis
      domains = analyze_domains
      puts "\n🌐 Domain Analysis:"
      domains.each do |domain, stats|
        puts "  #{domain}:"
        puts "    Pages: #{stats[:pages_scraped]}"
        puts "    Emails: #{stats[:total_emails]}"
        puts "    Phone numbers: #{stats[:total_phone_numbers]}"
        puts "    Links: #{stats[:total_links]}"
        puts "    Words: #{stats[:total_words]}"
      end
      
      # Common emails
      common_emails = find_common_emails
      if common_emails.any?
        puts "\n📧 Email addresses found on multiple pages:"
        common_emails.each { |email, count| puts "  #{email}: #{count} pages" }
      end
    end
  end
end

# Example usage and demo
if __FILE__ == $0
  # Demo with safe URLs (these are examples - replace with real URLs for testing)
  demo_urls = [
    "https://httpbin.org/html",  # Safe testing endpoint
    "https://example.com",       # Simple example page
  ]
  
  puts "🕷️ Web Scraper Demo"
  puts "==================="
  puts "⚠️  Note: This is a demo with safe testing URLs"
  puts "Replace with real URLs for actual scraping\n"
  
  scraper = WebScraper.new("https://example.com")
  
  # Single page scrape
  puts "🔍 Single page scrape example:"
  begin
    result = scraper.scrape_contact_info("https://httpbin.org/html")
    puts "Sample result keys: #{result.keys.join(', ')}"
  rescue StandardError => e
    puts "Demo failed (this is expected): #{e.message}"
  end
  
  # Batch scrape example (commented out to avoid actual network calls)
  # puts "\n📚 Batch scrape example:"
  # results = scraper.batch_scrape(demo_urls, "scrape_results.json")
  
  # Analysis example
  # analyzer = ContentAnalyzer.new(results)
  # analyzer.generate_report
  
  puts "\n💡 To use this scraper:"
  puts "1. Replace demo URLs with real websites"
  puts "2. Respect robots.txt and rate limiting"
  puts "3. Only scrape sites you have permission to access"
  puts "4. Consider the legal and ethical implications"
  
  puts "\n🎉 Web scraper demo completed!"
end
