ARG BUILD_FROM=ghcr.io/hassio-addons/debian-base:7.7.1
FROM ${BUILD_FROM}

ARG SPOOLMAN_VERSION="v0.21.0"

# Install dependencies
RUN apt-get update && apt-get install -y \
    unzip curl jq g++ python3-dev libffi-dev python3-pip python3-setuptools python3-wheel python3-pdm && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Download files
RUN rm -rf /var/spoolman && \
    mkdir -p /var/spoolman && \
    source_url=$(curl -s https://api.github.com/repos/Donkie/Spoolman/releases/tags/${SPOOLMAN_VERSION} | jq -r '.assets[] | select(.name == "spoolman.zip").browser_download_url') && \
    curl -sSL $source_url -o temp.zip && unzip temp.zip -d /var/spoolman && rm temp.zip

WORKDIR /var/spoolman

COPY ./scripts/install.sh /var/spoolman/install.sh
COPY ./scripts/start.sh /var/spoolman/start.sh

RUN chmod a+x /var/spoolman/install.sh && \
    chmod a+x /var/spoolman/start.sh && \
    bash /var/spoolman/install.sh

# Run command
EXPOSE 7912
ENTRYPOINT ["/var/spoolman/start.sh"]