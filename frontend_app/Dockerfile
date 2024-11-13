# Use an official Node.js runtime as a parent image
FROM node:18-alpine AS builder

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json for dependency installation
COPY package.json package-lock.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application source code
COPY . .

# Build the Next.js application
RUN npm run build

# Use a lightweight image for serving the application
FROM node:18-alpine

# Set the working directory
WORKDIR /app

# Copy only the necessary files from the builder stage
COPY --from=builder /app/package.json /app/package-lock.json /app/.next /app/public /app/src .

# Install only production dependencies
RUN npm install --production

# Expose port 3000 for the application
EXPOSE 3000

# Start the Next.js application
CMD ["npm", "run", "start"]



