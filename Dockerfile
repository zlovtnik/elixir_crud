###############################################
# Stage 1: Build the Elixir application
###############################################
FROM elixir:latest AS builder

# Install build dependencies
RUN apt-get update -y && \
    apt-get install -y build-essential git npm && \
    apt-get clean && \
    rm -f /var/lib/apt/lists/*_*

# Set environment variables
ENV MIX_ENV=prod \
    LANG=C.UTF-8

# Install hex and rebar
RUN mix local.hex --force && \
    mix local.rebar --force

# Create app directory and copy the Elixir project into it
WORKDIR /app
COPY backend/mix.exs backend/mix.lock ./
COPY backend/config config
COPY backend/priv priv
COPY backend/lib lib

# Install dependencies and compile
RUN mix deps.get --only prod && \
    mix deps.compile && \
    mix compile

# Compile assets
RUN mix phx.digest

# Build the release
RUN mix release

###############################################
# Stage 2: Create the final image
###############################################
FROM debian:bookworm-slim

# Install runtime dependencies including postgres client for health checks
RUN apt-get update -y && \
    apt-get install -y libstdc++6 openssl libncurses5 locales ca-certificates postgresql-client && \
    apt-get clean && \
    rm -f /var/lib/apt/lists/*_*

# Set environment variables
ENV LANG=C.UTF-8 \
    MIX_ENV=prod \
    PORT=4000

# Create a non-root user and set proper permissions
RUN useradd --create-home app
WORKDIR /home/app

# Copy the release from the builder stage
COPY --from=builder --chown=app:app /app/_build/prod/rel/erp ./

# Copy the entrypoint script
COPY backend/entrypoint.sh ./entrypoint.sh
RUN chmod +x ./entrypoint.sh

# Set user
USER app

# Set the entrypoint
ENTRYPOINT ["./entrypoint.sh"]

# Expose the port
EXPOSE 4000
