FROM node:26-bookworm-slim

# Install Python 3, pip, and SSL certificates (needed for HTTPSHandler / Wrangler)
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3 \
    python3-pip \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Install Wrangler globally and cronsim for the Python launcher
RUN npm install -g wrangler && \
    pip3 install --no-cache-dir --break-system-packages cronsim

WORKDIR /app

# Copy worker, wrangler.toml, and Python launcher
COPY proxy_cloudflare.js wrangler.toml run_proxy_js.py ./

EXPOSE 9443

CMD ["python3", "-u", "./run_proxy_js.py", "--port", "9443"]
