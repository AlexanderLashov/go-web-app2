# Step 1: Download and extract the latest release
FROM alpine:latest AS unzipper

RUN apk add --no-cache unzip wget curl jq

ENV REPO_OWNER=AlexanderLashov
ENV REPO_NAME=go-web-app

# Fetch the tarball URL
RUN curl -s https://api.github.com/repos/AlexanderLashov/go-web-app/releases/latest | jq -r '.assets[] | select(.name | test("^go-web-app.*\\.tar\\.gz$")) | .browser_download_url' > tarball_url.txt

# Download the tarball
RUN wget $(cat tarball_url.txt) -O source.tar.gz

# Extract the tar.gz file to /tmp
RUN tar -xzf source.tar.gz -C /tmp

# Step 2: Create a lightweight image to run the application
FROM alpine:latest

# Install glibc
RUN apk add --no-cache libc6-compat

# Copy the Pre-built binary file from the unzipper stage
COPY --from=unzipper /tmp/go-web-app /go-web-app

# Ensure the binary is executable
RUN chmod +x /go-web-app

EXPOSE 8080

# Command to run the executable
CMD ["/go-web-app"]