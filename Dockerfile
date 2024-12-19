# syntax=docker/dockerfile:1
FROM debian:bookworm as gcc-cross

RUN apt-get update && apt-get install -y gcc make gcc-mingw-w64 gcc-i686-linux-gnu


COPY <<-"EOF" build.sh
#!/bin/sh
echo "Miniaudio cross build"
#make crossbuild
EOF

RUN chmod +x build.sh
RUN ./build.sh

WORKDIR /usr/src
