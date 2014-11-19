FROM debian:latest

MAINTAINER Thom May <thom@scaleworks.io>

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get -y update && apt-get install -qy build-essential libffi-dev libgdbm-dev libncurses5-dev libreadline-dev libssl-dev libyaml-dev zlib1g-dev curl libyaml-0-2 libxml2-dev libxslt-dev

RUN mkdir -p /usr/local/src
WORKDIR /usr/local/src

# Build latest ruby version, and install it in /usr/local
RUN curl -O http://cache.ruby-lang.org/pub/ruby/2.1/ruby-2.1.4.tar.bz2 \
  && tar xjf ruby-2.1.4.tar.bz2 \
  && cd ruby-2.1.4 \
  && ./configure --prefix=/usr/local \
  && make && make install \
  && /usr/local/bin/gem install --no-rdoc --no-ri bundler nokogiri puma \
  && rm -r /usr/local/src

RUN apt-get -qy remove  build-essential libffi-dev libgdbm-dev libncurses5-dev libreadline-dev libssl-dev libyaml-dev zlib1g-dev \
  build-essential cpp cpp-4.7 dpkg-dev fakeroot g++ g++-4.7 gcc gcc-4.7 libalgorithm-diff-perl binutils \
  libalgorithm-diff-xs-perl libalgorithm-merge-perl  libc-dev-bin libc6-dev libffi-dev \
  libfile-fcntllock-perl libgdbm-dev  libncurses5-dev libreadline-dev libreadline6-dev  libssl-dev libssl-doc \
  libtimedate-perl libtinfo-dev libyaml-dev linux-libc-dev make manpages manpages-dev patch zlib1g-dev \
  libxml2-dev libxslt-dev perl perl-modules
