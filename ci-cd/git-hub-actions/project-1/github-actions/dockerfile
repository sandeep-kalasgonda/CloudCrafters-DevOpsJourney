# Use the official Node.js image as a base
FROM node:18

# Set the working directory inside the container
WORKDIR /app

# Copy the package.json and package-lock.json files into the container
COPY package*.json ./

# Install the dependencies inside the container
RUN npm install

# Copy the rest of the application files into the container
COPY . .

# Expose the port your app will run on (e.g., 3000)
EXPOSE 3000

# Run the app when the container starts
# CMD ["node", "index.js"]
CMD ["npm", "start"]


