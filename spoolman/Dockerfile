ARG BUILD_FROM=ghcr.io/hassio-addons/base:18.0.3
FROM ${BUILD_FROM}

ARG SPOOLMAN_VERSION
ENV PATH="/var/spoolman/.venv/bin:${PATH}"

WORKDIR /var/spoolman

# Install dependencies and download Spoolman from the official GitHub release
RUN apk add --no-cache \
    unzip \
    g++ \
    python3-dev \
    libffi-dev \
    py3-pip \
    py3-setuptools \
    py3-wheel \
    py3-pdm-backend \
    py3-virtualenv \
    curl \
    jq \
    && curl -sSL $(curl -s https://api.github.com/repos/Donkie/Spoolman/releases/tags/${SPOOLMAN_VERSION} | jq -r '.assets[] | select(.name == "spoolman.zip").browser_download_url') -o /tmp/spoolman.zip \
    && unzip /tmp/spoolman.zip -d /var/spoolman \
    && rm /tmp/spoolman.zip \
    && bash /var/spoolman/scripts/install.sh
# End of Install dependencies and download Spoolman

# Correct the start command
COPY ./scripts/start.sh /var/spoolman/start.sh
RUN chmod a+x /var/spoolman/start.sh

# Run command
EXPOSE 7912
ENTRYPOINT ["bashio", "/var/spoolman/start.sh"]
