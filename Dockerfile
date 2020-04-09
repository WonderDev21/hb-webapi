FROM ruby:2.6.3

RUN apt-get update -qq && \
    apt-get install -y build-essential \
                       default-mysql-client \
                       vim \
                       --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

# Configure the main working directory. This is the base
# directory used in any further RUN, COPY, and ENTRYPOINT
# commands.
RUN mkdir -p /app
WORKDIR /app

# Copy the Gemfile as well as the Gemfile.lock and install
# the RubyGems. This is a separate step so the dependencies
# will be cached unless changes to one of those two files
# are made.
ADD Gemfile /app
ADD Gemfile.lock /app
RUN gem install bundler
RUN bundle install --jobs 8 --retry 5

# Copy the main application.
ADD . /app

# Start puma
CMD bundle exec puma -C config/puma.rb
