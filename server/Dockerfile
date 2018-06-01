FROM ruby:2.5

WORKDIR /server_app

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .