# syntax=docker/dockerfile:1.4

FROM ubuntu:24.04 as base

LABEL maintainer="ZX Spectrum Developer"
LABEL description="Docker image for building ZX Spectrum software"

# Avoid interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install common build dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends git build-essential wget curl gcc make autoconf \
    automake libtool pkg-config libspectrum-dev zlib1g-dev libglib2.0-dev ca-certificates libboost-program-options-dev libasound2-dev libpulse-dev && \
    rm -rf /var/lib/apt/lists/*


# sjasmplus builder stage
FROM base as sjasmplus-builder
WORKDIR /src/sjasmplus
# Copy the entire tools directory (which includes submodules)
COPY tools/sjasmplus .
RUN make


# zx0 builder stage
FROM base as zx0-builder
WORKDIR /src/zx0
COPY tools/zx0 .
WORKDIR /src/zx0/src
RUN gcc -o /usr/local/bin/zx0 zx0.c optimize.c compress.c memory.c


# fuse-emulator-utils builder stage
FROM base as fuse-utils-builder
WORKDIR /src/fuse-emulator-utils
COPY tools/fuse-emulator-utils .
RUN ./autogen.sh && \
    ./configure --prefix=/tmp && \
    make && \
    make install-exec


# mctrd builder stage
FROM base as mctrd-builder
WORKDIR /src/mctrd
COPY tools/mctrd .
RUN make


# mhmt builder stage
FROM base as mhmt-builder
WORKDIR /src/mhmt
COPY tools/mhmt .
WORKDIR /src/mhmt/src
RUN gcc -std=c99 -O2 -flto -fomit-frame-pointer -pedantic-errors -g -D_POSIX_C_SOURCE=1 -U__STRICT_ANSI__ \
    -Wno-shift-negative-value -o /usr/local/bin/mhmt mhmt-emit.c mhmt-globals.c mhmt-hash.c mhmt-lz.c mhmt-main.c \
    mhmt-optimal.c mhmt-pack.c mhmt-parsearg.c mhmt-tb.c mhmt-depack.c -lm


# lzsa builder stage
FROM base as lzsa-builder
WORKDIR /src/lzsa
COPY tools/lzsa .
RUN make CC=gcc


# zxtune builder stage
FROM base as zxtune-builder
WORKDIR /src/zxtune
COPY tools/zxtune .
RUN make -C apps/zxtune123 platform=linux system.zlib=1


# Final stage - collect all built binaries
FROM ubuntu:24.04

# Avoid interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install runtime dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends ca-certificates libspectrum8 zlib1g make libboost-program-options1.83.0 && \
    rm -rf /var/lib/apt/lists/*

# Copy all built binaries from their respective builder stages
COPY --from=sjasmplus-builder /src/sjasmplus/sjasmplus /usr/local/bin/
COPY --from=zx0-builder /usr/local/bin/zx0 /usr/local/bin/
COPY --from=fuse-utils-builder /tmp/bin/ /usr/local/bin/
COPY --from=mctrd-builder /src/mctrd/mctrd /usr/local/bin/
COPY --from=mhmt-builder /usr/local/bin/mhmt /usr/local/bin/
COPY --from=lzsa-builder /src/lzsa/lzsa /usr/local/bin/
COPY --from=zxtune-builder /src/zxtune/apps/zxtune123/../../bin/linux/release/zxtune123 /usr/local/bin/

# Create workspace directory
WORKDIR /workspace

# Default command
CMD ["/bin/bash"]
