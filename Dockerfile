# Use a lean Node.js base image
FROM node:18-alpine

# Set the working directory in the container
WORKDIR /app

# Copy package.json and package-lock.json to leverage Docker caching
# This ensures that npm install is only run if package.json changes
COPY package*.json ./

# Install application dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Expose the port your app listens on (if applicable)
EXPOSE 3000

# Command to run the application when the container starts
CMD ["npm", "start"]