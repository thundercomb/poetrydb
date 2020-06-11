FROM ruby:2.6.0
RUN apt-get update
RUN apt-get install -y mongodb-clients

RUN mkdir /poetrydb
COPY ./ /poetrydb
WORKDIR /poetrydb/app
RUN bundle install
