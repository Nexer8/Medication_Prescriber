# Stage 1 - Install dependencies and build the app in a build environment
FROM cirrusci/flutter:2.0.0 AS build-env

# Run flutter doctor
RUN flutter doctor -v

# Copy files to container and build
RUN mkdir /app/
COPY . /app/
WORKDIR /app/
RUN flutter build web

# Stage 2 - Create the run-time image
FROM nginx:1.21.1-alpine
COPY --from=build-env /app/build/web /usr/share/nginx/html
