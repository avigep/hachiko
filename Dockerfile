FROM ruby:2.6-alpine

RUN apk update && apk upgrade && \
    apk add ruby ruby-bundler ruby-irb tzdata &&\
    apk add nodejs && apk add curl-dev ruby-dev build-base libffi-dev &&\
    apk add build-base libxslt-dev libxml2-dev ruby-rdoc mysql-dev

RUN mkdir /hachiko
WORKDIR /hachiko

COPY Gemfile Gemfile.lock ./
RUN gem install bundler:2.1.4
RUN bundle install --binstubs

COPY . .

EXPOSE 3000

ENTRYPOINT ["sh", "./config/docker/startup.sh"]

