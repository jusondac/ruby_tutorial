#!/usr/bin/env ruby
# Advanced Example: Log Analyzer and Monitor
# Demonstrates: File processing, regex, threading, real-time monitoring

require 'fileutils'
require 'json'
require 'time'
require 'set'

class LogAnalyzer
  attr_reader :stats, :alerts
  
  # Common log patterns for different formats
  LOG_PATTERNS = {
    apache: /^(\S+) \S+ \S+ \[([\w:\/]+\s[+\-]\d{4})\] "(\S+) (\S+) (\S+)" (\d{3}) (\d+|-)/,
    nginx: /^(\S+) - \S+ \[([\w:\/]+\s[+\-]\d{4})\] "(\S+) (\S+) (\S+)" (\d{3}) (\d+) "([^"]*)" "([^"]*)"/,
    rails: /^(\w+), \[([^\]]+)\] +(\w+) -- : (.+)$/,
    generic: /^(\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}) \[(\w+)\] (.+)$/
  }.freeze
  
  def initialize(log_format = :apache)
    @log_format = log_format
    @pattern = LOG_PATTERNS[log_format]
    @stats = initialize_stats
    @alerts = []
    @error_threshold = 10
    @ip_blacklist = Set.new
    @suspicious_patterns = [
      /sql.*(union|select|insert|delete|drop)/i,
      /\.\.\/.*etc\/passwd/,
      /<script.*>/i,
      /\.(php|asp|jsp).*\?.*=/
    ]
  end
  
  def analyze_file(file_path)
    raise "File not found: #{file_path}" unless File.exist?(file_path)
    
    puts "🔍 Analyzing log file: #{file_path}"
    start_time = Time.now
    
    File.foreach(file_path).with_index(1) do |line, line_number|
      begin
        parse_and_analyze_line(line.chomp, line_number)
      rescue => e
        puts "⚠️  Error parsing line #{line_number}: #{e.message}"
      end
    end
    
    analysis_time = Time.now - start_time
    puts "✅ Analysis complete in #{analysis_time.round(2)} seconds"
    
    generate_report
  end
  
  def monitor_file(file_path, interval = 1)
    raise "File not found: #{file_path}" unless File.exist?(file_path)
    
    puts "👁️  Starting real-time monitoring of: #{file_path}"
    puts "Press Ctrl+C to stop monitoring"
    
    file = File.open(file_path, 'r')
    file.seek(0, IO::SEEK_END) # Start from end of file
    
    begin
      loop do
        line = file.gets
        if line
          parse_and_analyze_line(line.chomp)
          check_real_time_alerts
        else
          sleep(interval)
        end
      end
    rescue Interrupt
      puts "\n⏹️  Monitoring stopped"
    ensure
      file.close
    end
  end
  
  def generate_security_report
    puts "\n🔒 SECURITY ANALYSIS REPORT"
    puts "=" * 50
    
    # Top attacking IPs
    top_error_ips = @stats[:error_by_ip].sort_by { |_, count| -count }.first(10)
    if top_error_ips.any?
      puts "\n🚨 Top Error-generating IPs:"
      top_error_ips.each do |ip, count|
        status = @ip_blacklist.include?(ip) ? "[BLACKLISTED]" : ""
        puts "  #{ip}: #{count} errors #{status}"
      end
    end
    
    # Suspicious requests
    if @stats[:suspicious_requests] > 0
      puts "\n⚠️  Suspicious Requests Detected: #{@stats[:suspicious_requests]}"
      puts "  Check alerts for details"
    end
    
    # Response code analysis
    puts "\n📊 Response Code Distribution:"
    @stats[:response_codes].sort.each do |code, count|
      percentage = (count.to_f / @stats[:total_requests] * 100).round(2)
      status = case code.to_i
               when 200..299 then "✅"
               when 300..399 then "↗️ "
               when 400..499 then "⚠️ "
               when 500..599 then "❌"
               else "❓"
               end
      puts "  #{status} #{code}: #{count} (#{percentage}%)"
    end
  end
  
  def export_stats(filename = "log_analysis_#{Time.now.strftime('%Y%m%d_%H%M%S')}.json")
    data = {
      analysis_timestamp: Time.now.iso8601,
      log_format: @log_format,
      statistics: @stats,
      alerts: @alerts,
      blacklisted_ips: @ip_blacklist.to_a
    }
    
    File.write(filename, JSON.pretty_generate(data))
    puts "📄 Analysis exported to: #{filename}"
  end
  
  private
  
  def initialize_stats
    {
      total_requests: 0,
      unique_ips: Set.new,
      response_codes: Hash.new(0),
      request_methods: Hash.new(0),
      top_pages: Hash.new(0),
      hourly_traffic: Hash.new(0),
      error_by_ip: Hash.new(0),
      suspicious_requests: 0,
      bytes_transferred: 0,
      first_request_time: nil,
      last_request_time: nil
    }
  end
  
  def parse_and_analyze_line(line, line_number = nil)
    return if line.strip.empty?
    
    case @log_format
    when :apache, :nginx
      parse_web_log(line, line_number)
    when :rails
      parse_rails_log(line, line_number)
    when :generic
      parse_generic_log(line, line_number)
    end
  end
  
  def parse_web_log(line, line_number)
    match = line.match(@pattern)
    return unless match
    
    ip = match[1]
    timestamp_str = match[2]
    method = match[3]
    path = match[4]
    protocol = match[5]
    status_code = match[6]
    bytes = match[7] == '-' ? 0 : match[7].to_i
    
    timestamp = parse_timestamp(timestamp_str)
    
    update_stats(ip, timestamp, method, path, status_code, bytes)
    check_for_security_issues(ip, path, status_code, line_number)
  end
  
  def parse_rails_log(line, line_number)
    match = line.match(@pattern)
    return unless match
    
    level = match[1]
    timestamp_str = match[2]
    severity = match[3]
    message = match[4]
    
    timestamp = Time.parse(timestamp_str) rescue Time.now
    
    @stats[:total_requests] += 1
    @stats[:first_request_time] ||= timestamp
    @stats[:last_request_time] = timestamp
    
    if %w[ERROR FATAL].include?(severity)
      create_alert("Rails Error", "#{severity}: #{message}", line_number)
    end
  end
  
  def parse_generic_log(line, line_number)
    match = line.match(@pattern)
    return unless match
    
    timestamp_str = match[1]
    level = match[2]
    message = match[3]
    
    timestamp = Time.parse(timestamp_str) rescue Time.now
    
    @stats[:total_requests] += 1
    @stats[:first_request_time] ||= timestamp
    @stats[:last_request_time] = timestamp
    
    if %w[ERROR FATAL CRITICAL].include?(level.upcase)
      create_alert("Application Error", "#{level}: #{message}", line_number)
    end
  end
  
  def update_stats(ip, timestamp, method, path, status_code, bytes)
    @stats[:total_requests] += 1
    @stats[:unique_ips].add(ip)
    @stats[:response_codes][status_code] += 1
    @stats[:request_methods][method] += 1
    @stats[:top_pages][path] += 1
    @stats[:bytes_transferred] += bytes
    @stats[:first_request_time] ||= timestamp
    @stats[:last_request_time] = timestamp
    
    hour_key = timestamp.strftime('%Y-%m-%d %H:00')
    @stats[:hourly_traffic][hour_key] += 1
    
    # Track errors by IP
    if status_code.to_i >= 400
      @stats[:error_by_ip][ip] += 1
    end
  end
  
  def check_for_security_issues(ip, path, status_code, line_number)
    # Check for suspicious patterns
    @suspicious_patterns.each do |pattern|
      if path.match?(pattern)
        @stats[:suspicious_requests] += 1
        create_alert(
          "Suspicious Request",
          "Potential attack from #{ip}: #{path}",
          line_number
        )
        break
      end
    end
    
    # Auto-blacklist IPs with too many errors
    if @stats[:error_by_ip][ip] > @error_threshold && !@ip_blacklist.include?(ip)
      @ip_blacklist.add(ip)
      create_alert(
        "IP Blacklisted",
        "IP #{ip} blacklisted for #{@stats[:error_by_ip][ip]} errors",
        line_number
      )
    end
  end
  
  def create_alert(type, message, line_number = nil)
    alert = {
      timestamp: Time.now.iso8601,
      type: type,
      message: message,
      line_number: line_number
    }
    
    @alerts << alert
    puts "🚨 ALERT [#{type}]: #{message}" + (line_number ? " (line #{line_number})" : "")
  end
  
  def check_real_time_alerts
    # Check recent error rates
    recent_errors = @alerts.select do |alert|
      Time.parse(alert[:timestamp]) > Time.now - 60 # Last minute
    end
    
    if recent_errors.length > 5
      puts "🚨 HIGH ALERT: #{recent_errors.length} alerts in the last minute!"
    end
  end
  
  def parse_timestamp(timestamp_str)
    # Handle different timestamp formats
    Time.parse(timestamp_str.gsub(/\//, '-'))
  rescue
    Time.now
  end
  
  def generate_report
    puts "\n📊 LOG ANALYSIS REPORT"
    puts "=" * 50
    
    duration = @stats[:last_request_time] - @stats[:first_request_time]
    
    puts "📈 Summary:"
    puts "  Total Requests: #{@stats[:total_requests]}"
    puts "  Unique IPs: #{@stats[:unique_ips].size}"
    puts "  Time Period: #{@stats[:first_request_time]} to #{@stats[:last_request_time]}"
    puts "  Duration: #{(duration / 3600).round(2)} hours"
    puts "  Avg Requests/Hour: #{(@stats[:total_requests] / (duration / 3600)).round(2)}"
    puts "  Data Transferred: #{format_bytes(@stats[:bytes_transferred])}"
    
    # Top pages
    puts "\n📄 Top Requested Pages:"
    @stats[:top_pages].sort_by { |_, count| -count }.first(10).each do |page, count|
      puts "  #{page}: #{count} requests"
    end
    
    # Traffic by hour
    puts "\n⏰ Hourly Traffic (last 24 hours):"
    recent_hours = @stats[:hourly_traffic].select do |hour, _|
      Time.parse(hour) > Time.now - (24 * 3600)
    end
    
    recent_hours.sort.last(10).each do |hour, count|
      puts "  #{hour}: #{count} requests"
    end
    
    generate_security_report
    
    puts "\n🚨 Total Alerts: #{@alerts.length}"
  end
  
  def format_bytes(bytes)
    units = ['B', 'KB', 'MB', 'GB', 'TB']
    size = bytes.to_f
    unit_index = 0
    
    while size >= 1024 && unit_index < units.length - 1
      size /= 1024
      unit_index += 1
    end
    
    "#{size.round(2)} #{units[unit_index]}"
  end
end

# CLI Interface
class LogAnalyzerCLI
  def initialize
    @analyzer = nil
  end
  
  def start
    puts "📊 Log Analyzer and Security Monitor"
    puts "=" * 40
    
    loop do
      display_menu
      choice = gets.chomp.to_i
      
      case choice
      when 1 then analyze_file
      when 2 then monitor_file
      when 3 then configure_analyzer
      when 4 then export_results
      when 5 then generate_sample_log
      when 6
        puts "👋 Goodbye!"
        break
      else
        puts "❌ Invalid option"
      end
    end
  end
  
  private
  
  def display_menu
    puts "\n📋 Options:"
    puts "1. Analyze log file"
    puts "2. Monitor log file (real-time)"
    puts "3. Configure analyzer"
    puts "4. Export analysis results"
    puts "5. Generate sample log file"
    puts "6. Exit"
    print "Choose option (1-6): "
  end
  
  def analyze_file
    print "📁 Enter log file path: "
    file_path = gets.chomp
    
    if File.exist?(file_path)
      @analyzer ||= LogAnalyzer.new
      @analyzer.analyze_file(file_path)
    else
      puts "❌ File not found: #{file_path}"
    end
  end
  
  def monitor_file
    print "📁 Enter log file path to monitor: "
    file_path = gets.chomp
    
    if File.exist?(file_path)
      @analyzer ||= LogAnalyzer.new
      @analyzer.monitor_file(file_path)
    else
      puts "❌ File not found: #{file_path}"
    end
  end
  
  def configure_analyzer
    puts "🔧 Available log formats:"
    LogAnalyzer::LOG_PATTERNS.keys.each_with_index do |format, index|
      puts "  #{index + 1}. #{format}"
    end
    
    print "Choose format: "
    choice = gets.chomp.to_i - 1
    formats = LogAnalyzer::LOG_PATTERNS.keys
    
    if choice.between?(0, formats.length - 1)
      @analyzer = LogAnalyzer.new(formats[choice])
      puts "✅ Analyzer configured for #{formats[choice]} format"
    else
      puts "❌ Invalid choice"
    end
  end
  
  def export_results
    if @analyzer
      @analyzer.export_stats
    else
      puts "❌ No analysis results to export. Analyze a file first."
    end
  end
  
  def generate_sample_log
    puts "🔧 Generating sample Apache log file..."
    
    sample_entries = [
      '192.168.1.100 - - [25/Dec/2023:10:00:01 +0000] "GET /index.html HTTP/1.1" 200 1024',
      '10.0.0.5 - - [25/Dec/2023:10:00:02 +0000] "POST /login HTTP/1.1" 200 512',
      '203.0.113.1 - - [25/Dec/2023:10:00:03 +0000] "GET /admin/../../../etc/passwd HTTP/1.1" 404 0',
      '192.168.1.100 - - [25/Dec/2023:10:00:04 +0000] "GET /products HTTP/1.1" 200 2048',
      '198.51.100.1 - - [25/Dec/2023:10:00:05 +0000] "GET /search?q=<script>alert(1)</script> HTTP/1.1" 400 0'
    ]
    
    File.write('sample.log', sample_entries.join("\n") + "\n")
    puts "✅ Sample log created: sample.log"
  end
end

# Run the application
if __FILE__ == $0
  cli = LogAnalyzerCLI.new
  cli.start
end
