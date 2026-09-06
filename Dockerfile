FROM ruby:3.0.5-alpine

# install build dependencies
RUN apk add --no-cache build-base tzdata nodejs gcompat

# set working dir
WORKDIR /app

# copy Gemfile and Gemfile.lock and install dependencies
COPY Gemfile Gemfile.lock ./
RUN bundle install

# copy the rest of the application code
COPY . .

# start the server
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]