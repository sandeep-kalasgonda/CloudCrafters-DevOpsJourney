FROM node:18

# Set the working directory
WORKDIR /app

# Copy package.json and install dependencies
COPY package.json package-lock.json ./
RUN npm install

# Copy the application code
COPY . .

# Expose the app's port (e.g., 3000)
EXPOSE 3000

# Start the application
CMD ["npm", "start"]
