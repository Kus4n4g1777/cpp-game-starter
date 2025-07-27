# Stage 1: Build the application
FROM debian:bookworm-slim AS builder

# Install necessary build tools
# Using apt-get update and install is standard for Debian-based images
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory inside the container
WORKDIR /app

# Copy the CMakeLists.txt and source files
# This helps optimize Docker cache by only re-copying and rebuilding if these change
COPY CMakeLists.txt .
COPY src/ ./src/

# Configure and build the project
RUN cmake -B build -S .
RUN cmake --build build

# Stage 2: Create the final runtime image
FROM debian:bookworm-slim AS runner

# Install any runtime dependencies if your application needs them
# For a simple "Hello World", build-essential isn-t needed at runtime.
# If your game used SDL, you'd install libsdl2-2.0-0 here, for example.
RUN apt-get update && apt-get install -y \
    libstdc++6 \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /app

# Copy the compiled executable from the builder stage
COPY --from=builder /app/build/my_game .

# Command to run the application when the container starts
CMD ["./my_game"]
