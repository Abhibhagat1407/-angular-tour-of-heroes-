# Stage 1: Build the Angular application
FROM node:18 as build

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY package.json package-lock.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application files
COPY . .

# Build the Angular application
RUN npm run build --prod

# Stage 2: Serve the Angular application using Nginx
FROM nginx:alpine

# Copy the built Angular application from the previous stage
COPY --from=build /app/dist/angular-tour-of-heroes /usr/share/nginx/html

# Expose port 80 (default port for HTTP)
EXPOSE 80

# Command to start Nginx (it starts automatically with the base image)

