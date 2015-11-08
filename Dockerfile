FROM debian:jessie-backports

RUN apt-get update && apt-get install -y \
    curl \
    git \
    build-essential \
    libmysqlclient-dev \
    libicu-dev \
    libtool \
    libpng-dev \
    libgif-dev \
    libjpeg-dev \
    libtiff-dev \
    libfreetype6-dev \
    libssl-dev \
    libexpat-dev \
    libzip-dev \
    libxpm-dev \
    libgd2-xpm-dev \
    libxml2-dev \
    libdb-dev \
    libyaml-dev \
    libxslt-dev \
    libcurl4-openssl-dev \
    libpcre3-dev \
    libgmp-dev \
    zlib1g-dev \
    libjson-c-dev \
    groff \
    automake \
    libevent-dev \
    libncurses5-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    mkdir /build

ADD ./plenv.sh /etc/profile.d/plenv.sh

WORKDIR /build
ADD ./perls.txt perls.txt
ADD ./install_perl.sh install_perl.sh

RUN ./install_perl.sh

ADD ./mods.txt mods.txt
ADD ./install_mods.sh install_mods.sh

RUN . /etc/profile && plenv versions && ./install_mods.sh
