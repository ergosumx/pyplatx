# Start with latest Ubuntu image
FROM ubuntu:latest

# Create pyplatax directory 
RUN mkdir -p /pyplatax  

# Set working directory
WORKDIR /pyplatax

# Copy current directory contents into /pyplatax  
COPY . /pyplatax   

# Set default command
CMD ["--help"]