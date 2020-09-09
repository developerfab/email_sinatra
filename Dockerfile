FROM ruby:2.6.5

WORKDIR /app
ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock
RUN gem install bundler

RUN bundle install
ADD . /app

EXPOSE 4567

CMD ruby server.rb -o 0.0.0.0 -p 4567
