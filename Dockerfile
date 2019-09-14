FROM ruby:2.5

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

RUN mkdir /myapp

WORKDIR /hour-control
COPY Gemfile /hour-control/Gemfile
COPY Gemfile.lock /hour-control/Gemfile.lock

RUN bundle install

COPY . /hour-control

LABEL maintainer="Fernando Demarchi Natividade Luiz <nativanando@gmail.com>"
