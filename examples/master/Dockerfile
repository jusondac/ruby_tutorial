# Dockerfile for Ruby Microservice
# Multi-stage build for production optimization

# Build stage
FROM ruby:3.1-alpine AS builder

# Install build dependencies
RUN apk add --no-cache \
    build-base \
    sqlite-dev \
    postgresql-dev

WORKDIR /app

# Copy Gemfile and install gems
COPY Gemfile Gemfile.lock ./
RUN bundle config --global frozen 1 && \
    bundle install --without development test

# Production stage
FROM ruby:3.1-alpine AS production

# Install runtime dependencies
RUN apk add --no-cache \
    sqlite \
    postgresql-client \
    redis

# Create non-root user
RUN addgroup -g 1000 -S appuser && \
    adduser -u 1000 -S appuser -G appuser

WORKDIR /app

# Copy application files
COPY --from=builder /usr/local/bundle /usr/local/bundle
COPY --chown=appuser:appuser . .

# Switch to non-root user
USER appuser

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:4567/health || exit 1

# Expose port
EXPOSE 4567

# Start the service
CMD ["ruby", "microservice_api.rb"]
