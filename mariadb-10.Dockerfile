FROM mariadb:lts

RUN apt-get update -y && \
   apt-get upgrade -y && \
   apt-get dist-upgrade -y && \
   apt-get update -y && \
   apt-get -y --no-install-recommends --allow-unauthenticated install \
   build-essential \
   git \
   ca-certificates \
   xz-utils \
   zip \
   unzip \
   curl \
   gcc \
   make  \
   cmake  \
   libssl-dev \
   libmariadb3 \
   libmariadb-dev

RUN mkdir -p /src/workspace
VOLUME mkdir -p /tmp/build_output

COPY . /src/workspace
WORKDIR /src/workspace

VOLUME /src/workspace
VOLUME /tmp/build_output

# CMD cd /src/workspace && \
#    git clone --branch 2.0.2 --recursive https://github.com/juanmirocks/Levenshtein-MySQL-UDF.git && \
#    cd Levenshtein-MySQL-UDF && \

CMD ls && \
   gcc -DHAVE_DLOPEN -DSTANDARD -o /tmp/build_output/levenshtein.so -shared -fPIC levenshtein.c `/usr/bin/mariadb_config --include` && \
   cd /tmp/build_output && \
   ls && \
   zip -r levenshtein-v1.0.0-mariadb-10.zip . && \
   ls && \
   exit
