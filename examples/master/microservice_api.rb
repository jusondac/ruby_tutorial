#!/usr/bin/env ruby
# Master Level Example: Microservice API with Docker Integration
# Demonstrates: Advanced Ruby patterns, API design, containerization, testing

require 'sinatra'
require 'json'
require 'logger'
require 'redis'
require 'sequel'

# Advanced Ruby Microservice API
class UserService < Sinatra::Base
  configure do
    set :logging, true
    set :dump_errors, false
    set :raise_errors, true
    
    # Database connection
    DB = Sequel.connect(ENV['DATABASE_URL'] || 'sqlite://users.db')
    
    # Redis for caching
    REDIS = Redis.new(url: ENV['REDIS_URL'] || 'redis://localhost:6379')
    
    # Logger configuration
    LOGGER = Logger.new(STDOUT)
    LOGGER.level = Logger::INFO
  end
  
  # Middleware for JSON parsing
  before do
    content_type :json
    if request.content_type == 'application/json'
      body = request.body.read
      @json = JSON.parse(body) unless body.empty?
    end
  rescue JSON::ParserError
    halt 400, { error: 'Invalid JSON' }.to_json
  end
  
  # Health check endpoint
  get '/health' do
    {
      status: 'healthy',
      timestamp: Time.now.iso8601,
      version: '1.0.0'
    }.to_json
  end
  
  # Get all users with pagination and caching
  get '/users' do
    page = params[:page]&.to_i || 1
    limit = params[:limit]&.to_i || 10
    cache_key = "users:page:#{page}:limit:#{limit}"
    
    # Try cache first
    cached_result = REDIS.get(cache_key)
    if cached_result
      LOGGER.info "Cache hit for #{cache_key}"
      return cached_result
    end
    
    # Database query with pagination
    users = User.limit(limit, (page - 1) * limit).all
    result = {
      users: users.map(&:to_hash),
      pagination: {
        page: page,
        limit: limit,
        total: User.count
      }
    }.to_json
    
    # Cache for 5 minutes
    REDIS.setex(cache_key, 300, result)
    LOGGER.info "Cache miss for #{cache_key}, stored result"
    
    result
  end
  
  # Create new user with validation
  post '/users' do
    halt 400, { error: 'Missing required data' }.to_json unless @json
    
    user = User.new(@json)
    
    if user.valid?
      user.save
      REDIS.del('users:*') # Invalidate cache
      status 201
      user.to_hash.to_json
    else
      halt 422, { errors: user.errors.full_messages }.to_json
    end
  rescue Sequel::ValidationFailed => e
    halt 422, { errors: e.message }.to_json
  end
  
  # Get specific user
  get '/users/:id' do
    user = User[params[:id]]
    halt 404, { error: 'User not found' }.to_json unless user
    
    user.to_hash.to_json
  end
  
  # Update user
  put '/users/:id' do
    halt 400, { error: 'Missing required data' }.to_json unless @json
    
    user = User[params[:id]]
    halt 404, { error: 'User not found' }.to_json unless user
    
    user.update(@json)
    REDIS.del('users:*') # Invalidate cache
    user.to_hash.to_json
  rescue Sequel::ValidationFailed => e
    halt 422, { errors: e.message }.to_json
  end
  
  # Delete user
  delete '/users/:id' do
    user = User[params[:id]]
    halt 404, { error: 'User not found' }.to_json unless user
    
    user.destroy
    REDIS.del('users:*') # Invalidate cache
    status 204
  end
  
  # Error handlers
  error 500 do
    LOGGER.error "Internal server error: #{env['sinatra.error']}"
    { error: 'Internal server error' }.to_json
  end
  
  error 404 do
    { error: 'Not found' }.to_json
  end
end

# User model with validations
class User < Sequel::Model
  plugin :validation_helpers
  plugin :json_serializer
  
  def validate
    super
    validates_presence [:name, :email]
    validates_unique :email
    validates_format /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i, :email
  end
  
  def to_hash
    {
      id: id,
      name: name,
      email: email,
      created_at: created_at,
      updated_at: updated_at
    }
  end
end

# Database migration
unless DB.table_exists?(:users)
  DB.create_table :users do
    primary_key :id
    String :name, null: false
    String :email, null: false, unique: true
    DateTime :created_at, default: Sequel::CURRENT_TIMESTAMP
    DateTime :updated_at, default: Sequel::CURRENT_TIMESTAMP
  end
end

# Run the service
if __FILE__ == $0
  UserService.run! host: '0.0.0.0', port: ENV['PORT'] || 4567
end
