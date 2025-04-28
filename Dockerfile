FROM ubuntu:22.04

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    python3 \
    python3-pip \
    git \
    wget \
    tar \
    zlib1g-dev \
    libcurl4-openssl-dev \
    libssl-dev \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /opt

# Fix python missing symlink (python -> python3)
RUN ln -s /usr/bin/python3 /usr/bin/python

# Install ParallelTask (required by NextPolish)
RUN pip3 install paralleltask

# Install NextDenovo
RUN git clone https://github.com/Nextomics/NextDenovo.git && \
    cd NextDenovo && \
    make

# Add NextDenovo to PATH (the bin directory)
ENV PATH="/opt/NextDenovo/:${PATH}"

# Default command
CMD ["/bin/bash"]
