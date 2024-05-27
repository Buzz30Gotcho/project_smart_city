# Use the official Flutter image as a base image
FROM cirrusci/flutter:3.19.0

# Set the working directory
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Run flutter doctor to pre-cache necessary components
RUN flutter doctor

# Expose port 8000 for web
EXPOSE 8000

# Default command
CMD ["bash"]
